# frozen_string_literal: true

require 'logger'

if Cerberus.config['log_file']
  logger = Logger.new(Cerberus.config['log_file'])

  configure do
    use ::Rack::CommonLogger, logger
  end

  before do
    env['rack.logger'] = logger
  end
end

if Cerberus.config['error_log_file']
  error_logger = File.new(Cerberus.config['error_log_file'], 'a+')
  error_logger.sync = true
  before do
    env['rack.errors'] = error_logger
  end
end
