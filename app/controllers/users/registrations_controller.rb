class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :email, :gender)
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :gender, :password, :password_confirmation, :current_password) }
  end
end