class UsersController < ApplicationController
  before_action :require_super_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.order("updated_at DESC")
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1
  def show
    set_rel_knowledge
  end

  # POST /users
  def create
    begin
      ActiveRecord::Base.transaction do
        @user, password = User.new_user(user_params)
        @user.save!
        NoticeMailer.register(@user, password).deliver
      end

      redirect_to users_path, notice: "ユーザを追加しました"
    rescue
      render action: :new
    end
  end

  # PATCH /users/1
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "ユーザ情報を変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_path, notice: "ユーザを削除しました"
  end

  # GET /users/search
  def search
    @keyword = params[:keyword]
    @users = User.search(@keyword)

    respond_to do |format|
      format.html {render action: :index}
      format.json {render action: :search}
    end
  end

  # GET /home
  def home
    @user = current_user
    set_rel_knowledge
    render :show
  end

  # PATCH /profile
  def update_profile
    if current_user.update(user_names)
      redirect_to profile_path, notice: "ユーザ名を変更しました"
    else
      render action: :profile
    end
  end

  # PATCH /password
  def update_password
    begin
      Passwd.confirm_check(params[:new_password], params[:new_password_confirmation])
      current_user.update_password(params[:old_password], params[:new_password], true)
      current_user.save!
      session[:user] = nil
      redirect_to signin_path, notice: "新しいパスワードにて再度ログインして下さい" and return
    rescue Passwd::PasswordNotMatch
      flash.now[:alert] = "パスワードが一致しません"
    rescue Passwd::AuthError
      flash.now[:alert] = "パスワードが間違っています"
    rescue Passwd::PolicyNotMatch
      flash.now[:alert] = "パスワードの強度が不足しています"
    rescue
      flash.now[:alert] = "パスワードの更新が失敗しました"
    end
    
    render action: :profile
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :role)
  end

  def user_names
    params.require(:user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_rel_knowledge
    @questions = Question.rel_user(@user)
    @topics = Board.rel_user(@user)
  end
end
