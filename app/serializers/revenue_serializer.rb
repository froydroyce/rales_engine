class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :revenue do |obj|
    "%.2f" % (obj.revenue.to_f / 100)
  end
end
