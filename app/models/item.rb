class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order(:id) }

  def self.by_total_revenue(limit)
    unscoped {
      select("items.*, SUM(invoice_items.quantity*invoice_items.unit_price) AS revenue")
        .joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.unscoped.successful)
        .group(:id)
        .order("revenue DESC")
        .limit(limit)
    }
  end

  def self.by_total_sold(limit)
    unscoped {
      select("items.*, SUM(invoice_items.quantity) AS total_sold")
        .joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.unscoped.successful)
        .group(:id)
        .order("total_sold DESC")
        .limit(limit)
    }
  end

  def self.invoice_items(id)
    select("invoice_items.*")
      .joins(:invoice_items)
      .where(id: id)
  end

  def self.merchant(id)
    select("merchants.*")
      .joins(:merchant)
      .where(id: id)
      .first
  end
end
