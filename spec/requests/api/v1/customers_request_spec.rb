require 'rails_helper'

RSpec.describe "Customers API" do
  it 'sends a list of customers' do

    create_list(:customer, 10)
    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(10)
  end

  it "can get one customer" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single customer" do
    customer_1 = Customer.create!(first_name: "customer 1", last_name: "bob", created_at: "2019-08-13 21:03:01 UTC")
    customer_2 = Customer.create!(first_name: "customer 2", last_name: "jones")
    customer_3 = Customer.create!(first_name: "customer 3", last_name: "michaels")
    customer_4 = Customer.create!(first_name: "customer 4", last_name: "johns", updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/customers/find?first_name=#{customer_3.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(customer_3.id.to_s)

    get "/api/v1/customers/find?last_name=#{customer_1.last_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(customer_1.id.to_s)

    get "/api/v1/customers/find?id=#{customer_2.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(customer_2.id.to_s)

    get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(customer_1.id.to_s)

    get "/api/v1/customers/find?updated_at=#{customer_4.updated_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(customer_4.id.to_s)
  end

  it "can find multiple customers" do
    customer_1 = Customer.create!(first_name: "customer 1", created_at: "2019-08-13 21:03:01 UTC")
    customer_2 = Customer.create!(first_name: "customer 2")
    customer_3 = Customer.create!(first_name: "customer 3")
    customer_4 = Customer.create!(first_name: "customer 4", updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/customers/find_all?first_name=#{customer_3.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(customer_3.id.to_s)

    get "/api/v1/customers/find_all?id=#{customer_2.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(customer_2.id.to_s)

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(customer_1.id.to_s)

    get "/api/v1/customers/find_all?updated_at=#{customer_4.updated_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].first["id"]).to eq(customer_4.id.to_s)
  end

  describe 'Business Intelligence Endpoints for customers' do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)

      invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_4 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_5 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_6 = create(:invoice, customer: customer, merchant: merchant_3)
      invoice_7 = create(:invoice, customer: customer, merchant: merchant_4)
      invoice_8 = create(:invoice, customer: customer, merchant: merchant_4)

      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)
      transaction_8 = create(:transaction, invoice: invoice_8)

      get "/api/v1/customers/#{customer.id}/favorite_merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful

      expect(merchant["data"]["id"].to_i).to eq(merchant_2.id)
    end
  end

  describe 'Customers Relationship Endpoints' do
    before(:each) do
      @customer = create(:customer)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @invoice_1 = create(:invoice, customer: @customer, merchant: @merchant_1)
      @invoice_2 = create(:invoice, customer: @customer, merchant: @merchant_1)
      @invoice_3 = create(:invoice, customer: @customer, merchant: @merchant_2)
      @invoice_4 = create(:invoice, customer: @customer, merchant: @merchant_2)
      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_2)
      @transaction_3 = create(:transaction, invoice: @invoice_3)
      @transaction_4 = create(:transaction, invoice: @invoice_4)
    end

    it "returns a collection of associated invoices" do
      get "/api/v1/customers/#{@customer.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful

      expect(invoices["data"].count).to eq(4)
      expect(invoices["data"][0]["id"].to_i).to eq(@invoice_1.id)
      expect(invoices["data"][1]["id"].to_i).to eq(@invoice_2.id)
      expect(invoices["data"][2]["id"].to_i).to eq(@invoice_3.id)
      expect(invoices["data"][3]["id"].to_i).to eq(@invoice_4.id)
    end

    it "returns a collection of associated transactions" do
      get "/api/v1/customers/#{@customer.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful

      expect(transactions["data"].count).to eq(4)
      expect(transactions["data"][0]["id"].to_i).to eq(@transaction_1.id)
      expect(transactions["data"][1]["id"].to_i).to eq(@transaction_2.id)
      expect(transactions["data"][2]["id"].to_i).to eq(@transaction_3.id)
      expect(transactions["data"][3]["id"].to_i).to eq(@transaction_4.id)
    end
  end
end
