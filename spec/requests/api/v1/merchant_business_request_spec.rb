require 'rails_helper'

describe 'Merchants Business Data Endpoints' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "merchant 1")
    @merchant_2 = Merchant.create!(name: "merchant 2")
    @merchant_3 = Merchant.create!(name: "merchant 3")
    @merchant_4 = Merchant.create!(name: "merchant 4")
  end
end
