module EMCrud
  class Search < Form
    
    attr_accessor :search_results, :volunteers
    
    def self.page
      'AdHocSearchPage'
    end
    
    def search
      response = form.submit
      @search_results = response.body
      @volunteers = (response/'tr.dataRows td.FULL_NAME_LAST_FIRSTColumnValue').map do |row|
        last_name, first_name = row.content.strip.split(', ')
        Volunteer.new(:last_name => last_name, :first_name => first_name)
      end
    end
  end
end