class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.references  :composition,   :null => false
      t.integer     :identifier,    :null => false
      t.text        :snippet,       :null => false
      t.text        :comment,       :null => false 
      t.timestamps
    end

    add_index :annotations, [:composition_id, :identifier], :unique => true
    add_foreign_key :annotations, :compositions, :dependent => :delete
  end
end
