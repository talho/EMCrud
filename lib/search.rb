module EMCrud
  class Search < Form

    attr_accessor :search_results, :volunteers

    def self.page
      'EditVolunteerSearch'
    end

    def firstName=(name)
      self.firstname = name
    end

    def firstName
      self.firstname
    end

    def lastName=(name)
      self.lastname=name
    end

    def lastName
      self.lastname
    end

    def search
      response = form.submit
      check_response(response)
      @search_results = response.body
      @volunteers = (response/'tr.dataRows').map do |row|
        last_name, first_name = row.at('td.FULL_NAME_LAST_FIRSTColumnValue').content.strip.split(', ')
        url = row.at('a')['href']
        Volunteer.new(:last_name => last_name, :first_name => first_name, :url => url)
      end
    end
  end
end