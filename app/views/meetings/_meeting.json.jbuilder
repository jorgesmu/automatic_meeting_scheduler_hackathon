json.extract! meeting, :id, :summary, :description, :starting_date, :ending_date, :location, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
