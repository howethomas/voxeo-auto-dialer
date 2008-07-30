class AddAppDetails < ActiveRecord::Migration
  def self.up
    add_column :apps, :app_beep, :string
    add_column :apps, :start_url, :string
  end

  def self.down
  end
end
