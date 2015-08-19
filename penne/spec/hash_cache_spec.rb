require 'spec_helper'

describe HashCache do
  it 'will have a default empty cache' do
    expect(subject.cache.empty?).to be true
  end

  it 'will add a key value pair into the cache' do
    subject.add_to_cache 'key', 'value'

    expect(subject.cache.size).to eq 1
    expect(subject.cache['key']).to eq 'value'
  end

  context 'retrieving a value from the cache for a key' do
    it 'will retrieve nil if not found' do
      expect(subject.get 'nothing').to eq nil
    end

    it 'will retrieve the value if found' do
      subject.add_to_cache 'key', 'value'

      expect(subject.get 'key').to eq 'value'
    end
  end

  it 'will allow the cache to be cleared' do
    subject.add_to_cache 'key', 'value'

    subject.clear

    expect(subject.cache.empty?).to be true
  end

  context 'checking if a key exists in the cache' do
    it 'exists in the cache' do
      subject.add_to_cache 'key', 'value'

      expect(subject.exists? 'key').to be true
    end

    it 'does not exist in the cache' do
      expect(subject.exists? 'key').to be false
    end
  end
end
