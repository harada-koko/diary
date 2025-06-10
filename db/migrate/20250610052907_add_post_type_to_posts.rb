class AddPostTypeToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :post_type, :string
  end
end
