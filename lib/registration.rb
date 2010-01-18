module EMCrud
  class Registration < Form

    attr_reader :response
    attr_reader :page

    def initialize
      form
    end
    
    def self.page
      'EditWalkOnRegistration'
    end

    def events
      @form.field_with(:name => "event").options.map(&:text)
    end

    def field_names
      @form.fields.map(&:name)
    end
    
    def profession=(string)
      set_form_attribute('profession', string)
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