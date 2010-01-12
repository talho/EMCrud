module EMCrud
  class Session
        
    def initialize(response)
      @response = response
    end
    
    def authenticated?
      @response.body && @response.body.include?('Log Out')
    end
    
    def self.authenticate(username, password)
      response = EMCrud.get
      unless response.body.include?('Log Out')
        form = response.forms.first   
        form['userName'] = username
        form['password'] = password
        EMCrud.entropic_sleep
        response = form.click_button
      end
      raise "nil session" if response.nil?
      Session.new(response)
    end
    
  end
end