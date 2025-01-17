module ResqueInfo
  class << self
    def resque_redis
      Resque.redis
    end

    def resque_workers
      Resque.workers
    end

    def resque_queues
      Resque.queues
    end

    def resque_failed_jobs
      Resque::Failure
    end

    def resque_failed_jobs_count
      resque_failed_jobs.count
    end

    def resque_failed_jobs_count_by_class
      klass_name = []
      (0...resque_failed_jobs_count).step(BATCH_SIZE) do |start|
        resque_failed_jobs.all(start, BATCH_SIZE).each do |job|
          next if job.nil?
          klass_name << job['payload']['class'].to_s
        rescue StandardError => error
          logger_rescue('Failed-Job-Count-By-Class', error)
        end
      end
      klass_name.group_by(&:itself).transform_values(&:count)
    end

    def resque_failed_jobs_count_by_queue
      job_queue = []
      (0...resque_failed_jobs_count).step(BATCH_SIZE) do |start|
        resque_failed_jobs.all(start, BATCH_SIZE).each do |job|
          next if job.nil?
          job_queue << job['queue'].to_s
        rescue StandardError => error
          logger_rescue('Failed-Job-Count-By-Queue', error)
        end
      end
      job_queue.group_by(&:itself).transform_values(&:count)
    end
  end
end
