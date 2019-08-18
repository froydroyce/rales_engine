class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.total_revenue(id)
    select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(id: id)
      .take
  end

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

  def self.total_revenue_for_date(date)
    select("SUM(invoice_items.quantity*invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {created_at: date.to_date.all_day})
      .take
  end

  def self.revenue_for_date(date, id)
    select("SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {created_at: date.to_date.all_day}, id: id)
      .take
  end

  def self.favorite_merchant(id)
    joins(invoices: :transactions)
      .select("merchants.*, COUNT(invoices.merchant_id) AS succ_trans")
      .merge(Transaction.successful)
      .where(invoices: {customer_id: id})
      .group("merchants.id")
      .order("succ_trans DESC")
      .first
  end

  def self.items(id)
    select("items.*").joins(:items).where(items: {merchant_id: id})
  end

  def self.invoices(id)
    select("invoices.*").joins(:invoices).where(invoices: {merchant_id: id})
  end
end
