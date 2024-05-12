require 'Time'
module Logger
    def append_file(log)
        open('app.logs', 'a') { |f|
        f.puts log
    }
    end
    def log_format(log_type,message)
      time_now=Time.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
      log_message_format="#{time_now}--#{log_type}--#{message}"
      append_file(log_message_format)
    end
    def log_info(message)
        log_format('info',message)
    end
    def log_error(message)
        log_format('error',message)
    end
    def log_warning(message)
        log_format('warning',message)
    end
end