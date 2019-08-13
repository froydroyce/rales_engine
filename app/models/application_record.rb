class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    order("RANDOM()").limit(1)
  end
end
