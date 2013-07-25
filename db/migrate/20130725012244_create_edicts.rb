class CreateEdicts < ActiveRecord::Migration
  def change
    create_table :edicts do |t|
      t.string :literal
      t.string :reading
      t.text :meanings

      t.timestamps
    end
  end
end
