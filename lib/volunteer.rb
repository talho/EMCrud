module EMCrud
  class Volunteer
    attr_accessor :last_name, :first_name, :url
   
    def self.search(options = {})
      Search.new(options).search
    end
    
    def initialize(options = {}) 
      options.each {|key, value| send "#{key}=", value }
    end
    
    def name
      "#{first_name} #{last_name}"
    end
  end
end