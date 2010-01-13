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
          field = form.fields.detect{|f| f.name == nice_name}
          if field && field.kind_of?(WWW::Mechanize::Form::SelectList)
            option = field.options.detect{|o| o.text == args.first}
            form[nice_name] = option.value if option
          else
            form[nice_name] = *args
          end
        else
          field = form.fields.detect{|f| f.name == nice_name}
          if field && field.kind_of?(WWW::Mechanize::Form::SelectList)
            option = field.options.detect(&:selected)
            option.text unless option.nil?
          else
            form[nice_name]
          end
        end
      else
        super method_name, *args
      end
    end
  end
end