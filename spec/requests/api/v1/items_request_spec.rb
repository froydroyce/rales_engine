require 'rails_helper'

RSpec.describe "Items API" do
  it 'sends a list of items' do

    create_list(:item, 10)
    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(10)
  end

  it "can get one item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single item" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant, created_at: "2019-08-13 21:03:01 UTC")
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)
    item_4 = create(:item, merchant: merchant, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/items/find?name=#{item_3.name}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_3.id.to_s)

    get "/api/v1/items/find?description=#{item_3.description}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_3.id.to_s)

    get "/api/v1/items/find?id=#{item_2.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_2.id.to_s)

    price = "%.2f" % (item_2.unit_price.to_f / 100)
    get "/api/v1/items/find?unit_price=#{price}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_2.id.to_s)

    get "/api/v1/items/find?created_at=#{item_1.created_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_1.id.to_s)

    get "/api/v1/items/find?updated_at=#{item_4.updated_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(item_4.id.to_s)
  end

  it "can find multiple items" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant, created_at: "2019-08-13 21:03:01 UTC")
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)
    item_4 = create(:item, merchant: merchant, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/items/find_all?name=#{item_3.name}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["id"]).to eq(item_3.id.to_s)

    get "/api/v1/items/find_all?id=#{item_2.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["id"]).to eq(item_2.id.to_s)

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["id"]).to eq(item_1.id.to_s)

    get "/api/v1/items/find_all?updated_at=#{item_4.updated_at}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"].first["id"]).to eq(item_4.id.to_s)
  end

  describe 'Business Intelligence Endpoints for items' do
    before :each do
      @item_1  = create(:item, unit_price: 1000)
      @item_2  = create(:item, unit_price: 2000)
      @item_3  = create(:item, unit_price: 3000)
      @item_4  = create(:item, unit_price: 4000)
      @item_5  = create(:item, unit_price: 5000)
      @item_6  = create(:item, unit_price: 6000)
      @item_7  = create(:item, unit_price: 7000)
      @item_8  = create(:item, unit_price: 8000)
      @item_9  = create(:item, unit_price: 9000)
      @item_10 = create(:item, unit_price: 1000)
      @item_11 = create(:item, unit_price: 2000)
      @item_12 = create(:item, unit_price: 3000)
      @item_13 = create(:item, unit_price: 4000)
      @item_14 = create(:item, unit_price: 5000)
      @item_15 = create(:item, unit_price: 6000)
      @item_16 = create(:item, unit_price: 7000)

      @invoice_1  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")

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

    it "returns the top x items ranked by total revenue generated" do
      get '/api/v1/items/most_revenue?quantity=5'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(5)
      expect(items["data"][0]["id"].to_i).to eq(@item_9.id)
      expect(items["data"][1]["id"].to_i).to eq(@item_8.id)
      expect(items["data"][2]["id"].to_i).to eq(@item_7.id)
      expect(items["data"][3]["id"].to_i).to eq(@item_6.id)
      expect(items["data"][4]["id"].to_i).to eq(@item_12.id)
    end

    it "returns the top x item instances ranked by total number sold" do
      get '/api/v1/items/most_items?quantity=5'

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items["data"].count).to eq(5)
      expect(items["data"][0]["id"].to_i).to eq(@item_12.id)
      expect(items["data"][1]["id"].to_i).to eq(@item_11.id)
      expect(items["data"][2]["id"].to_i).to eq(@item_10.id)
      expect(items["data"][3]["id"].to_i).to eq(@item_9.id)
      expect(items["data"][4]["id"].to_i).to eq(@item_8.id)
    end

    it "returns the date with the most sales for the given item using the invoice date. " do
      get "/api/v1/items/#{@item_1.id}/best_day"

      expect(response).to be_successful

      date = JSON.parse(response.body)

      expect(date["data"]["attributes"]["best_day"]).to eq("2012-03-20")
    end
  end

  describe 'Items Relationship Endpoints' do
    before(:each) do
      @merchant = create(:merchant)
      @item_1  = create(:item, unit_price: 1000, merchant: @merchant)
      @invoice_1  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
    end

    it "returns a collection of associated invoice items" do
      get "/api/v1/items/#{@item_1.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(2)
      expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_1.id)
      expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_2.id)
    end

    it "returns the associated merchant" do
      get "/api/v1/items/#{@item_1.id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant["data"]["id"].to_i).to eq(@merchant.id)
    end
  end
end
