class StatusValidator < ActiveModel::Validator
  def validate(record)
    if record.status != "unclaimed" || record.status != "in_progess" || record.status != "completed"
      record.errors[:status] << "Status not valid. "
    end
  end
end

class Task < ActiveRecord::Base
  attr_accessible :description, :reward, :runner_id, :status, :title, :urgent, :user_id

  include ActiveModel::Validations
  validates :title, :reward, :description, presence: true
  validates_with StatusValidator 
  
  scope :urgent, where(urgent: true)
  scope :not_urgent, where(urgent: false)

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :runner, class_name: "User", foreign_key: :runner_id
end
