class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

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
