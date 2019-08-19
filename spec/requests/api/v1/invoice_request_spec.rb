require 'rails_helper'

RSpec.describe "Invoices API" do
  it 'sends a list of invoices' do

    create_list(:invoice, 10)
    get '/api/v1/invoices'

    expect(response).to be_successful
    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(10)
  end

  it "can get one invoice" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single invoice" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer, created_at: "2019-08-13 21:03:01 UTC")
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)
    invoice_4 = create(:invoice, merchant: merchant, customer: customer, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/invoices/find?id=#{invoice_2.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(invoice_2.id.to_s)

    get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/invoices/find?updated_at=#{invoice_4.updated_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(invoice_4.id.to_s)
  end

  it "can find multiple invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer, created_at: "2019-08-13 21:03:01 UTC")
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)
    invoice_4 = create(:invoice, merchant: merchant, customer: customer, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/invoices/find_all?id=#{invoice_2.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["id"]).to eq(invoice_2.id.to_s)

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/invoices/find_all?updated_at=#{invoice_4.updated_at}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"].first["id"]).to eq(invoice_4.id.to_s)
  end

  describe 'Invoices Relationship Endpoints' do
    before(:each) do
      @merchant = create(:merchant)
      @customer = create(:customer)
      @item_1  = create(:item, unit_price: 1000, merchant: @merchant)
      @item_2  = create(:item, unit_price: 2000, merchant: @merchant)
      @invoice_1  = create(:invoice, merchant: @merchant, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_1)
    end

    it "returns a collection of associated transactions" do
      get "/api/v1/invoices/#{@invoice_1.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions["data"].count).to eq(2)
      expect(transactions["data"][0]["id"].to_i).to eq(@transaction_1.id)
      expect(transactions["data"][1]["id"].to_i).to eq(@transaction_2.id)
    end

    it "returns a collection of associated invoice items" do
      get "/api/v1/invoices/#{@invoice_1.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(2)
      expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_1.id)
      expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_2.id)
    end

    it "returns a collection of associated items" do
      get "/api/v1/invoices/#{@invoice_1.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      expect(items["data"][0]["id"].to_i).to eq(@item_1.id)
      expect(items["data"][1]["id"].to_i).to eq(@item_2.id)
    end

    it "returns a collection of associated items" do
      get "/api/v1/invoices/#{@invoice_1.id}/customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer["data"]["id"].to_i).to eq(@customer.id)
    end

    it "returns a collection of associated items" do
      get "/api/v1/invoices/#{@invoice_1.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["data"]["id"].to_i).to eq(@merchant.id)
    end
  end
end
