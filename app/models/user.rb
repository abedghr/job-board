class User < ApplicationRecord
  validates :role, inclusion: { in: ["admin", "job_seeker"] }
  validates :role, presence: true
  validates :email, presence: true
  validates :password, presence: true

  # use bcrypt for password hashing
  has_secure_password
  has_many :posts
end
