class MoveGroupIdToGroupsTasks < ActiveRecord::Migration[6.0]
  def change
    execute 'INSERT INTO groups_tasks (task_id, group_id) SELECT id, group_id FROM tasks WHERE group_id IS NOT NULL;'
  end
end
