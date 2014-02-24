class QaCategoriesController < ApplicationController
  before_action :require_super_user, only: [:show, :new, :edit, :create, :update, :destroy, :add_user, :del_user]
  before_action :set_qa_category, only: [:show, :edit, :update, :destroy, :add_user, :del_user]

  # GET /qa_categories
  def index
    @qa_categories = QaCategory.all
  end

  # GET /qa_categories/new
  def new
    @qa_category = QaCategory.new
  end

  # POST /qa_categories
  def create
    @qa_category = QaCategory.new(qa_category_params)

    if @qa_category.save
      redirect_to qa_categories_path, notice: "カテゴリを追加しました"
    else
      render action: :new
    end
  end

  # PATCH/PUT /qa_categories/1
  def update
    if @qa_category.update(qa_category_params)
      redirect_to qa_categories_path, notice: "カテゴリを変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /qa_categories/1
  def destroy
    @qa_category.destroy
    redirect_to qa_categories_path, notice: "カテゴリを削除しました"
  end

  # POST /qa_categories/1/add_user
  def add_user
    begin
      @user = User.find_by!(email: params[:email])
      AnswerUser.create!(qa_category_id: @qa_category.id, user_id: @user.id)
      redirect_to qa_category_path(@qa_category), notice: "カテゴリに管理者を追加しました" and return
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "指定されたメールアドレスは登録されていません"
    rescue ActiveRecord::RecordInvalid
      flash.now[:alert] = "指定されたユーザは既にカテゴリ管理者です"
    end

    render action: :show
  end

  # DELETE /qa_categories/1/del_user
  def del_user
    @answer_user = AnswerUser.find_by!(qa_category_id: @qa_category.id, user_id: params[:user_id])
    @answer_user.destroy
    redirect_to qa_category_path(@qa_category), notice: "カテゴリから管理者を削除しました"
  end

  private
  def set_qa_category
    @qa_category = QaCategory.find(params[:id])
  end

  def qa_category_params
    params.require(:qa_category).permit(:name, :description)
  end
end
