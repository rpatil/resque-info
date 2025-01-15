module ResqueInfo
  class << self

    def redis_info
      Resque.redis.redis.info
    end
    def redis_version
      redis_info['redis_version']
    end

    def redis_ping
      Resque.redis.redis.ping
    end

    def redis_connected?
      redis_ping == 'PONG'
    end

    def redis_details
      details_array = %w[redis_version redis_build_id redis_mode arch_bits monotonic_clock multiplexing_api tcp_port os].freeze
      search_from_redis_info(details_array)
    end

    def redis_uptime
      uptime_seconds = redis_info["uptime_in_seconds"]
      {
        "uptime_seconds": uptime_seconds,
        "uptime_hours": "#{uptime_seconds.to_i / 60} hours",
        "uptime_days": "#{redis_info["uptime_in_days"]} days"
      }
    end

    def redis_used_memory
      used_memory_array = %w[used_memory used_memory_human used_memory_rss used_memory_rss_human used_memory_peak used_memory_peak_human used_memory_peak_perc used_memory_overhead used_memory_startup used_memory_dataset used_memory_dataset_perc used_memory_lua used_memory_vm_eval used_memory_lua_human used_memory_scripts_eval].freeze
      search_from_redis_info(used_memory_array)
    end

    def redis_allocator
      allocator_array = %w[allocator_allocated allocator_active allocator_resident allocator_frag_ratio allocator_frag_bytes allocator_rss_ratio allocator_rss_bytes].freeze
      search_from_redis_info(allocator_array)
    end

    def redis_memory
      memory_array = %w[total_system_memory total_system_memory_human used_memory_vm_functions used_memory_vm_total used_memory_vm_total_human used_memory_functions used_memory_scripts used_memory_scripts_human maxmemory maxmemory_human maxmemory_policy].freeze
      search_from_redis_info(memory_array)
    end

    def redis_mem
      mem_array = %w[mem_fragmentation_ratio mem_fragmentation_bytes mem_not_counted_for_evict mem_replication_backlog mem_total_replication_buffers mem_clients_slaves mem_clients_normal mem_cluster_links mem_aof_buffer mem_allocator].freeze
      search_from_redis_info(mem_array)
    end

    def redis_rdb
      rdb_array = %w[rdb_changes_since_last_save rdb_bgsave_in_progress rdb_last_save_time rdb_last_bgsave_status rdb_last_bgsave_time_sec rdb_current_bgsave_time_sec rdb_saves rdb_last_cow_size rdb_last_load_keys_expired rdb_last_load_keys_loaded].freeze
      search_from_redis_info(rdb_array)
    end

    def redis_aof
      aof_array = %w[aof_enabled aof_rewrite_in_progress aof_rewrite_scheduled aof_last_rewrite_time_sec aof_current_rewrite_time_sec aof_last_bgrewrite_status aof_rewrites aof_rewrites_consecutive_failures aof_last_write_status aof_last_cow_size].freeze
      search_from_redis_info(aof_array)
    end

    def redis_total_net
      net_array = %w[total_net_input_bytes total_net_output_bytes total_net_repl_input_bytes total_net_repl_output_bytes].freeze
      search_from_redis_info(net_array)
    end

    def redis_instantaneous
      inst_array = %w[instantaneous_ops_per_sec instantaneous_input_kbps instantaneous_output_kbps instantaneous_input_repl_kbps instantaneous_output_repl_kbps instantaneous_eventloop_cycles_per_sec instantaneous_eventloop_duration_usec].freeze
      search_from_redis_info(inst_array)
    end

    def redis_defrag
      defrag_array = %w[active_defrag_hits active_defrag_misses active_defrag_key_hits active_defrag_key_misses total_active_defrag_time current_active_defrag_time ].freeze
      search_from_redis_info(defrag_array)
    end

    def redis_acl_access_denied
      acl_array = %w[acl_access_denied_auth acl_access_denied_cmd acl_access_denied_key acl_access_denied_channel].freeze
      search_from_redis_info(acl_array)
    end

    def redis_master_repl
      master_repl_array = %w[master_failover_state master_replid master_replid2 master_repl_offset second_repl_offset repl_backlog_active repl_backlog_size repl_backlog_first_byte_offset repl_backlog_histlen].freeze
      search_from_redis_info(master_repl_array)
    end

    def redis_used_cpu
      used_cpu_array = %w[used_cpu_sys used_cpu_user used_cpu_sys_children used_cpu_user_children].freeze
      search_from_redis_info(used_cpu_array)
    end

    def redis_other_details
      other_details_array = %w[executable number_of_cached_scripts number_of_functions number_of_libraries rss_overhead_ratio rss_overhead_bytes active_defrag_running lazyfree_pending_objects lazyfreed_objects loading async_loading current_cow_peak current_cow_size current_cow_size_age current_fork_perc current_save_keys_processed current_save_keys_total module_fork_in_progress module_fork_last_cow_size total_connections_received total_commands_processed rejected_connections sync_full sync_partial_ok sync_partial_err expired_keys expired_stale_perc expired_time_cap_reached_count expire_cycle_cpu_milliseconds evicted_keys evicted_clients total_eviction_exceeded_time current_eviction_exceeded_time keyspace_hits keyspace_misses pubsub_channels pubsub_patterns pubsubshard_channels latest_fork_usec total_forks migrate_cached_sockets slave_expires_tracked_keys tracking_total_keys tracking_total_items tracking_total_prefixes unexpected_error_replies total_error_replies dump_payload_sanitizations total_reads_processed total_writes_processed io_threaded_reads_processed io_threaded_writes_processed reply_buffer_shrinks reply_buffer_expands eventloop_cycles eventloop_duration_sum eventloop_duration_cmd_sum role connected_slaves cluster_enabled db0].freeze
      search_from_redis_info(other_details_array)
    end

    def search_from_redis_info(array_listing)
      output = {}
      array_listing.each do |element|
        output["#{element}"] = redis_info["#{element}"]
      end
      output
    end

  end
end
