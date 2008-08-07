class AddingCustomFields < ActiveRecord::Migration
  def self.up
    add_column :contacts, :custom0, :string
    add_column :contacts, :custom1, :string
    add_column :contacts, :custom2, :string
    add_column :contacts, :custom3, :string
    add_column :contacts, :custom4, :string
  end

  def self.down
  end
end
