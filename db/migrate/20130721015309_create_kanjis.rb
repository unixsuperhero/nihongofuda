class CreateKanjis < ActiveRecord::Migration
  def change
    create_table :kanji do |t|
      t.string :literal
      t.string :on
      t.string :kun
      t.string :meanings
      t.integer :strokes
      t.integer :frequency
      t.integer :grade

      t.timestamps
    end
  end
end
