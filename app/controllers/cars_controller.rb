class CarsController < ApplicationController
  before_filter :set_car, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cars = Car.all
    respond_with(@cars)
  end

  def show
    respond_with(@car)
  end

  def new
    @car = Car.new
    respond_with(@car)
  end

  def edit
  end

  def create
    @car = Car.new(params[:car])
    @car.save
    respond_with(@car)
  end

  def update
    @car.update_attributes(params[:car])
    respond_with(@car)
  end

  def destroy
    @car.destroy
    respond_with(@car)
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end
end
