class CreateYamafudas < ActiveRecord::Migration
  def change
    create_table :yamafuda do |t|
      t.string :name

      t.timestamps
    end
  end
end
