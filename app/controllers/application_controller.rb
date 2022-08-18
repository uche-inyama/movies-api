class ApplicationController < ActionController::Base
  include SessionsHelper
  include JsonWebToken
  
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decode = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  protected :configure_permitted_parameters
  private :authorize_request
end
