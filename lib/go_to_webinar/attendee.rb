module GoToWebinar
  class Attendee
    def initialize(data)
      @data = data
    end

    def registrant_key
      @data['registrantKey'].to_s
    end

    def first_name
      @data['firstName'].to_s
    end

    def last_name
      @data['lastName'].to_s
    end

    def email
      @data['email'].to_s
    end

    def attendance_time_in_seconds
      @data['attendanceTimeInSeconds'].to_s
    end

    def session_key
      @data['sessionKey'].to_s
    end

    def attendance
      @data['attendance']
    end

    def join_time
      attendance['joinTime'].to_datetime
    end

    def leave_time
      attendance['leaveTime'].to_datetime
    end

    def self.all_for_session(webinar_key:, session_key:)
      make(GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}/sessions/#{session_key}/attendees"))
    end

    def self.make(data)
      data.map { |registrant| Attendee.new(registrant) }
    end
  end
end
