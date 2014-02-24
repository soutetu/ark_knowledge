class BoardCategoriesController < ApplicationController
  before_action :require_super_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_board_category, only: [:edit, :update, :destroy]

  # GET /board_categories
  def index
    @board_categories = BoardCategory.all
  end

  # GET /board_categories/new
  def new
    @board_category = BoardCategory.new
  end

  # POST /board_categories
  def create
    @board_category = BoardCategory.new(board_category_params)

    if @board_category.save
      redirect_to board_categories_path, notice: "カテゴリを追加しました"
    else
      render action: :new
    end
  end

  # PATCH/PUT /board_categories/1
  def update
    if @board_category.update(board_category_params)
      redirect_to board_categories_path, notice: "カテゴリを変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /board_categories/1
  def destroy
    @board_category.destroy
    redirect_to board_categories_path, notice: "カテゴリを削除しました"
  end

  private
  def set_board_category
    @board_category = BoardCategory.find(params[:id])
  end

  def board_category_params
    params.require(:board_category).permit(:name, :description)
  end
end
