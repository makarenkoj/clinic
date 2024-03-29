class ErrorsController < ActionController::Base
  def internal_server_error
    render status: 500
  end

  def not_found
    render status: 404
  end

  def unprocessable_content
    render status: 422
  end
end
