class BoardsController < ApplicationController
  before_action :set_board_category, only: [:index, :new, :create]
  before_action :set_board, only: [:show, :edit, :update, :destroy, :comment, :uncomment]
  before_action :require_owner_or_super, only: [:edit, :update, :destroy]

  # GET /board_categories/1/boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1
  def show
    @comments = @board.comments.order("created_at DESC")
  end

  # POST /board_categories/1/boards
  def create
    @board = Board.new_topic(board_params, @board_category, current_user)

    if @board.save
      redirect_to board_category_boards_path(@board_category), notice: "トピックを追加しました"
    else
      render action: :new
    end
  end

  # PATCH /boards/1
  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: "トピックを変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /boards/1
  def destroy
    category = @board.board_category
    @board.destroy
    redirect_to board_category_boards_path(category), notice: "トピックを削除しました"
  end

  # POST /boards/1/comments
  def comment
    @comment = Comment.new(message: params[:message], user_id: current_user.id, board_id: @board.id)

    if @comment.save
      redirect_to board_path(@board), notice: "コメントを投稿しました"
    else
      @message = params[:message]
      @comments = @board.comments.order("created_at DESC")
      render action: :show
    end
  end

  # DELETE /boards/1/comments/1
  def uncomment
    @comment = Comment.find(params[:comment_id])

    if current_user.id == @board.user.id || current_user.super_user?
      @comment.destroy
      redirect_to board_path(@board), notice: "コメントを削除しました"
    else
      render file: "public/404", status: 404, layout: false
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :body)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def set_board_category
    @board_category = BoardCategory.find(params[:board_category_id])
  end

  def require_owner_or_super
    unless current_user.id == @board.user.id || current_user.super_user?
      render file: "public/404", status: 404, layout: false and return
    end
  end
end
