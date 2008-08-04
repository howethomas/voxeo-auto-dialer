class AddFieldsToApp < ActiveRecord::Migration
  def self.up
    add_column :apps, :fields, :string
  end

  def self.down
  end
end
