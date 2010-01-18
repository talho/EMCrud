require 'mechanize'
require File.dirname(__FILE__) + '/form'
require File.dirname(__FILE__) + '/registration'
require File.dirname(__FILE__) + '/search'
require File.dirname(__FILE__) + '/session'
require File.dirname(__FILE__) + '/volunteer'
require 'logger'

module EMCrud
  class EMCrudException < Exception
  end
  
  class AuthenticationException < EMCrudException
  end
  
  class UnexpectedResponseException < EMCrudException
  end
  
  class InvalidOption < EMCrudException
  end
  
  class XmlParser < WWW::Mechanize::Page
    def initialize(uri = nil, response = nil, body = nil, code = nil)
      puts response['content-type'] = 'text/html'
      super(uri, response, body, code)
    end
  end
  
  def self.base_uri
    'https://emcredential.emsystem.com/app'
  end

  def self.agent
    @@agent ||= WWW::Mechanize.new { |agent|
      agent.user_agent_alias = 'Windows IE 7'
      agent.follow_meta_refresh = true
      agent.keep_alive = false
      agent.pluggable_parser['text/xml'] = XmlParser
      agent.log = Logger.new(File.dirname(__FILE__)+'/../emcrud.log')
    }
  end
  
  def self.get(uri='')
    response = agent.get(base_uri+uri)
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