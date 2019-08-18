class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  default_scope { order(id: :asc) }

  def self.best_day(item_id)
     select("invoices.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .where(invoice_items: {item_id: item_id})
      .group(:id)
      .order("revenue DESC, invoices.created_at DESC")
      .first
  end

  def self.transactions(id)
    select("transactions.*")
      .joins(:transactions)
      .where(transactions: {invoice_id: id})
  end

  def self.invoice_items(id)
    select("invoice_items.*")
    .joins(:invoice_items)
    .where(invoice_items: {invoice_id: id})
  end

  def self.items(id)
    select("items.*")
      .joins(:invoice_items, :items)
      .where(invoice_items: {invoice_id: id})
      .distinct
  end

  def self.customer(id)
    select("customers.*")
      .joins(:customer)
      .where(id: id)
      .first
  end

  def self.merchant(id)
    select("merchants.*")
      .joins(:merchant)
      .where(id: id)
      .first
  end
end
