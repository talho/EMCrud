module EMCrud
  class Volunteer < Form
    
    attr_accessor :first_name, :last_name, :url
    
    def self.search(options = {})
      Search.new(options).search
    end
    
    def initialize(attrs = {}) 
      self.attributes = attrs
    end
    
    def form
      unless @form
        page = EMCrud.agent.get(url)
        check_response(page)
        @form = page.forms.first
      end
      @form
    end
    
    def url
      EMCrud.base_uri + @url.sub(/^\/app/, '') if @url
    end
    
    def name
      "#{first_name} #{last_name}"
    end
  end
end