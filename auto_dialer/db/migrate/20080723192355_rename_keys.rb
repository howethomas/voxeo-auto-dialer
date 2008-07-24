class RenameKeys < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :application_id, :app_id
    rename_column :schedules, :application_id, :app_id
  end

  def self.down
  end
end
