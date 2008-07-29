class AddContactToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :contact_id, :integer
  end

  def self.down
  end
end
