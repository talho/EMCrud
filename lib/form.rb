module EMCrud
  class Form
    attr_reader :response
    
    def self.page
      'EditWalkOnRegistration'
    end
    
    def initialize(attrs = {})
      form
      self.attributes = attrs 
    end

    def attributes=(attrs)
      attrs.each {|key, value| self.send "#{key}=", value }
    end

    def field_names
      form.fields.map(&:name)
    end

    def form
      unless @form
        page = EMCrud.get("?page=#{self.class.page}&service=page")
        @form = page.forms.first
      end
      @form
    end
    
  private
  
    def method_missing(method_name, *args)
      nice_name = method_name.to_s.sub(/=$/, '')
      if field_names.include?(nice_name)
        if method_name.to_s =~ /=$/
          form[nice_name] = *args
        else
          form[nice_name]
        end
      else
        super method_name, *args
      end
    end
  end
end