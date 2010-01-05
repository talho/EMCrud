module EMCrud
  class Registration

    attr_reader :response

    def initialize
      form

    end

    def events
      @form.field_with(:name => "event").options.map(&:text)
    end

    def field_names
      @form.fields.map(&:name)
    end

    def form
      unless @form
        page = agent.get(self.class.base_uri+"?page=EditWalkOnRegistration&service=page")
        @form = page.forms.first
      end
      @form
    end

    def self.base_uri
      'https://emcredential.emsystem.com/app'
    end

    def agent
      @agent ||= WWW::Mechanize.new { |agent|
        agent.user_agent_alias = 'Mac Safari'
      }
    end
private
    def method_missing(method_name, *args)
      nice_name = method_name.to_s.sub(/=$/, '')
      if field_names.include?(nice_name)
        if method_name.to_s =~ /=$/
          @form[nice_name] = *args

        end
      end
    end
  end
end