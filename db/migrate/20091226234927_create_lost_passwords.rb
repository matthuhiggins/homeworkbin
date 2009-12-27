class CreateLostPasswords < ActiveRecord::Migration
  def self.up
    create_table :lost_passwords do |t|
      t.integer :person_id, :null => false
      t.string  :token,     :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :lost_passwords
  end
end
