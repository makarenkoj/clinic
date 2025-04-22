class CategoriesController < ApplicationController
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

  def new
    @category = Category.build
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: t('controllers.categories.created')
    else
      redirect_to new_category_path, notice: errors_message_html(@category.errors)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name_ua, :name_en)
  end
end
