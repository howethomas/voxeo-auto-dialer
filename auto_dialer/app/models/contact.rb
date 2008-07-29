class Contact < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :schedules
  has_many :histories
  belongs_to :account
  
  class << self
    def get_tags
      all = Contact.find(:all)
      tags = ["All"]
      all.each { |a| 
        a.tags.split.each {|t| tags << t} unless a.tags.nil?
      }  
      if tags.uniq.nil? then
        return tags
      else
        return tags.uniq
      end
    end    
  end
  
  
end