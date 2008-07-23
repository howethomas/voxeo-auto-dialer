class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.integer :primary_contact_id
      t.boolean :enabled

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
