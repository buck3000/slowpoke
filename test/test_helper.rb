require "bundler/setup"
require "combustion"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

logger = ActiveSupport::Logger.new(ENV["VERBOSE"] ? STDOUT : nil)

Combustion.path = "test/internal"
Combustion.initialize! :action_controller do
  config.action_controller.logger = logger

  config.action_dispatch.show_exceptions = true
  config.consider_all_requests_local = false

  config.slowpoke.timeout = lambda do |env|
    request = Rack::Request.new(env)
    request.path.start_with?("/admin") ? 1 : 0.1
  end
end
