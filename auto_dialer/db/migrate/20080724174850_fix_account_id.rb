class FixAccountId < ActiveRecord::Migration
  def self.up
    remove_column :users, :account_id
    add_column :users, :account_id, :integer, :default => 0
  end

  def self.down
  end
end
