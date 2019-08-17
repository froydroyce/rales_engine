class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
end

# SELECT  merchants.*, SUM(invoice_items.quantity) AS items_sold FROM "merchants" INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" WHERE "transactions"."result" = 'success' GROUP BY "merchants"."id" ORDER BY items_sold DESC LIMIT 8
# SELECT  merchants.*, SUM(invoice_items.quantity) AS items_sold FROM "merchants" INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" INNER JOIN "invoices" "invoices_merchants_join" ON "invoices_merchants_join"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices_merchants_join"."id" WHERE "transactions"."result" = 'success' GROUP BY "merchants"."id" ORDER BY items_sold DESC LIMIT 8
# SELECT  merchants.*, SUM(invoice_items.quantity) AS items_sold FROM "merchants" INNER JOIN "invoices" ON "invoices"."merchant_id" = "merchants"."id" INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id" INNER JOIN "invoices" "invoices_merchants_join" ON "invoices_merchants_join"."merchant_id" = "merchants"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices_merchants_join"."id" WHERE "transactions"."result" = 'success' GROUP BY "merchants"."id" ORDER BY items_sold DESC LIMIT 8
