require 'rails_helper'

describe 'NewBikeApi' do
  example '新しい自転車を登録する' do
    valid_params = { brand_name: 'brand_1', serial_number: 'bike_1' }
    expect { post '/api/v1/bikes', params: valid_params }.to change(Bike, :count).by(+1)
    expect(response.status).to eq(201)
  end
end
