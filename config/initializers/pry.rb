if defined?(Rails)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
