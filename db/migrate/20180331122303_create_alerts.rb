class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.string :subject
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
