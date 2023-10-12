class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :role, limit: 25
      t.string :email, limit: 150
      t.string :password

      t.timestamps
    end
  end
end
