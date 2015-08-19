# Provides a cache implementation built on top of a Hash.
class HashCache
  attr_reader :cache

  def initialize
    @cache = {}
  end

  def add_to_cache(ref, value)
    cache[ref] = value
  end

  def clear
    cache.clear
  end

  def exists?(ref)
    cache.key? ref
  end

  def get(ref)
    cache[ref]
  end
end
