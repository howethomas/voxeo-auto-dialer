class AddAccountId < ActiveRecord::Migration
  def self.up
    add_column :users, :account_id, :integer, :default => 0
  end

  def self.down
  end
end
