module EMCrud
  # The <tt>Registration</tt> class is used to submit the registration information for a user to
  # EMCredential
  class Registration < Form

    attr_reader :response
    attr_reader :page

    def initialize
      form
    end

    def self.page
      'EditWalkOnRegistration'
    end

    # returns all events currently registered in EMCredential
    def events
      @form.field_with(:name => "event").options.map(&:text)
    end

    #returns the list of string professions that are acceptable values for <tt>Registration.profession=()</tt>
    def professions
      @form.field_with(:name => "profession").options.map(&:text)
    end

    #returns the list of strings describing acceptable values for password challenges.
    def passwordChallenges
      @form.field_with(:name => "passwordChallenge").options.map(&:text)
    end

    # 
    def field_names
      @form.fields.map(&:name)
    end

    def firstName=(name)
      self.name = name
    end

    def firstName
      self.name
    end

    def lastName=(name)
      self.last=name
    end

    def lastName
      self.last
    end

    #if submitting a registration with a profession, the value must be a value from the <tt>Registration.professions</tt>
    #collection, and setting the profession should occur before any other fields are set, as the form as to refresh
    #from EMSystems with custom fields for the profession
    def profession=(string)
      raise EMCrudException, "Invalid profession string" unless professions.include?(string)
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