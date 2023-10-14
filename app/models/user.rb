class User < ApplicationRecord
  attr_accessor :registration

  validates :role, inclusion: { in: [UserRolesEnums::ADMIN, UserRolesEnums::JOB_SEEKER] }
  validates :role, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }

  with_options if: :registration? do |user|
    user.validates :password_confirmation, presence: true
    user.validates_confirmation_of :password
  end
  
  def registration?
    registration
  end
  # use bcrypt for password hashing
  has_secure_password
  has_many :posts
  has_many :applications

  scope :default_selector, -> { select("id, email, password_digest, role, created_at") }
end
