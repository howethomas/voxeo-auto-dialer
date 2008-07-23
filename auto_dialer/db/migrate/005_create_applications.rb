class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.string :name
      t.string :wait_wav
      t.string :app_human
      t.string :app_machine
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
