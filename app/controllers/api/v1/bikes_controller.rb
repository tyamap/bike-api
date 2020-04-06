# 自転車管理コントローラー
class Api::V1::BikesController < ApplicationController
  # GET api/v1/bikes
  def index
    brand = get_brand_by_name(params[:brand_name])
    # TODO: nilだった場合のエラーハンドリングを親クラスに定義して共通化
    if brand.present?
      bikes = brand.bikes.all
      render status: :ok, json: { data: bikes }
    else
      render status: :not_found, json: { errors: :not_found }
    end
  end

  # POST /api/v1/bikes
  def create
    brand = Brand.find_by(name: params[:brand_name])
    # TODO: 以下のロジックを分離したほうが良い？
    brand_id = if brand.nil?
                 Brand.create(name: params[:brand_name]).id
               else
                 brand.id
               end
    bike = Bike.new(brand_id: brand_id, serial_number: params[:serial_number])
    if bike.save
      render status: :created, json: { data: bike }
    else
      render status: :unprocessable_entity, json: { errors: bike.errors }
    end
  end

  # PUT /api/v1/bikes
  def update
    bike = Bike.find_by(serial_number: params[:serial_number])
    if bike.nil?
      render status: :not_found
    # TODO: Modelでバリデーションできないか？
    elsif bike.sold_at.nil?
    else
      bike.sold_at = Time.zone.now
      if bike.save
        render status: :accepted, json: { data: bike }
      else
        render status: :unprocessable_entity, json: { errors: bike.errors }
      end
    end
  end

  private

  def get_brand_by_name(name)
    Brand.find_by(name: name)
  end
end
