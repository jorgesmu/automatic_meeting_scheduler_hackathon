class Attendee < ApplicationRecord
  has_many :invitations
  has_many :meetings, through: :invitations
end
