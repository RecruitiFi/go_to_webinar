module GoToWebinar
  class Webinar
    def initialize(data)
      @data = data
    end

    def webinar_key
      @data['webinarKey'].to_s
    end

    def add_registrant(first_name:, last_name:, email:)
      data = {first_name: first_name, last_name: last_name, email: email}
      Registrant.create(webinar_key: webinar_key, data: data)
    end

    def self.find(webinar_key:)
      data = GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}")
      Webinar.new(data)
    end

    # Retrieves the list of webinars for an account within a given date range.
    # Page and size parameters are optional. Default page is 0 and default
    # size is 20.
    def self.for_account(account_key:, from:, to:, page: nil, page_size: nil)
      options = { fromTime: from, toTime: to }
      options[:page] = page if page.present?
      options[:size] = page_size if page_size.present?

      GoToWebinar.client.get("/accounts/#{account_key}/webinars", options)
      # TODO: montar retorno
    end

    # Returns details for completed webinars for the specified organizer and
    # completed webinars of other organizers where the specified organizer is a
    # co-organizer.
    def self.historical(from: nil, to: nil)
      options = { fromTime: from, toTime: to }
      make(GoToWebinar.client.get("/organizers/:organizer_key:/historicalWebinars", options))
    end

    # Returns webinars scheduled for the future for a specified organizer.
    def self.for_organizer
      make(GoToWebinar.client.get("/organizers/:organizer_key:/webinars"))
    end

    # Returns webinars scheduled for the future for the specified organizer and
    # webinars of other organizers where the specified organizer is a
    # co-organizer.
    def self.upcoming
      make(GoToWebinar.client.get("/organizers/:organizer_key:/upcomingWebinars"))
    end

    def self.make(data)
      data.map { |webinar| Webinar.new(webinar) }
    end
  end
end
