class CreateRadicals < ActiveRecord::Migration
  def change
    create_table :radicals do |t|
      t.string :literal
      t.integer :strokes

      t.timestamps
    end
  end
end
