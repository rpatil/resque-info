module ResqueInfo
  class << self
    def total_retried_jobs
      resque_redis.get("resque:stat:retried").to_i
    end

    def retry_success_rate
      retried_jobs = total_retried_jobs
      successful_retries = resque_redis.get("resque:stat:successful_retries").to_i
      retried_jobs.zero? ? 0 : ((successful_retries.to_f / retried_jobs) * 100).round(2)
    end

    #### Longest-Running-Jobs
    #### Identify the jobs that took the most time to process.
    def longest_running_jobs(limit = 5)
      resque_redis.zrevrange("resque:stat:longest_jobs", 0, limit - 1).map do |entry|
        job_data = JSON.parse(entry)
        {
          job: job_data['job'],
          duration: job_data['duration'],
          completed_at: Time.at(job_data['timestamp'])
        }
      end
    end

    #### Failed Jobs by Time of Day
    #### Analyze when most failures occur to identify patterns (e.g., peak failure hours).
    def failed_jobs_by_hour
      failed_jobs = resque_failed_jobs.all(0, resque_failed_jobs.count)
      hourly_data = Array.new(24, 0)

      failed_jobs.each do |job|
        hour = Time.parse(job['failed_at']).hour
        hourly_data[hour] += 1
      end

      hourly_data
    end

    #### Job-Retry-Trends
    #### Track retries over time (e.g., daily or weekly).
    def retry_trends(days = 7)
      Array.new(days) do |i|
        date = (Date.today - i).strftime("%Y-%m-%d")
        retries = resque_redis.get("resque:stat:retries:#{date}").to_i
        { date: date, retries: retries }
      end
    end

    #### Most Frequent Job Classes
    #### Identify the job classes that are enqueued most often.
    def most_frequent_job_classes(limit = 5)
      resque_redis.zrevrange("resque:stat:job_classes", 0, limit - 1, with_scores: true).map do |job_class, count|
        { job_class: job_class, count: count.to_i }
      end
    end

    #### Jobs Stuck in Queues
    #### Identify jobs stuck in queues for an unusually long time.
    def stuck_jobs(threshold_seconds = 3600)
      resque_queues.each_with_object([]) do |queue, result|
        Resque.peek(queue, 0, Resque.size(queue)).each do |job|
          enqueued_time = job['enqueued_at'] || Time.now.to_i
          wait_time = Time.now.to_i - enqueued_time
          result << { job: job, queue: queue, wait_time: wait_time } if wait_time > threshold_seconds
        end
      end
    end

    #### Most Used Queues
    #### Track queues that are used most frequently.
    def most_used_queues(limit = 5)
      resque_queues.map { |queue| { queue: queue, size: Resque.size(queue) } }
            .sort_by { |q| -q[:size] }
            .first(limit)
    end

    #### Job Arguments Analysis
    #### Common arguments passed to jobs, useful for debugging recurring failures.
    def common_job_arguments(limit = 5)
      resque_redis.zrevrange("resque:stat:job_arguments", 0, limit - 1, with_scores: true).map do |args, count|
        { arguments: JSON.parse(args), count: count.to_i }
      end
    end
  end
end