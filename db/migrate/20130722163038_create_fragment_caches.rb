class CreateFragmentCaches < ActiveRecord::Migration
  def change
    create_table :fragment_caches do |t|
      t.string :key
      t.text :data

      t.timestamps
    end

    add_index :fragment_caches, :key
  end
end
