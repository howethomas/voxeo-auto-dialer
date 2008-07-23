class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.datetime :start
      t.integer :account_id
      t.integer :application_id

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
