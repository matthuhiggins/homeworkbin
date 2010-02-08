module ActiveRecord
  module Previous
    def previous
      scoped(:order => 'id desc').first
    end
  end
end