Then '"$name" has the attributes:' do |name, table|
  volunteer = @form.volunteers.detect{|v| v.name == name}
  
  table.rows_hash.each do |field, value|
    volunteer.send(field).should == value
  end
end