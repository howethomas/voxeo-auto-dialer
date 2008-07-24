class RenameApp < ActiveRecord::Migration
  def self.up
    rename_table :Applications, :Apps
  end

  def self.down
    rename_table :Apps, :Applications
  end
end
