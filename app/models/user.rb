require "./app/enums/user_roles_enums.rb"

class User < ApplicationRecord
  validates :role, inclusion: { in: [UserRolesEnums::ADMIN, UserRolesEnums::JOB_SEEKER] }
  validates :role, presence: true
  validates :email, presence: true
  validates :password, presence: true

  # use bcrypt for password hashing
  has_secure_password
  has_many :posts
  has_many :applications
end
