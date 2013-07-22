class AddJlptToKanji < ActiveRecord::Migration
  def change
    add_column :kanji, :jlpt, :integer
  end
end
