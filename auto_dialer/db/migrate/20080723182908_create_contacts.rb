class CreateContacts < ActiveRecord::Migration
  def self.up
  end

  def self.down
    drop_table :contacts
  end
end