# 自転車管理コントローラー
class Api::V1::BikesController < ApplicationController
  before_action :set_brand, only: [:index]
  before_action :create_or_set_brand, only: [:create]
  before_action :set_bike, only: [:update]

  # GET api/v1/bikes
  def index
    bikes = @brand.bikes.all
    bikes = bikes.includes(:brand)
    render status: :ok, json: { data: bikes }
  end

  # POST /api/v1/bikes
  def create
    bike = Bike.new(brand_id: @brand.id, serial_number: params[:serial_number])
    if bike.save
      render status: :created, json: { data: bike }
    else
      render status: :unprocessable_entity, json: { errors: bike.errors }
    end
  end

  # PUT /api/v1/bikes
  def update
    @bike.sold_at = Time.zone.now
    if @bike.save
      render status: :accepted, json: { data: @bike }
    else
      render status: :unprocessable_entity, json: { errors: @bike.errors }
    end
  end

  private

  def set_brand
    @brand = Brand.find_by(name: params[:brand_name])
    render status: :not_found, json: { errors: :not_found } if @brand.nil?
  end

  def create_or_set_brand
    @brand = Brand.find_by(name: params[:brand_name])
    @brand = Brand.create(name: params[:brand_name]) if @brand.nil?
  end

  def set_bike
    @bike = Bike.find_by(serial_number: params[:serial_number])
    render status: :not_found, json: { errors: :not_found } if @bike.nil?
  end
end
