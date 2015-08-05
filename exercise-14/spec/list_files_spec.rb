require 'rake'
require 'fileutils'
require 'pathname'
require 'tmpdir'

require_relative '../lib/list_files'
require_relative 'support/list_file_names'

describe ListFiles do

  let(:output_stream) { StringIO.new }
  let(:file_names) {
    [
      'csv_file1.csv', 'csv_file2.csv', 'csv_file3.csv', 'csv_file4.csv', 'csv_file5.csv', 
      'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg',
      'test_file1.txt', 'test_file2.txt', 'test_file3.txt'
    ]
  }

  describe '#list' do
    # Setup some test data files so we can use them within the tests.
    before do
      @test_dir = Pathname.new(Dir.mktmpdir)
      
      file_names.each { |file_name| create_file(file_name) }
    end

    # Tear down the test data.
    after do
      FileUtils.remove_dir(@test_dir)
    end

    it 'will raise an exception if no directory name is supplied' do
      expect {described_class.list()}.to raise_error ArgumentError
    end

    context 'files within a directory are listed' do
      it_behaves_like 'list file names', 
                      include_files: [
                        'csv_file1.csv', 'csv_file2.csv', 'csv_file3.csv', 'csv_file4.csv', 'csv_file5.csv', 
                        'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg',
                        'test_file1.txt', 'test_file2.txt', 'test_file3.txt'
                      ], 
                      exclude_files: ['.\n', '..\n'] 
    end

    context '.txt files within a directory are listed' do
      it_behaves_like 'list file names', 
                      pattern: '*.txt',
                      include_files: ['test_file1.txt', 'test_file2.txt', 'test_file3.txt'],
                      exclude_files: [
                        'csv_file1.csv', 'csv_file2.csv', 'csv_file3.csv', 'csv_file4.csv', 'csv_file5.csv', 
                        'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg',
                        '.\n', '..\n'
                      ]
    end

    context '.csv files within a directory are listed' do
      it_behaves_like 'list file names', 
                      pattern: '*.csv',
                      include_files: ['csv_file1.csv', 'csv_file2.csv', 'csv_file3.csv', 'csv_file4.csv', 'csv_file5.csv'],
                      exclude_files: [
                        'test_file1.txt', 'test_file2.txt', 'test_file3.txt', 
                        'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg',
                        '.\n', '..\n'
                      ]
    end

    context '*file2.* files within a directory are listed' do
      it_behaves_like 'list file names', 
                      pattern: '*file2.*',
                      include_files: ['csv_file2.csv', 'test_file2.txt'],
                      exclude_files: [
                        'csv_file1.csv', 'csv_file3.csv', 'csv_file4.csv', 'csv_file5.csv',
                        'test_file1.txt', 'test_file3.txt', 
                        'image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg',
                        '.\n', '..\n'
                      ]
    end
  end

  private
  def create_file(file_path, options = {})
    Pathname.new(FileUtils.touch(@test_dir.join(file_path), options).first)
  end
end
