class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.string :version
      t.boolean :mock
      t.integer :debug_level
      t.string :admin_name
      t.string :admin_email
      t.boolean :daily_summary

      t.timestamps 
    end
  end

  def self.down
    drop_table :options
  end
end