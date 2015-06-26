class CarsController < ApplicationController
  before_filter :set_car, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :update]
  before_filter :is_owner? , only: [:edit, :update]
  respond_to :html

  def index
    if user_signed_in? #If user signed in, just list all cars owned by current user
      @cars = Car.owned_by_user(current_user).order('cars.name ASC')
    
    else
      @cars = Car.order('cars.name ASC')

      # Cars with at least 200 horsepowers
      @cars_200 = Car.where('horsepower >= ?', 200).order('cars.name ASC')
      p @cars_200

      #grey cars with at least 200 horsepowers and owned by woman
      @cars_200_female = Car.owned_by_female.where('horsepower >= ?', 200).order('cars.name ASC')
      p @cars_200_female

    end
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
    @car = Car.new(params[:car].merge(:user => current_user))
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

    def is_owner?
      redirect_to car_path(@car) ,alert: 'You can only edit your own car.' unless @car.user == current_user
    end

end
