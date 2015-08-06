require 'fileutils'
require 'pathname'
require 'tmpdir'

require_relative '../lib/list_files'

require_relative 'support/a_directory_file_list'
require_relative 'support/shared_context/tmp_files'

describe ListFiles do
  include_context :tmp_files

  let(:output_stream) { StringIO.new }
  let(:file_names) do
    %w(csv_file1.csv csv_file2.csv image1.jpg image2.jpg test_file1.txt test_file2.txt)
  end

  describe '#list' do
    it 'will raise an exception if no directory name is supplied' do
      expect { described_class.list }.to raise_error ArgumentError
    end

    context 'files within a directory are listed' do
      it_behaves_like 'a directory file list',
                      include_files: %w(csv_file1.csv csv_file2.csv image1.jpg image2.jpg test_file1.txt test_file2.txt),
                      exclude_files: %w(.\n ..\n)
    end

    context '.txt files within a directory are listed' do
      it_behaves_like 'a directory file list',
                      pattern: '*.txt',
                      include_files: %w(test_file1.txt test_file2.txt),
                      exclude_files: %w(csv_file1.csv csv_file2.csv image1.jpg image2.jpg .\n ..\n)
    end

    context '.csv files within a directory are listed' do
      it_behaves_like 'a directory file list',
                      pattern: '*.csv',
                      include_files: %w(csv_file1.csv csv_file2.csv),
                      exclude_files: %w(image1.jpg image2.jpg test_file1.txt test_file2.txt .\n ..\n)
    end

    context '*file2.* files within a directory are listed' do
      it_behaves_like 'a directory file list',
                      pattern: '*file2.*',
                      include_files: %w(csv_file2.csv test_file2.txt),
                      exclude_files: %w(csv_file1.csv test_file1.txt image1.jpg image2.jpg .\n ..\n)
    end
  end
end

# around_*
