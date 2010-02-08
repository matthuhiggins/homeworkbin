module ActiveRecord
  module Prior
    def prior
      scoped(:order => 'id desc').first
    end
  end
end