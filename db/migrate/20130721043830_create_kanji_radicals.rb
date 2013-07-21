class CreateKanjiRadicals < ActiveRecord::Migration
  def change
    create_table :kanji_radicals do |t|
      t.integer :kanji_id
      t.integer :radical_id

      t.timestamps
    end
  end
end
