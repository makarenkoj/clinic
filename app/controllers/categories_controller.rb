class CategoriesController < ApplicationController
  def create
    @category = Category.create(category_params)
  end

  def index
    pagination_conditions = params[:next_categories] ? ['id >= ?', params[:next_categories]] : nil

    all_categories = Category.where(pagination_conditions).order(id: params_order).limit(11).to_a
    @categories = all_categories[0..9]
    @next_categories = all_categories[10]
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
