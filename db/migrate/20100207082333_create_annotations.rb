class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.references  :submission,    :null => false
      t.text        :text,          :null => false
      t.timestamps
    end

    add_foreign_key :annotations, :compositions, :dependent => :delete, :column => 'submission_id'
  end

  def self.down
  end
end
