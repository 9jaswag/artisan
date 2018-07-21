class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.string :type
      t.references :client, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
