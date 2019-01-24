class AddDurationIdToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :duration, :integer
  end
end
