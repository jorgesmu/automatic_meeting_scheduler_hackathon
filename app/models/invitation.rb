class Invitation < ApplicationRecord
  belongs_to :meeting
  belongs_to :attendee
end
