class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.references :folder
      t.string :name
      t.text :content
      t.string :file_name
      t.string :file_origin_name
      t.timestamps
    end
  end
end
