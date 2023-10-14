
class Post < ApplicationRecord
  validates :is_active, inclusion: { in: [true, false] }
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :applications

  def with_joins_json
    self.as_json(
      include: {
        user: { only: [:id, :email] },
      }
    )
  end
end
