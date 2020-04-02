class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :update, :destroy]

  # GET /bikes
  def index
    @bikes = Bike.all

    render json: @bikes
  end

  # GET /bikes/1
  def show
    render json: @bike
  end

  # POST /bikes
  def create
    @bike = Bike.new(bike_params)

    if @bike.save
      render json: @bike, status: :created, location: @bike
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bikes/1
  def update
    if @bike.update(bike_params)
      render json: @bike
    else
      render json: @bike.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bikes/1
  def destroy
    @bike.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike
      @bike = Bike.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bike_params
      params.fetch(:bike, {})
    end
end
