class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.json :data

      t.timestamps
    end
  end
end
