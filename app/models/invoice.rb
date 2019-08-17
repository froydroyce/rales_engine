class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.best_day(item_id)
     select("invoices.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .where(invoice_items: {item_id: item_id})
      .group(:id)
      .order("revenue DESC, invoices.created_at DESC")
      .first
  end
end
