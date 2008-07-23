class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.integer :schedule_id
      t.integer :contact_id
      t.string :result

      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
