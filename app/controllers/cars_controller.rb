class CarsController < ApplicationController
  before_filter :set_car, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :update]
  before_filter :is_owner? , only: [:edit, :update]
  after_filter :clear_list_cars_cache, only:[:update, :destroy_multiple, :destroy, :create]
  respond_to :html

  def index
    if user_signed_in? #If user signed in, just list all cars owned by current user
      @cars = Car.owned_by_user(current_user).order('cars.name ASC')
    
    else
      @cars = Car.order('cars.name ASC') unless fragment_exist?('all_cars')

      #puts "Exist cache " + fragment_exist?('all_cars')

      # Cars with at least 200 horsepowers
      @cars_200 = Car.where('horsepower >= ?', 200).order('cars.name ASC')
      
      #grey cars with at least 200 horsepowers and owned by woman
      @cars_grey_200_female = Car.owned_by_female.where('cars.horsepower >= ? and lower(cars.color) = ?', 200, 'grey').order('cars.name ASC')
      
    end
    respond_with @cars do |format|
      format.xml { render :layout => false, :text => @cars.to_xml }
      format.html
    end
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
    @car = Car.new(car_params.merge(:user => current_user))
    @car.save
    respond_with(@car)
  end

  def update
    @car.update_attributes(car_params)

    respond_with(@car)
  end

  def destroy
    @car.destroy
    respond_with(@car)
  end

  def destroy_multiple
    if params[:cars_list].present?
      Car.destroy(params[:cars_list])
      redirect_to cars_path, notice: 'Delete selected successfully!'
    else
      redirect_to cars_path, alert: 'You have to select at lease one car to delete.'
    end
  end

  def clear_list_cars_cache_by_request
    if user_signed_in?
      redirect_to cars_path, alert: 'This available on guest only, :))'
    else
      Rails.cache.clear 'all_cars'
      # Query again to get cars list
      @cars = Car.order('cars.name ASC')
      respond_to do |format|
        format.js
      end
    end
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:name, :color, :horsepower)
    end

    def clear_list_cars_cache
      Rails.cache.clear 'all_cars'
    end

    def is_owner?
      redirect_to car_path(@car) ,alert: 'You can only edit your own car.' unless @car.user == current_user
    end

end
