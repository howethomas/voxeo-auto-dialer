class AddingSupportOption < ActiveRecord::Migration
  def self.up
    add_column :options, :support_url, :string
  end

  def self.down
  end
end
