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
    FactoryBot.create_list(:bike, 10, brand: @brand)
  end
  example '要求ブランド名の自転車を一覧表示する' do
    valid_params = { brand_name: @brand.name }
    get '/api/v1/bikes', params: valid_params
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json['data'].length).to eq(10)
  end

  example '要求ブランド名が存在しない場合、ステータスコード 404 を返す' do
    invalid_params = { brand_name: "hoge" }
    get '/api/v1/bikes', params: invalid_params
    expect(response.status).to eq(404)
  end
end