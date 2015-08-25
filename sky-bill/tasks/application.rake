require_relative 'support/rack_runner'

module Application
  class << self
    def start
      @app = Rack::Runner.start "#{__dir__}/../config.ru"
    end

    def stop
      @app.stop
    end

    def port
      @app.port
    end
  end
end

namespace :application do
  desc 'Start your application'
  task :start do
    Application.start

    ENV['port'] = Application.port.to_s

    at_exit do
      Application.stop
    end
  end
end
