class RenameGroupIdToFirstGroupId < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :group_id, :first_group_id
  end
end
