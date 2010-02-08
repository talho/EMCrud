module EMCrud
  class Form
    attr_reader :response
    
    # Redefine this method in subclasses with the page to fetch
    def self.page
      raise EMCrudException, 'page must be defined in subclass'
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

    def submit
      form.submit
    end
    def form
      unless @form
        page = EMCrud.get("?page=#{self.class.page}&service=page")
        check_response(page)
        @form = page.forms.first
      end
      @form
    end
    
  private
  
    def check_response(response)
      if !Session.response_authenticated?(response)
        raise AuthenticationException 
      elsif response.forms.empty?
        raise UnexpectedResponseException
      end
    end
    
    def form_attribute(name)
      field = form.fields.detect{|f| f.name == name}
      if field && field.kind_of?(WWW::Mechanize::Form::SelectList)
        option = field.options.detect(&:selected)
        option.text unless option.nil?
      else
        form[name]
      end
    end
    
    def set_form_attribute(name, value)
      field = form.fields.detect{|f| f.name == name}
      if field && field.kind_of?(WWW::Mechanize::Form::SelectList)
        option = field.options.detect{|o| o.text == value}
        unless option
          raise InvalidOption, "#{value} is not an available option. Found: #{field.options.map(&:text).join(', ')}"
        end
        form[name] = option.value
      else
        form[name] = value
      end
    end
  
    def method_missing(method_name, *args)
      nice_name = method_name.to_s.sub(/=$/, '')
      if field_names.include?(nice_name)
        if method_name.to_s =~ /=$/
          set_form_attribute nice_name, args.first
        else
          form_attribute(nice_name)
        end
      else
        super method_name, *args
      end
    end
  end
end