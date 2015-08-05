
# Defines the configuration required to test a rake task.
#
# Uses the test class name to represent the task to be invoked e.g.
#   describe 'exercise14:list' do; end
#
# Will execute the list task within the exercise14 namespace in a file called
# exercise14.rake located in lib/tasks.
shared_context 'rake' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(':').first}" }
  subject         { rake[task_name] }

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rake.original_dir.to_s], [])
  end
end
