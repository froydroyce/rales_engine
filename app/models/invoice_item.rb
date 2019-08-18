class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  default_scope { order(:id) }

  def self.invoice(id)
    select("invoices.*")
      .joins(:invoice)
      .where(id: id)
      .first
  end

  def self.item(id)
    select("items.*")
      .joins(:item)
      .where(id: id)
      .first
  end
end
