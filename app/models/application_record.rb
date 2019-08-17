class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  self.abstract_class = true


  def self.random
    order("RANDOM()").limit(1)
  end
end
