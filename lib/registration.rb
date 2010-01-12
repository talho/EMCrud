module EMCrud
  class Registration < Form

    def events
      @form.field_with(:name => "event").options.map(&:text)
    end
    
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