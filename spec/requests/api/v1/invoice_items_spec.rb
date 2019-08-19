require 'rails_helper'

RSpec.describe "Invoice Items API" do
  it 'sends a list of invoice_items' do

    create_list(:invoice_item, 10)
    get '/api/v1/invoice_items'

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(10)
  end

  it "can get one invoice_item" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single invoice_item" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_1 = create(:invoice_item, item: item, invoice: invoice, created_at: "2019-08-13 21:03:01 UTC")
    invoice_2 = create(:invoice_item, item: item, invoice: invoice)
    invoice_3 = create(:invoice_item, item: item, invoice: invoice)
    invoice_4 = create(:invoice_item, item: item, invoice: invoice, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/invoice_items/find?id=#{invoice_2.id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(invoice_2.id.to_s)

    get "/api/v1/invoice_items/find?created_at=#{invoice_1.created_at}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_4.updated_at}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(invoice_4.id.to_s)
  end

  it "can find by unit_price" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_1 = create(:invoice_item, item: item, invoice: invoice)

    price = "%.2f" % (invoice_1.unit_price.to_f / 100)
    get "/api/v1/invoice_items/find?unit_price=#{price}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(invoice_1.id.to_s)
  end

  it "can find multiple invoice_items" do
    item = create(:item)
    invoice = create(:invoice)
    invoice_1 = create(:invoice_item, item: item, invoice: invoice, created_at: "2019-08-13 21:03:01 UTC")
    invoice_2 = create(:invoice_item, item: item, invoice: invoice)
    invoice_3 = create(:invoice_item, item: item, invoice: invoice)
    invoice_4 = create(:invoice_item, item: item, invoice: invoice, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/invoice_items/find_all?id=#{invoice_2.id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].first["id"]).to eq(invoice_2.id.to_s)

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_1.created_at}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].first["id"]).to eq(invoice_1.id.to_s)

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_4.updated_at}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"].first["id"]).to eq(invoice_4.id.to_s)
  end

  describe 'Invoice Items Relationship Endpoints' do
    before(:each) do
      @item = create(:item)
      @invoice = create(:invoice)
      @invoice_1 = create(:invoice_item, item: @item, invoice: @invoice, created_at: "2019-08-13 21:03:01 UTC")
    end

    it "returns the associated invoice" do
      get "/api/v1/invoice_items/#{@invoice_1.id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["data"]["id"].to_i).to eq(@invoice.id)
    end

    it "returns the associated item" do
      get "/api/v1/invoice_items/#{@invoice_1.id}/item"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item["data"]["id"].to_i).to eq(@item.id)
    end
  end
end
