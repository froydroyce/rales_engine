require 'rails_helper'

RSpec.describe "Merchants API" do
  it 'sends a list of merchants' do

    create_list(:merchant, 10)
    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(10)
  end

  it "can get one merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single merchant" do
    merchant_1 = Merchant.create!(name: "merchant 1", created_at: "2019-08-13 21:03:01 UTC")
    merchant_2 = Merchant.create!(name: "merchant 2")
    merchant_3 = Merchant.create!(name: "merchant 3")
    merchant_4 = Merchant.create!(name: "merchant 4", updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/merchants/find?name=#{merchant_3.name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(merchant_3.id.to_s)

    get "/api/v1/merchants/find?id=#{merchant_2.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(merchant_2.id.to_s)

    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(merchant_1.id.to_s)

    get "/api/v1/merchants/find?updated_at=#{merchant_4.updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(merchant_4.id.to_s)
  end

  it "can find multiple merchants" do
    merchant_1 = Merchant.create!(name: "merchant 1", created_at: "2019-08-13 21:03:01 UTC")
    merchant_2 = Merchant.create!(name: "merchant 2")
    merchant_3 = Merchant.create!(name: "merchant 3")
    merchant_4 = Merchant.create!(name: "merchant 4", updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/merchants/find_all?name=#{merchant_3.name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(merchant_3.id.to_s)

    get "/api/v1/merchants/find_all?id=#{merchant_2.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(merchant_2.id.to_s)

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(merchant_1.id.to_s)

    get "/api/v1/merchants/find_all?updated_at=#{merchant_4.updated_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(merchant_4.id.to_s)
  end

  it "can return a random merchant" do
    merchant_2 = Merchant.create!(name: "merchant 2")
    merchant_3 = Merchant.create!(name: "merchant 3")

    get '/api/v1/merchants/random'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].first["id"]).to eq(merchant_2.id.to_s).or eq(merchant_3.id.to_s)
  end

  describe 'Business Intelligence Endpoints for all Merchants' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)

      @customer = create(:customer)

      @item_1  = create(:item, unit_price: 1000, merchant: @merchant_1)
      @item_2  = create(:item, unit_price: 2000, merchant: @merchant_1)
      @item_3  = create(:item, unit_price: 3000, merchant: @merchant_2)
      @item_4  = create(:item, unit_price: 4000, merchant: @merchant_2)
      @item_5  = create(:item, unit_price: 5000, merchant: @merchant_3)
      @item_6  = create(:item, unit_price: 6000, merchant: @merchant_3)
      @item_7  = create(:item, unit_price: 7000, merchant: @merchant_4)
      @item_8  = create(:item, unit_price: 8000, merchant: @merchant_4)
      @item_9  = create(:item, unit_price: 9000, merchant: @merchant_5)
      @item_10 = create(:item, unit_price: 1000, merchant: @merchant_5)
      @item_11 = create(:item, unit_price: 2000, merchant: @merchant_6)
      @item_12 = create(:item, unit_price: 3000, merchant: @merchant_6)
      @item_13 = create(:item, unit_price: 4000, merchant: @merchant_7)
      @item_14 = create(:item, unit_price: 5000, merchant: @merchant_7)
      @item_15 = create(:item, unit_price: 6000, merchant: @merchant_8)
      @item_16 = create(:item, unit_price: 7000, merchant: @merchant_8)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_9, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_9, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_10, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_10, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_11, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_11, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_12, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_12, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_13, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_13, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_14, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_14, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_15, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_15, item: @item_16, quantity: 16, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_16, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_16, item: @item_16, quantity: 16, unit_price: 7000)

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)
      create(:transaction, invoice: @invoice_6)
      create(:transaction, invoice: @invoice_7)
      create(:transaction, invoice: @invoice_8)
      create(:transaction, invoice: @invoice_9)
      create(:transaction, invoice: @invoice_10)
      create(:transaction, invoice: @invoice_11)
      create(:transaction, invoice: @invoice_12)
    end

    it "returns the top x merchants ranked by total revenue" do
      get '/api/v1/merchants/most_revenue?quantity=5'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(5)
      expect(merchants["data"][0]["id"].to_i).to eq(@merchant_4.id)
      expect(merchants["data"][1]["id"].to_i).to eq(@merchant_5.id)
    end

    it "returns the top x merchants ranked by total number of items sold" do
      get '/api/v1/merchants/most_items?quantity=5'

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(5)
      expect(merchants["data"][0]["id"].to_i).to eq(@merchant_6.id)
      expect(merchants["data"][1]["id"].to_i).to eq(@merchant_5.id)
    end

    it "returns the total revenue for date x across all merchants" do
      get '/api/v1/merchants/revenue?date=2012-03-20'

      expect(response).to be_successful

      revenue = JSON.parse(response.body)

      expect(revenue["data"]["attributes"]["total_revenue"]).to eq("600.00")
    end
  end

  describe 'Business Intelligence Endpoints for single Merchants' do
    before(:each) do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)

      @item_1 = create(:item, unit_price: 1000)
      @item_2 = create(:item, unit_price: 2000)
      @item_3 = create(:item, unit_price: 3000)
      @item_4 = create(:item, unit_price: 4000)
      @item_5 = create(:item, unit_price: 5000)
      @item_6 = create(:item, unit_price: 6000)
      @item_7 = create(:item, unit_price: 7000)
      @item_8 = create(:item, unit_price: 8000)

      @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 8, unit_price: 8000)

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)
    end

    it "returns the total revenue for that merchant across successful transactions" do
      get "/api/v1/merchants/#{@merchant.id}/revenue"

      expect(response).to be_successful

      revenue = JSON.parse(response.body)

      expect(revenue["data"]["attributes"]["revenue"]).to eq("1210.00")
    end

    it "returns the total revenue for that merchant for a specific invoice date x" do
      get "/api/v1/merchants/#{@merchant.id}/revenue?date=2012-03-20"

      expect(response).to be_successful

      revenue = JSON.parse(response.body)

      expect(revenue["data"]["attributes"]["revenue"]).to eq("100.00")
    end

    it "returns the customer who has conducted the most total number of successful transactions." do
      get "/api/v1/merchants/#{@merchant.id}/favorite_customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer["data"]["attributes"]["id"].to_i).to eq(@customer_2.id)
    end
  end

  describe 'Merchants Relationship Endpoints' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @customer = create(:customer)
      @item_1  = create(:item, unit_price: 1000, merchant: @merchant_1)
      @item_2  = create(:item, unit_price: 2000, merchant: @merchant_1)
      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
    end

    it "returns a collection of items associated with that merchant" do
      get "/api/v1/merchants/#{@merchant_1.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      expect(items["data"].first["id"].to_i).to eq(@item_1.id)
      expect(items["data"].last["id"].to_i).to eq(@item_2.id)
    end

    it "returns a collection of invoices associated with that merchant from their known orders" do
      get "/api/v1/merchants/#{@merchant_1.id}/invoices"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(2)
      expect(items["data"].first["id"].to_i).to eq(@invoice_1.id)
      expect(items["data"].last["id"].to_i).to eq(@invoice_2.id)
    end
  end
end
