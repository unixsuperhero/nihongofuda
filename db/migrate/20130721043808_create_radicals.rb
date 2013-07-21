class CreateRadicals < ActiveRecord::Migration
  def change
    create_table :radicals do |t|
      t.string :literal
      t.string :meaning
      t.integer :strokes
      t.integer :original_kanji_id

      t.timestamps
    end
  end
end
