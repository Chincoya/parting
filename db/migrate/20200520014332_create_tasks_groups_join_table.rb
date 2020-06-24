class CreateTasksGroupsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tasks, :groups do |t|
      t.index :task_id
      t.index :group_id
    end
  end
end
