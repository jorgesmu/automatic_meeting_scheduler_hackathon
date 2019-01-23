class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.string :summary
      t.string :description
      t.datetime :starting_date
      t.datetime :ending_date
      t.string :location

      t.timestamps
    end
  end
end
