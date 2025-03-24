class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private 

  def record_not_found
    render json: "Record not found", status: :not_found
  end

  def render_errors(entity)
    render 'api/shared/errors', locals: { entity: }, status: :unprocessable_entity
  end
end
