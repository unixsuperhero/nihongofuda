class AddUserIdToFuda < ActiveRecord::Migration
  def change
    add_reference :fuda, :user, index: true
  end
end
