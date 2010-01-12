module EMCrud
  class Search < Form
    
    attr_accessor :search_results
    
    def self.page
      'AdHocSearchPage'
    end
    
    def search
      @search_results = form.submit.body
    end
  end
end