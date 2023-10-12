class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_active, default: true
      t.string :title, null: false
      t.text :description, null: false 

      t.timestamps
    end
  end
end
