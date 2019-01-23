class Meeting < ApplicationRecord
  has_many :invitations
  has_many :attendees, through: :invitations
end
