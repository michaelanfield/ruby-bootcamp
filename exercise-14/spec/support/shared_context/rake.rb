
# Defines the configuration required to test a rake task.
#
# Uses the test class name to represent the task to be invoked e.g.
#   describe 'exercise14:list' do; end
#
# Will execute the list task within the exercise14 namespace in a file called
# exercise14.rake located in lib/tasks.
shared_context :rake do
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(':').first}" }

  let(:rake_app)  do
    Rake::Application.new.tap do |rake_app|
      allow(Rake).to receive(:application).and_return(rake_app)

      rake_app.rake_require(task_path, [Rake.original_dir.to_s], [])
    end
  end

  subject         { rake_app[task_name] }
end
