module ResqueInfo
  def self.logger_rescue(log_title, error)
    puts '----------------------------------------------------'
    puts "==> [ResqueInfo]   [ #{log_title.upcase} ]"
    puts "==> [ErrorMessage] [ #{error.message} ]"
    puts '----------------------------------------------------'
  end
end
