# require 'rubygems'

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  desc 'Run the feature tests with cucumber'
  task features: 'application:start' do
    Cucumber::Rake::Task.new(:cucumber) do |t|
      t.cucumber_opts = ["--format pretty port=#{Application.port}",
                         '--format html -o coverage/features.html', 
                         '-b']
    end

    Rake::Task[:cucumber].invoke
  end
rescue LoadError
  desc 'Cucumber rake task not available'

  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end
