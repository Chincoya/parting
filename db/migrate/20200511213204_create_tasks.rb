class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :author_id
      t.string :name
      t.bigint :amount

      t.timestamps
    end
  end
end
