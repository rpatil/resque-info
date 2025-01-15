# ResqueInfo

ResqueInfo gem will help to .

## Installation

Add this line to your application's Gemfile:

    gem 'resque-info'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque-info

## Usage

Try this snippet of code on ruby irb

    require 'resque-info'
    puts ResqueInfo.info                          # => 44323547714622714350878229787161

    puts ResqueInfo.queues
    puts ResqueInfo.total_jobs
    # Failed-Jobs
    puts ResqueInfo.failed_jobs
    puts ResqueInfo.failed_jobs_count
    puts ResqueInfo.failed_jobs_count_by_class
    puts ResqueInfo.failed_jobs_count_by_queue
    # Processed-Jobs
    puts ResqueInfo.processed_jobs
    puts ResqueInfo.processed_jobs_per_minute
    puts ResqueInfo.processed_jobs_per_hour
    puts ResqueInfo.processed_jobs_per_day
    puts ResqueInfo.processed_jobs_per_week
    puts ResqueInfo.processed_jobs_per_month
    puts ResqueInfo.processed_jobs_per_year
    # Redis-Details
    puts ResqueInfo.redis_info
    puts ResqueInfo.redis_version
    puts ResqueInfo.redis_ping
    puts ResqueInfo.redis_connected?
    puts ResqueInfo.redis_details
    puts ResqueInfo.redis_uptime
    puts ResqueInfo.redis_used_memory
    puts ResqueInfo.redis_allocator
    puts ResqueInfo.redis_memory
    puts ResqueInfo.redis_mem
    puts ResqueInfo.redis_rdb
    puts ResqueInfo.redis_aof
    puts ResqueInfo.redis_total_net
    puts ResqueInfo.redis_instantaneous
    puts ResqueInfo.redis_defrag
    puts ResqueInfo.redis_acl_access_denied
    puts ResqueInfo.redis_master_repl
    puts ResqueInfo.redis_used_cpu
    puts ResqueInfo.redis_other_details

## Contributing

1. Fork it ( https://github.com/[my-github-username]/resque-info/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
