require 'rails_helper'

describe "Merchants API" do
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
end
