class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.by_total_revenue(limit)
    select("items.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(invoice_items: [invoice: :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(limit)
  end

  def self.by_total_sold(limit)
    select("items.*, SUM(invoice_items.quantity) AS total_sold")
      .joins(invoice_items: [invoice: :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("total_sold DESC")
      .limit(limit)
  end
end
