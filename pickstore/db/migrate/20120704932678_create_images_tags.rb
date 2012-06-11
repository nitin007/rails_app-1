class CreateImagesTags < ActiveRecord::Migration
  def change
    create_table :images_tags, :id => false do |t|
      t.references :image
      t.references :tag

      t.timestamps
    end
    add_index :images_tags, [:image_id, :tag_id]
    add_index :images_tags, [:tag_id, :image_id]
  end
end
