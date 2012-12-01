class Task < ActiveRecord::Base
  attr_accessible :description, :reward, :title, :urgent, :user_id
end
