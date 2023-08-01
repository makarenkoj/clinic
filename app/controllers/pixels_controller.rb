class PixelsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update delete_all delete_last]

  def index
    @pixels = Pixel.all
    render json: @pixels
  end

  def create
    @pixel = Pixel.new(pixel_params.merge(user: current_user))

    if @pixel.save
      render json: @pixel, status: :created
    else
      render json: @pixel.errors, status: :unprocessable_entity
    end
  end 

  def update
    @pixel = Pixel.find(params[:id])
  
    if @pixel.update(pixel_params)
      render json: @pixel
    else
      render json: @pixel.errors, status: :unprocessable_entity
    end
  end

  def delete_all
    pixels = current_user.pixels

    ActiveRecord::Base.transaction do
      pixels.each(&:destroy)
    end

    redirect_to pages_space_path, notice: t('pages.secret.clear')
  end

  def delete_last
    pixel = current_user.pixels.last

    pixel.destroy

    redirect_to pages_space_path, notice: t('pages.secret.last')
  end

  private 

  def pixel_params
    params.require(:pixel).permit(:x, :y, :color)
  end
end
