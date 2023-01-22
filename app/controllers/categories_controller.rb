class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category = Category.find(params[:id])

    @doctor_profiles = category.doctor_profiles
  end
end
