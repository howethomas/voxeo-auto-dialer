class AddCallsPerSecond < ActiveRecord::Migration
  def self.up
    add_column :apps, :calls_per_minute, :integer
  end

  def self.down
    delete_column :apps, :calls_per_minute
  end
end
