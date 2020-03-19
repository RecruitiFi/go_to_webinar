module GoToWebinar
  class Session
    def initialize(data)
      @data = data
    end

    # startTime* string($date-time)
    # The starting time of the webinar session
    def start_time
      @data['startTime']&.to_datetime
    end

    # registrantsAttended* integer($int32)
    # The number of registrants who attended the webinar session
    def registrants_attended
      @data['registrantsAttended'].to_s
    end

    # webinarKey* integer($int64)
    # The unique key of the webinar
    def webinar_key
      @data['webinarKey'].to_s
    end

    # webinarID* string
    # The 9-digit webinar ID
    def webinar_id
      @data['webinarID'].to_s
    end

    # sessionKey* integer($int64)
    # The unique key of the webinar session
    def session_key
      @data['sessionKey'].to_s
    end

    # endTime* string($date-time)
    # The ending time of the webinar session
    def end_time
      @data['endTime']&.to_datetime
    end

    # Get session attendees
    def attendees
      Attendee.all_for_session(webinar_key: webinar_key, session_key: session_key)
    end

    def self.find(webinar_key:, session_key:)
      data = make(GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}/sessions/#{session_key}"))
      Session.new(data)
    end

    def self.for_webinar(webinar_key:)
      make(GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}/sessions"))
    end

    def self.all
      make(GoToWebinar.client.get("/organizers/:organizer_key:/sessions"))
    end

    def self.make(data)
      data.map { |registrant| Session.new(registrant) }
    end
  end
end
