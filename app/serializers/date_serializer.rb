class DateSerializer
  include FastJsonapi::ObjectSerializer

  attributes :total_revenue do |obj|
    "%.2f" % (obj.total_revenue.to_f / 100)
  end
end
