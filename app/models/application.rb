class Application < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :with_joins, -> { joins(user: :posts) }

  def with_user_post_json
    self.as_json(
      include: {
        user: { only: [:id, :email] },
        post: { only: [:id, :title, :description] }
      }
    )
  end
  
  def with_joins_json
    self.as_json(
      include: {
        user: { only: [:id, :email] },
        post: { only: [:id, :title, :description] }
      }
    )
  end
end
