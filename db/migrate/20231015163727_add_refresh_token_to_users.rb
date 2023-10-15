class AddRefreshTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :refresh_token, :string
    add_index :users, :refresh_token
    add_column :users, :refresh_token_expiry, :datetime
  end
end
