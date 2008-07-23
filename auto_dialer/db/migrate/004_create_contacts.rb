class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :cell
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :post_code
      t.string :time_zone
      t.string :account_id
      t.string :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
