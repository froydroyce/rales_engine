class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer(id)
    joins(invoices: :transactions)
      .select("customers.*, COUNT(invoices.customer_id) AS succ_trans")
      .merge(Transaction.unscoped.successful)
      .where(invoices: {merchant_id: id})
      .group("customers.id")
      .order("succ_trans DESC")
      .first
  end

  def self.invoices(id)
    select("invoices.*")
      .joins(:invoices)
      .where(invoices: {customer_id: id})
  end

  def self.transactions(id)
    select("transactions.*")
      .joins(invoices: :transactions)
      .where(invoices: {customer_id: id})
  end
end
