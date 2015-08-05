require_relative '../list_files'

namespace :exercise14 do
  desc 'Lists a directories contents and filters the output to a given pattern.'
  task :list, [:directory, :pattern] do |_task, args|
    args.with_defaults(pattern: ListFiles::DEFAULT_FILE_PATTERN)

    ListFiles.list(args.directory, pattern: args.pattern)
  end
end
