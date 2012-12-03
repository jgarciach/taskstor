class AddRunnerIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :runner_id, :integer
  end
end
