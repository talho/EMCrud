require 'mechanize'
require File.dirname(__FILE__) + '/registration'
require File.dirname(__FILE__) + '/session'
require 'logger'

module EMCrud  
  def self.base_uri
    'https://emcredential.emsystem.com/app'
  end

  def self.agent
    @@agent ||= WWW::Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows IE 7'
      agent.follow_meta_refresh = true
      agent.keep_alive = false
      agent.log = Logger.new(File.dirname(__FILE__)+'/../emcrud.log')
    }
  end
  
  def self.get(uri='')
    agent.get(base_uri+uri)
  end
  
  def self.authenticate(username, password)
    @@session = Session.authenticate(username, password)
  end
  
  def self.session
    @@session
  end
  
  # sleep for some variation of a second
  def self.entropic_sleep
    sleep((rand(100) / 100.0) + 0.5)
  end
end