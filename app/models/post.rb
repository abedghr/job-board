class Post < ApplicationRecord
  validates :is_active, inclusion: { in: [true, false] }
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
end
