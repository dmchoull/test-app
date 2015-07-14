class Profile < ActiveRecord::Base
  validates :user_id, uniqueness: true, presence: true
  validates :name, :bio, presence: true

  belongs_to :user
end
