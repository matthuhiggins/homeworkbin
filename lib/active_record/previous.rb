module ActiveRecord
  module Previous
    def previous
      last(:conditions => 'id is not null')
    end
  end
end