class CreateAdminUser < ActiveRecord::Migration[6.1]
  def up
    User.create!(
        email: 'admin@gmail.com',
        password: 'admin1234',
        password_confirmation: 'admin1234',
        role: 'admin'
      )
  end

  def down
    admin_user = User.find_by(email: 'admin@gmail.com')
    admin_user.destroy if admin_user
  end
end
