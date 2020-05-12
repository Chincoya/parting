class AddGroupIdToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :group_id, :integer
  end
end
