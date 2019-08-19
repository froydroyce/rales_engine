require 'rails_helper'

RSpec.describe "Transactions API" do
  it 'sends a list of transactions' do

    create_list(:transaction, 10)
    get '/api/v1/transactions'

    expect(response).to be_successful
    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(10)
  end

  it "can get one transaction" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(id.to_s)
  end

  it "it can find a single transaction" do
    invoice = create(:invoice)
    transaction_1 = create(:transaction, invoice: invoice, created_at: "2019-08-13 21:03:01 UTC")
    transaction_2 = create(:transaction, invoice: invoice)
    transaction_3 = create(:transaction, invoice: invoice)
    transaction_4 = create(:transaction, invoice: invoice, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/transactions/find?credit_card_number=#{transaction_3.credit_card_number}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(transaction_3.id.to_s)

    get "/api/v1/transactions/find?id=#{transaction_2.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(transaction_2.id.to_s)

    get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(transaction_1.id.to_s)

    get "/api/v1/transactions/find?updated_at=#{transaction_4.updated_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"]).to eq(transaction_4.id.to_s)

    get "/api/v1/transactions/#{transaction_1.id}/invoice"

    invoice_ = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_["data"]["id"]).to eq(invoice.id.to_s)
  end

  it "can find multiple transactions" do
    invoice = create(:invoice)
    transaction_1 = create(:transaction, invoice: invoice, created_at: "2019-08-13 21:03:01 UTC")
    transaction_2 = create(:transaction, invoice: invoice)
    transaction_3 = create(:transaction, invoice: invoice)
    transaction_4 = create(:transaction, invoice: invoice, updated_at: "2019-08-13 21:03:01 UTC")

    get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"].first["id"]).to eq(transaction_2.id.to_s)

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"].first["id"]).to eq(transaction_1.id.to_s)

    get "/api/v1/transactions/find_all?updated_at=#{transaction_4.updated_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"].first["id"]).to eq(transaction_4.id.to_s)
  end
end
