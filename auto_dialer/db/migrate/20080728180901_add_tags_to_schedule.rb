class AddTagsToSchedule < ActiveRecord::Migration
  def self.up
    add_column :schedules, :tags, :string
  end

  def self.down
  end
end
