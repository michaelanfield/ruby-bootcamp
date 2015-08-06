require 'rake'

# Lists a directories contents and filters the output to a given pattern.
class ListFiles
  DEFAULT_FILE_PATTERN = '**/*.*'

  def self.list(directory = nil, pattern: DEFAULT_FILE_PATTERN, out: $stdout)
    fail ArgumentError, 'You must supply a directory for this to work.' unless directory

    FileList.new("#{directory}/#{pattern}").each do |file_name|
      out.puts File.basename(file_name)
    end
  end
end
