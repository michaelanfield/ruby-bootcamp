
# Checks to make sure included file names are listed in the output and excluded file names are not.
shared_examples 'list file names' do |pattern: nil, include_files: [], exclude_files: []|

  include_files.each do |file_name|
    it "will include #{file_name} in the output" do
      if pattern
        described_class.list(@test_dir.to_s, pattern: pattern, out: output_stream)
      else
        described_class.list(@test_dir.to_s, out: output_stream)
      end

      expect(output_stream.string).to include file_name
    end
  end

  exclude_files.each do |file_name|
    it "will not include #{file_name} in the output" do
      if pattern
        described_class.list(@test_dir.to_s, pattern: pattern, out: output_stream)
      else
        described_class.list(@test_dir.to_s, out: output_stream)
      end

      expect(output_stream.string).not_to include file_name
    end
  end
end