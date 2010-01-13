module Concerns::Denormalization
  # class Comment < ActiveRecord::Base
  #   denormalizes :user, :through => :post
  # end
  def denormalizes association, options
    foreign_key = association.to_s.foreign_key
    through_assocation = options[:through]
    
    before_create do |record|
      if record.send(foreign_key).nil?
        through_record = record.send(through_assocation)
        record.send("#{foreign_key}=", through_record.send(foreign_key))
      end
    end
  end
end