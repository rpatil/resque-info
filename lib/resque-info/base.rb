module ResqueInfo
  class << self
    def queues
      Resque.queues
    end

    def failed_jobs
      Resque::Failure
    end

    def failed_jobs_count
      failed_jobs.count
    end

    def failed_jobs_count_by_class
      klass_name = []
      (0...failed_jobs_count).step(BATCH_SIZE) do |start|
        failed_jobs.all(start, BATCH_SIZE).each do |job|
          next if job.nil?
          klass_name << job['payload']['class'].to_s
        rescue StandardError => error
          logger_rescue('Failed-Job-Count-By-Class', error)
        end
      end
      klass_name.group_by(&:itself).transform_values(&:count)
    end

    def failed_jobs_count_by_queue
      job_queue = []
      (0...failed_jobs_count).step(BATCH_SIZE) do |start|
        failed_jobs.all(start, BATCH_SIZE).each do |job|
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
