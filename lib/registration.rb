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
        page = EMCrud.get("?page=EditWalkOnRegistration&service=page")
        @form = page.forms.first
      end
      @form
    end
    
    def profession=(string)
      @form['profession'] = string
      get_profession_fields
    end
    
  private
    def get_profession_fields
      # dojo-ajax-request:true
      EMCrud.agent.request_headers['dojo-ajax-request'] = true
      page = form.submit
      @form = page.forms.first
    end
  
    def method_missing(method_name, *args)
      nice_name = method_name.to_s.sub(/=$/, '')
      if field_names.include?(nice_name)
        if method_name.to_s =~ /=$/
          @form[nice_name] = *args
        end
      else
        super method_name, *args
      end
    end
  end
end