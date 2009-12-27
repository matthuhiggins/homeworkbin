class CreateRegistrations < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string  :email,               :null => false
      t.string  :full_name,           :null => false
      t.string  :token,               :null => false, :limit => 128
      t.timestamps
    end
    
    add_index :registrations, :token, :unique => true
  end

  def self.down
    drop_table :registrations
  end
end
