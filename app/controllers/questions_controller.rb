class QuestionsController < ApplicationController
  before_action :set_qa_category, only: [:index, :new, :create]
  before_action :set_question, only: [:show, :edit, :update, :destroy, :answer, :unanswered]
  before_action :require_owner_or_manager_or_super, only: [:edit, :update, :destroy]

  # GET /qa_categories/1/questions/new
  def new
    @question = Question.new(replay_deadline: "手が空いたら", status: "新規")
  end

  # GET /questions/1
  def show
    @answers = @question.answers.order("created_at DESC")
  end

  # POST /qa_categories/1/questions
  def create
    @question = Question.new_question(question_params, @qa_category, current_user)

    if @question.save
      NoticeMailer.new_question(@question).deliver
      redirect_to qa_category_questions_path(@qa_category), notice: "質問を投稿しました"
    else
      render action: :new
    end
  end

  # PATCH /questions/1
  def update
    if @question.update(question_params)
      NoticeMailer.update_question(@question, current_user).deliver
      redirect_to question_path(@question), notice: "質問を変更しました"
    else
      render action: :edit
    end
  end

  # DELETE /questions/1
  def destroy
    category = @question.qa_category
    @question.destroy
    NoticeMailer.delete_question(@question, current_user).deliver
    redirect_to qa_category_questions_path(category), notice: "質問を削除しました"
  end

  # POST /questions/1/answers
  def answer
    @answer = Answer.new(message: params[:message], user_id: current_user.id, question_id: @question.id)

    if @answer.save
      redirect_to question_path(@question), notice: "コメントを投稿しました"
    else
      @message = params[:message]
      @answers = @question.answers.order("created_at DESC")
      render action: :show
    end
  end

  # DELETE /questions/1/answers/1
  def unanswered
    @answer = Answer.find(params[:answer_id])

    if current_user.id == @answer.user.id || current_user.super_user?
      @answer.destroy
      redirect_to question_path(@question), notice: "コメントを削除しました"
    else
      render file: "public/404", status: 404, layout: false
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, :status, :replay_deadline)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_qa_category
    @qa_category = QaCategory.find(params[:qa_category_id])
  end

  def require_owner_or_manager_or_super
    unless current_user.id == @question.user.id || @question.qa_category.category_manager?(current_user) || current_user.super_user?
      render file: "public/404", status: 404, layout: false and return
    end
  end
end
