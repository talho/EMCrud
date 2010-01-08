module EMCrud
  class Session
        
    def initialize(response='')
      @response = response
    end
    
    def authenticated?
      @response.body.include?('Log Out')
    end
    
    def self.authenticate(username, password)
      page = EMCrud.get
      form = page.forms.first      
      form['userName'] = username
      form['password'] = password
      EMCrud.entropic_sleep
      response = form.click_button
      Session.new(response)
    end
    
  end
end