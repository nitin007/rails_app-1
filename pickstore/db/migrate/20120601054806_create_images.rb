class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.string :title
      t.references :album

      t.timestamps
    end
    add_index :images, :album_id
  end
end
