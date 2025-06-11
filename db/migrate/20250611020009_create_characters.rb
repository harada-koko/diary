class CreateCharacters < ActiveRecord::Migration[8.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :image_url
      t.text :cheer_message

      t.timestamps
    end
  end
end
