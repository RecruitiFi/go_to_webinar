module GoToWebinar
  class Registrant
    def initialize(data)
      @data = data
    end

    def registrant_key
      @data['registrantKey'].to_s
    end

    def webinar_key
      @data['webinarKey'].to_s
    end

    def join_url
      @data['joinUrl'].to_s
    end

    def destroy
      GoToWebinar.client.delete("/organizers/:organizer_key:/webinars/#{webinar_key}/registrants/#{registrant_key}")
    end

    def self.create(webinar_key:, data:)
      data = GoToWebinar.client.post("/organizers/:organizer_key:/webinars/#{webinar_key}/registrants", data)
      Registrant.new(data)
    end

    def self.all(webinar_key:)
      make(GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}/registrants"))
    end

    def self.find(webinar_key:, registrant_key:)
      Registrant.new(GoToWebinar.client.get("/organizers/:organizer_key:/webinars/#{webinar_key}/registrants/#{registrant_key}"))
    end

    def self.make(data)
      data.map { |registrant| Registrant.new(registrant) }
    end
  end
end
