class Task < ActiveRecord::Base
  attr_accessible :description, :reward, :title, :urgent, :user_id
  validates :title, :reward, :description, presence: true
end
