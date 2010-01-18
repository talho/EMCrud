module EMCrud
  class Session
        
    def initialize(response)
      @response = response
    end
    
    def authenticated?
      self.class.response_authenticated?(@response)
    end
    
    def self.authenticate(username, password)
      response = EMCrud.get
      unless response_authenticated?(response)
        form = response.forms.first   
        form['userName'] = username
        form['password'] = password
        EMCrud.entropic_sleep
        response = form.click_button
      end
      raise AuthenticationException if response.nil?
      Session.new(response)
    end
    
    def self.response_authenticated?(response)
      response.body && response.body.include?('Log Out')
    end
  end
end