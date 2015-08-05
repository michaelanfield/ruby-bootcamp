
# Checks to make sure included file names are listed in the output and excluded file names are not.
shared_examples 'list file names' do |pattern: nil, include_files: [], exclude_files: []|
  
  it "will include #{include_files.join(', ')} in the output" do
    
    if pattern
      described_class.list(@test_dir.to_s, pattern: pattern, out: output_stream)
    else
      described_class.list(@test_dir.to_s, out: output_stream)
    end

    include_files.each do |file_name|
      expect(output_stream.string).to include file_name
    end
  end

  it "will not include #{exclude_files.join(', ')} in the output" do
    
    if pattern
      described_class.list(@test_dir.to_s, pattern: pattern, out: output_stream)
    else
      described_class.list(@test_dir.to_s, out: output_stream)
    end

    exclude_files.each do |file_name|
      expect(output_stream.string).not_to include file_name
    end
  end
end
