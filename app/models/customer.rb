class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer(id)
    joins(invoices: :transactions)
      .select("customers.*, COUNT(invoices.customer_id) AS succ_trans")
      .merge(Transaction.successful)
      .where(invoices: {merchant_id: id})
      .group("customers.id")
      .order("succ_trans DESC")
      .first
  end
end
