
# Sets up tmp files in a tmp directory and removes them when the tests are complete.
shared_context :tmp_files do
  attr_reader :test_dir

  # Setup some test data files so we can use them within the tests.
  before do
    @test_dir = Pathname.new(Dir.mktmpdir)

    file_names.each { |file_name| create_file(file_name) }
  end

  # Tear down the test data.
  after do
    FileUtils.remove_dir(@test_dir)
  end

  private

  def create_file(file_path, options = {})
    Pathname.new(FileUtils.touch(test_dir.join(file_path), options).first)
  end
end
