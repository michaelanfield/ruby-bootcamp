require 'rake'

# Lists a directories contents and filters the output to a given pattern.
class ListFiles
  def self.list(directory, pattern: '**/*.*', out: $stdout)
    fail ArgumentError, 'You must supply a directory for this to work.' if !directory

    FileList.new("#{directory}/#{pattern}").each do |file_name|
      out.puts file_name
    end
  end
end