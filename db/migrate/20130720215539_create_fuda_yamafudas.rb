class CreateFudaYamafudas < ActiveRecord::Migration
  def change
    create_table :fuda_yamafuda do |t|
      t.integer :fuda_id
      t.integer :yamafuda_id

      t.timestamps
    end
  end
end
