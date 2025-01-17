module ResqueInfo
  class << self
    #### Idle Time Metrics
    #### Measure how long a worker or queue has been idle.
    def idle_time_per_worker
      resque_workers.each_with_object({}) do |worker, result|
        last_job_time = resque_redis.get("worker:#{worker.id}:last_job_time").to_i
        idle_time = Time.now.to_i - last_job_time
        result[worker.id] = idle_time
      end
    end

    #### Jobs processed per worker.
    def jobs_processed_per_worker
      resque_workers.each_with_object({}) do |worker, result|
        jobs = resque_redis.get("worker:#{worker.id}:jobs_processed").to_i
        result[worker.id] = jobs
      end
    end

    #### Average job completion time per worker.
    def average_job_time_per_worker
      resque_workers.each_with_object({}) do |worker, result|
        total_time = resque_redis.get("worker:#{worker.id}:total_time").to_f
        jobs = resque_redis.get("worker:#{worker.id}:jobs_processed").to_i
        result[worker.id] = jobs.zero? ? 0 : (total_time / jobs).round(2)
      end
    end
  end
end