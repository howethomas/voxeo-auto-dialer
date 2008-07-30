class Utility < ActiveRecord::Base
  def self.fill_test_data
    phone_number = "15088152374"
    
    for i in 1..10000
      c = Contact.new
      c.first_name = "Test"
      c.last_name = "User"+i.to_s
      c.phone = phone_number
      c.tags = "test_set"
      c.save
    end
  end
  def self.erase_test_data
    contacts = Contacts.find_by_tags("test_set")
    for c in Contacts
      c.destroy
    end
  end
end
