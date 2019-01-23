class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :meeting, foreign_key: true
      t.references :attendee, foreign_key: true
      t.boolean :is_organizer

      t.timestamps
    end
  end
end
