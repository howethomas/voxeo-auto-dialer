class RenameAppsTable < ActiveRecord::Migration
  def self.up
    rename_table :Apps, :apps
  end

  def self.down
  end
end
