class AddUserIdToYamafuda < ActiveRecord::Migration
  def change
    add_reference :yamafuda, :user, index: true
  end
end
