class RenameAppsTable < ActiveRecord::Migration
  def self.up
    begin
      rename_table :Apps, :apps      
    rescue Exception => e
      
    end
  end

  def self.down
  end
end
