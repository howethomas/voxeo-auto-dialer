class AdminPhone < ActiveRecord::Migration
  def self.up
    add_column :options, :admin_phone, :string
  end

  def self.down
  end
end
