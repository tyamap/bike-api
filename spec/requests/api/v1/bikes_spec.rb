require 'rails_helper'

describe 'NewBikeApi' do
  example '新しい自転車を登録する' do
    valid_params = { brand_name: 'brand_1', serial_number: 'bike_1' }
    expect { post '/api/v1/bikes', params: valid_params }.to change(Bike, :count).by(+1)
    expect(response.status).to eq(201)
  end
end

describe 'ShowBikesApi' do
  before do
    @brand = FactoryBot.create(:brand)
  end
  example '要求ブランド名の自転車を一覧表示する' do
    valid_params = { brand_name: @brand.name }
    FactoryBot.create_list(:bike, 10, brand: @brand)
    get '/api/v1/bikes', params: valid_params
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.length).to eq(10)
  end
end