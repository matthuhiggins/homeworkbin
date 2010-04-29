module ActiveRecord
  module Denormalization
    # class Comment < ActiveRecord::Base
    #   belongs_to :post, denormalize: :user
    # end
    def belongs_to(intermediate_association, options = {})
      options = options.dup
      if (denormalized_association = options.delete(:denormalize))
        super(denormalized_association, options)
        denormalize(intermediate_association, denormalized_association)
      end

      super(intermediate_association, options)
    end
  
    def denormalize(intermediate_association, denormalized_association)
      foreign_key = denormalized_association.to_s.foreign_key

      before_create do |record|
        if record.send(foreign_key).nil?
          intermediate_record = record.send(intermediate_association)
          record.send("#{foreign_key}=", intermediate_record.send(foreign_key))
        end
      end
    end
  end
end