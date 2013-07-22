class CreateYamafudaYamafudas < ActiveRecord::Migration
  def change
    create_table :yamafuda_yamafudas do |t|
      t.integer :yamafuda_id
      t.integer :child_yamafuda_id

      t.timestamps
    end
  end
end
