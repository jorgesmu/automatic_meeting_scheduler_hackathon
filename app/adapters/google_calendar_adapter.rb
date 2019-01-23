require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleCalendarAdapter

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = 'Jorge Team'.freeze
  CREDENTIALS_PATH = 'credentials.json'.freeze
  TOKEN_PATH = 'token.yaml'.freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

  def initialize
    # Initialize the API
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
    @time_zone = 'Asia/Jerusalem'
    @attendees = ['jsmulevici@twistbioscience.com', 'nbenyechiel@twistbioscience.com']
  end
  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def get_service
    @service
  end

	def get_meetings(calendar_id='primary', time_min: Time.now.iso8601, max_results: 10)
    @service.list_events(calendar_id,
                         max_results: max_results,
                         single_events: true,
                         order_by: 'startTime',
                         time_min: time_min)
	end

  def get_free_busy(time_min, time_max, attendees = @attendees, time_zone = @time_zone, calendar_expansion_max = 50)
    items_payload = attendees.map do |attendee_email|
      {id: attendee_email}
    end

    body = Google::Apis::CalendarV3::FreeBusyRequest.new
    body.items = items_payload
    body.time_min = time_min
    body.time_max = time_max
    body.calendar_expansion_max = calendar_expansion_max
    body.time_zone = time_zone

    @service.query_freebusy(body)
  end

  def create_meeting(summary, location, description, start_date, end_date, time_zone = @time_zone, attendees = @attendees)

    attendees_payload = attendees.map do |attendee_email|
      {email: attendee_email}
    end

    event = Google::Apis::CalendarV3::Event.new({
      summary: summary,
      location: location,
      description: description,
      start: {
        date_time: start_date,
        time_zone: time_zone,
      },
      end: {
        date_time: end_date,
        time_zone: time_zone,
      },
      attendees: attendees_payload,
      #     reminders: {
      #     use_default: false,
      #     overrides: [
      #         {method' => 'email', 'minutes: 24 * 60},
      #         {method' => 'popup', 'minutes: 10},
      #     ],
      # },
    })

    push_meeting(event)
  end

	def push_meeting(event, calendar_id='primary')
    @service.insert_event(calendar_id, event)
	end
end