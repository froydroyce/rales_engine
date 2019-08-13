require 'csv'

namespace :import do
  desc "Import prospects from CSV file"

  task merchant: :environment do
    CSV.foreach('./lib/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end
end
