class ActiveRecordStore < ActiveSupport::Cache::Store
  def initialize(options = nil)
    super(options)
  end

  def clear(options = nil)
    FragmentCache.destroy_all
  end

  def cleanup(options = nil)
  end

  def increment(name, amount = 1, options = nil)
  end

  def decrement(name, amount = 1, options = nil)
  end

  def delete_matched(matcher, options = nil)
  end

  protected

    def read_entry(key, options) # :nodoc:
      FragmentCache.find_by(key: key)
    end

    def write_entry(key, entry, options) # :nodoc:
      FragmentCache.create(key: key, data: entry.value.to_s)
    end

    def delete_entry(key, options) # :nodoc:
      entry = FragmentCache.find_by(key: key) && entry.destroy
    end
end
