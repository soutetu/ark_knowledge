class FileCategoriesController < ApplicationController
  before_action :require_super_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_file_category, only: [:edit, :update, :destroy]

  # GET /file_categories
  def index
    @file_categories = FileCategory.all
  end

  # GET /file_categories/new
  def new
    @file_category = FileCategory.new
  end

  # POST /file_categories
  def create
    @file_category = FileCategory.new(file_category_params)

    if @file_category.save
      redirect_to file_categories_path, notice: "カテゴリを追加しました"
    else
      render action: :new
    end
  end

  # PATCH/PUT /file_categories/1
  def update
    if @file_category.update(file_category_params)
      redirect_to file_categories_path, notice: "カテゴリを変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /file_categories/1
  def destroy
    @file_category.destroy
    redirect_to file_categories_path, notice: "カテゴリを削除しました"
  end

  private
  def set_file_category
    @file_category = FileCategory.find(params[:id])
  end

  def file_category_params
    params.require(:file_category).permit(:name, :description)
  end
end
