require 'rails_helper'

RSpec.describe '/api/v1/bikes', type: :request do
  describe 'NewBikeApi' do
    before do
      @brand = FactoryBot.create(:brand)
      @serial_number = '1111'
    end
    example '新しい自転車を登録する' do
      valid_params = { brand_name: @brand.name, serial_number: @serial_number }
      expect { post '/api/v1/bikes', params: valid_params }.to change(Bike, :count).by(+1)
      expect(response.status).to eq(201)
    end

    example 'データベースにすでにあるブランド名で登録された際、ブランドテーブルには何も追加されない' do
      valid_params = { brand_name: @brand.name, serial_number: @serial_number }
      expect { post '/api/v1/bikes', params: valid_params }.to change(Brand, :count).by(0)
      expect(response.status).to eq(201)
    end

    example 'データベースにないブランド名で登録された際、ブランドテーブルにブランドを追加する' do
      valid_params = { brand_name: 'hoge', serial_number: @serial_number }
      expect { post '/api/v1/bikes', params: valid_params }.to change(Brand, :count).by(+1)
      expect(response.status).to eq(201)
    end

    example '新規ブランド名が256文字以上の場合、ステータスコード 422 を返す' do
      invalid_params = { brand_name: 'a' * 256, serial_number: @serial_number }
      post '/api/v1/bikes', params: invalid_params
      expect(response.status).to eq(422)
    end

    example 'すでに登録されているシリアルナンバーが登録された場合、ステータスコード 422 を返す' do
      valid_params = { brand_name: @brand.name, serial_number: @serial_number }
      post '/api/v1/bikes', params: valid_params
      invalid_params = { brand_name: 'hoge', serial_number: @serial_number }
      post '/api/v1/bikes', params: invalid_params
      expect(response.status).to eq(422)
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
      invalid_params = { brand_name: 'hoge' }
      get '/api/v1/bikes', params: invalid_params
      expect(response.status).to eq(404)
    end
  end

  describe 'SaleBikesApi' do
    before do
      brand = FactoryBot.create(:brand)
      @bike = FactoryBot.create(:bike, brand: brand)
    end
    example 'シリアルナンバーで指定した自転車に売却日（現在日時）を追加する' do
      expect(Bike.first.sold_at).to be nil
      valid_params = { serial_number: @bike.serial_number }
      put '/api/v1/bikes', params: valid_params
      expect(Bike.first.sold_at).not_to be nil
      expect(response.status).to eq(202)
    end

    example '要求シリアルナンバーが存在しない場合、ステータスコード 404 を返す' do
      invalid_params = { serial_number: 'hoge' }
      put '/api/v1/bikes', params: invalid_params
      expect(response.status).to eq(404)
    end

    example 'すでに売却済みの場合、DB更新エラーとしてステータスコード422を返す' do
      valid_params = { serial_number: @bike.serial_number }
      # 二回実行
      put '/api/v1/bikes', params: valid_params
      put '/api/v1/bikes', params: valid_params
      expect(response.status).to eq(422)
    end
  end
end
