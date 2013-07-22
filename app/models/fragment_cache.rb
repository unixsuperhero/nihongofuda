class FragmentCache < ActiveRecord::Base
  def expired?
    false
  end

  def value
    data
  end
end
