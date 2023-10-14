class AddIndexToPostsIsActive < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, :is_active
  end
end
