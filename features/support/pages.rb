def agent
  @agent ||= WWW::Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
    agent.follow_meta_refresh = true
    agent.keep_alive = false
  }
end

def fetch_page(url)
  @current_page = agent.get(url)
  @form = @current_page.forms.first
  entropic_sleep
end

def fill_in_credentials
  @form['userName'] = @user['username']
  @form['password'] = @user['password']
end

def submit_form
  entropic_sleep
  @current_page = @form.click_button
end

def current_page
  @current_page
end

# sleep for some variation of a second
def entropic_sleep
  sleep((rand(100) / 100.0) + 0.5)
end