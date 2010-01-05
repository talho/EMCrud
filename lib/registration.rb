module EMCrud
  class Registration

    attr_reader :response

    def initialize
      form
      
    end

    def events
      @form.field_with(:name => "event").options.map(&:text)
    end

    def form
      page = agent.get(self.class.base_uri+"?page=EditWalkOnRegistration&service=page")
      @form = page.forms.first
    end

    def self.base_uri
      'https://emcredential.emsystem.com/app'
    end

    def agent
      @agent ||= WWW::Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }
    end
  end
end