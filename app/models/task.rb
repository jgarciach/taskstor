class Task < ActiveRecord::Base
  attr_accessible :description, :reward, :title, :urgent, :user_id
  validates :title, :reward, :description, presence: true
  scope :urgent, where(urgent: true)
  scope :not_urgent, where(urgent: false)
  belongs_to :user
end
