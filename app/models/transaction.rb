class Transaction < ApplicationRecord
  belongs_to :invoice

  default_scope { order(:id) }
  scope :successful, -> { where(result: "success") }

  def self.invoice(id)
    select("invoices.*")
      .joins(:invoice)
      .where(id: id)
      .first
  end
end
