class CategoriesController < ApplicationController
  def create
    @category = Category.create(category_params)
  end

  def index
    @categories = Category.all
  end

  def show
    category = Category.find(params[:id])

    @doctor_profiles = category.doctor_profiles
  end

  private

  def category_params
    params.require(:category).permit(:name_us, :name_en)
  end
end
