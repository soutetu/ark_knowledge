class GroupsController < ApplicationController
  before_action :require_super_user, only: [:new, :edit, :create, :update, :destroy, :add_user, :del_user]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :add_user, :del_user]

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to group_path(@group), notice: "グループを追加しました"
    else
      render action: :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "グループ情報を変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end

  # POST /groups/1/add_user
  def add_user
    begin
      @user = User.find_by!(email: params[:email])
      Affiliation.create!(group_id: @group.id, user_id: @user.id)
      redirect_to group_path(@group), notice: "グループにユーザを追加しました" and return
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = "指定されたメールアドレスは登録されていません"
    rescue ActiveRecord::RecordInvalid
      flash.now[:alert] = "指定されたユーザは既にグループに所属しています"
    end

    render action: :show
  end

  # DELETE /groups/1/del_user
  def del_user
    @affiliation = Affiliation.find_by!(group_id: @group.id, user_id: params[:user_id])
    @affiliation.destroy
    redirect_to group_path(@group), notice: "グループからユーザを削除しました"
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
