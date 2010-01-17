class CreateLostPasswords < ActiveRecord::Migration
  def self.up
    create_table :lost_passwords do |t|
      t.integer :person_id, :null => false
      t.string  :token,     :null => false
      t.timestamps
    end
    
    add_foreign_key :lost_passwords, :people, :dependent => :delete
  end

  def self.down
    drop_table :lost_passwords
  end
end
