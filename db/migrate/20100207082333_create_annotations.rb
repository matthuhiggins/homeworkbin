class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.references  :composition,   :null => false
      t.text        :text,          :null => false
      t.timestamps
    end

    add_foreign_key :annotations, :compositions, :dependent => :delete
  end

  def self.down
  end
end
