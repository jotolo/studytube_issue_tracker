class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from CanCan::AccessDenied do |exception|
    render json: {errors: exception.message}, status: 403
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {errors: exception.message}, status: 404
  end

  rescue_from ActionController::BadRequest do |exception|
    render json: {errors: exception.message}, status: 400
  end
end
