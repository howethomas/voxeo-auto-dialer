class CleanUpDb < ActiveRecord::Migration
  def self.up
    drop_table :sessions
    drop_table :users
  end

  def self.down
  end
end
