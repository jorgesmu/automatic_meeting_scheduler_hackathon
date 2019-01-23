json.extract! invitation, :id, :meeting_id, :attendee_id, :is_organizer, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
