class CreateFudaKanjis < ActiveRecord::Migration
  def change
    create_table :fuda_kanji do |t|
      t.integer :fuda_id
      t.integer :kanji_id

      t.timestamps
    end
  end
end
