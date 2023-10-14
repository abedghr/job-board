
class Post < ApplicationRecord
  validates :is_active, inclusion: { in: [true, false] }
  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1000 }

  belongs_to :user
  has_many :applications

  scope :default_selector, -> { select("id, user_id, title, description, is_active, created_at") }

  def with_joins_json
    self.as_json(
      include: {
        user: { only: [:id, :email] },
      }
    )
  end
end
