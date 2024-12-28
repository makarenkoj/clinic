class JsPayloadsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create index]
  before_action :set_cors_headers, only: %i[create]
  
  def show
    @js_payload = JsPayload.find_by(id: params[:id])

    if @js_payload.present?
      render 'js_payloads/show', locals: { js_payload: @js_payload }
    else
      render_inactive
    end
  end

  def index
    @js_payloads = JsPayload.all

    render 'js_payloads/index', locals: { js_payloads: @js_payloads }
  end

  def create
    js_payload = JsPayload.new(payload: params[:js_payload])
    binding.break
    if js_payload.save
      render 'js_payloads/create', locals: { js_payload: js_payload }
    else
      render_json_error(error: format_model_errors(js_payload))
    end
  end

  private

  # def js_payload_params
  #   params.require(:js_payload).permit(:payload)
  # end

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*' # Allow requests from any domain
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
  end
end
