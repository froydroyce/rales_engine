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
end
