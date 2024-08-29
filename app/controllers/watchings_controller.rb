class WatchingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_user!, only: %i[show index]

  def index
    redirect_to root_path unless current_user.email == 'makarenkoj53@gmail.com'

    @watchings = Watching.order(updated_at: params_order).paginate(page: params[:page])
  end

  def show
    redirect_to root_path unless current_user.email == 'makarenkoj53@gmail.com'

    @watching = Watching.find_by(id: params[:id])
  end

  def create
    watching = Watching.find_by(ip: watching_params['ip'])

    if watching.present?
      watching.update(watching_params)
      watching.viewing += 1
    else
      watching = Watching.new(watching_params)
    end

    if watching.save
      render 'watchings/create', formats: [:json], locals: { watching: watching }
    else
      render_error(error: watching.errors.messages.transform_values { |msgs| msgs[0] })
    end
  end

  def destroy
    unless current_user.email == 'makarenkoj53@gmail.com'
      redirect_to root_path
      return
    end

    watching = Watching.find_by(id: params[:id])

    if watching.destroy
      redirect_to watchings_path, notice: t('view.watching.destroyed')
    else
      redirect_to watching_path(watching), notice: t('controllers.note.edit')
    end
  end

  private

  def watching_params
    params.require(:watching).permit(:ip, :status, :message, :country, :country_code, :region, :region_name, :city, :zip, :lat, :lon, :timezone, :isp, :org, :as, :proxy, 
                                     :hosting, :query)
  end

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*' # Allow requests from any domain
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
  end
end
