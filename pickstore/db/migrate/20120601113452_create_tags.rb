class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :image

      t.timestamps
    end
    add_index :tags, :image_id
  end
end
