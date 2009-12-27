class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string    :email,             :null => false
      t.integer   :course_id,         :null => false
      t.integer   :teacher_id,        :null => false
      t.string    :token,             :null => false
      t.timestamps
    end
    
    add_index :invitations, [:course_id, :email], :unique => true
    add_index :invitations, :token, :unique => true
    add_foreign_key :invitations, :courses,     :dependent => :delete
    add_foreign_key :invitations, :teacher_id,  :dependent => :delete
  end

  def self.down
  end
end
