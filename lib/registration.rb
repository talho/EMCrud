module EMCrud
<<<<<<< Updated upstream
  class Registration < Form
=======
  class Registration

    attr_reader :response
    attr_reader :page

    def initialize
      form
    end
>>>>>>> Stashed changes

    def events
      @form.field_with(:name => "event").options.map(&:text)
    end
<<<<<<< Updated upstream
=======

    def field_names
      @form.fields.map(&:name)
    end

    def form
      unless @form
        @page = EMCrud.get("?page=EditWalkOnRegistration&service=page")
        @form = page.forms.first
      end
      @form
    end
>>>>>>> Stashed changes
    
    def profession=(string)
      @form['profession'] = string
      get_profession_fields
    end
    
  private
    def get_profession_fields
      @form['submitmode'] = 'refresh'
      page = form.submit(nil, 'dojo-ajax-request' => 'true')
      @form = page.forms.first
      @form['submitmode'] = ''
    end
  end
end