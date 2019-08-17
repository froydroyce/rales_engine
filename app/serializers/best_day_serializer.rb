class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :best_day do |obj|
    obj.created_at.strftime("%Y-%m-%d")
  end
end
