module EMCrud
  class User
    
    attr_accessor :authenticated
    alias_method :authenticated?, :authenticated
    
    def self.authenticate(username, password)
      page = EMCrud.get
      form = page.forms.first      
      form['userName'] = username
      form['password'] = password
      entropic_sleep
      response = form.click_button
      user = User.new
      user.authenticated = response.body.include?('Log Out')
      user
    end
    
  end
end