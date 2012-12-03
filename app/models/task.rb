class Task < ActiveRecord::Base
  attr_accessible :description, :reward, :runner_id, :status, :title, :urgent, :user_id

  validates :title, :reward, :description, presence: true
  
  scope :urgent, where(urgent: true)
  scope :not_urgent, where(urgent: false)

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :runner, class_name: "User", foreign_key: :runner_id

  def accept(runner)
    self.runner_id = runner.id
    self.status = "in_progress"
    self.save
  end

  def complete
    self.status = "completed"
    self.save
  end
  
end
