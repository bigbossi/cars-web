class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :clear_cars_list_cache


  def clear_cars_list_cache
    if devise_controller?
      Rails.cache.clear 'all_cars'
    end
  end

end
