# 自転車管理コントローラー
class Api::V1::BikesController < ApplicationController
  # GET api/v1/bikes
  def index
    brand = Brand.find_by(name: params[:brand_name])
    if brand.nil?
      render status: :not_found
    else
      bikes = brand.bikes.all
      render status: :ok, json: { data: bikes }
    end
  end

  # POST /api/v1/bikes
  def create
    brand = Brand.find_by(name: params[:brand_name])
    brand_id = if brand.nil?
                 Brand.create(name: params[:brand_name]).id
               else
                 brand.id
               end
    bike = Bike.new(brand_id: brand_id, serial_number: create_bike_params[:serial_number])
    if bike.save!
      render json: bike, status: :created
    else
      render json: bike.errors, status: :unprocessable_entity
    end
  end

  private

  def create_bike_params
    params.permit(:brand_name, :serial_number)
  end
end
