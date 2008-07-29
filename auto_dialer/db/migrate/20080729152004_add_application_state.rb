class AddApplicationState < ActiveRecord::Migration
  def self.up
    add_column :schedules, :state, :string
  end

  def self.down
    delete_column :schedules, :state
  end
end
