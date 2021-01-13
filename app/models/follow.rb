class Follow < ApplicationRecord
  belongs_to :user
  validates :follow_user_id, uniqueness: { scope: :user_id }
end
