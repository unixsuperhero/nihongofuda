class CreateFudas < ActiveRecord::Migration
  def change
    create_table :fudas do |t|
      t.text :front
      t.text :back

      t.timestamps
    end
  end
end
