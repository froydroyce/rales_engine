require 'csv'

namespace :import do
  desc "Import sales data from CSV files"

  task sales_csv: :environment do
    merchants = []
    items = []
    customers = []
    invoices = []
    invoice_items = []
    transactions = []

    CSV.foreach('./lib/data/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end

    CSV.foreach('./lib/data/items.csv', headers: true) do |row|
      items << row.to_h
    end

    CSV.foreach('./lib/data/customers.csv', headers: true) do |row|
      customers << row.to_h
    end

    CSV.foreach('./lib/data/invoices.csv', headers: true) do |row|
      invoices << row.to_h
    end

    CSV.foreach('./lib/data/invoice_items.csv', headers: true) do |row|
      invoice_items << row.to_h
    end

    CSV.foreach('./lib/data/transactions.csv', headers: true) do |row|
      transactions << row.to_h
    end
    Merchant.import(merchants)
    Item.import(items)
    Customer.import(customers)
    Invoice.import(invoices)
    InvoiceItem.import(invoice_items)
    Transaction.import(transactions)
  end
end
