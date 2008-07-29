class CreateUtilities < ActiveRecord::Migration
  def self.up
    create_table :utilities do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :utilities
  end
end
