class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.by_total_revenue(limit)
    select("merchants.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(limit)
  end

  def self.by_items_sold(limit)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("items_sold DESC")
      .limit(limit)
  end

  def self.revenue_for_date(date)
    select("SUM(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {created_at: date.to_date.all_day})
      .take
  end
end
