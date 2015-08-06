require 'rake'
require 'pry'

require_relative '../../../lib/list_files'
require_relative '../../support/shared_context/rake'

describe 'exercise14:list' do
  include_context :rake

  let(:directory) { 'tmp/test' }

  it 'lists files in the given directory for the default pattern' do
    allow(ListFiles).to receive(:list).with(directory, pattern: ListFiles::DEFAULT_FILE_PATTERN)

    subject.invoke(directory)
  end

  it 'lists files in the given directory for the given pattern' do
    allow(ListFiles).to receive(:list).with(directory, pattern: '*.txt')

    subject.invoke(directory, '*.txt')
  end
end
