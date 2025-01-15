module ResqueInfo
  class << self
    def queues
      Resque.queues
    end

    def total_jobs
      Resque.info[:total_jobs]
    end

    def failed_jobs
      Resque.info[:failed]
    end

    def processed_jobs
      Resque.info[:processed]
    end

    def processed_jobs_per_minute
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_minute.to_i)
    end

    def processed_jobs_per_hour
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_hour.to_i)
    end

    def processed_jobs_per_day
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_day.to_i)
    end

    def processed_jobs_per_week
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_week.to_i)
    end

    def processed_jobs_per_month
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_month.to_i)
    end

    def processed_jobs_per_year
      processed_jobs / (Time.now.to_i - Time.now.beginning_of_year.to_i)
    end

  end
end