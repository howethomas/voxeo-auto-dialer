class HabtmTables < ActiveRecord::Migration
  def self.up
    create_table :contacts_groups, :id => false do |t|
      t.column :contact_id, :integer, :null => false
      t.column :group_id, :integer, :null => false
    end
    create_table :contacts_schedules, :id => false do |t|
      t.column :contact_id, :integer, :null => false
      t.column :schedule_id, :integer, :null => false
    end
    create_table :groups_schedules, :id => false do |t|
      t.column :group_id, :integer, :null => false
      t.column :schedule_id, :integer, :null => false
    end
  end

  def self.down
  end
end
