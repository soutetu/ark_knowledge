class NoticeMailer < ActionMailer::Base
  default from: ENV["RAILS_MAIL_ADDRESS"]

  def register(user, password)
    @user = user
    @password = password
    @url = "#{BASE_URL}/signin"
    mail to: @user.email, subject: "ユーザ登録"
  end

  def new_question(question)
    @question = question
    @url = "#{BASE_URL}/questions/#{@question.id}"
    mail to: question_to(@question), subject: "質問が投稿されました"
  end

  def update_question(question, user)
    @question = question
    @user = user
    @url = "#{BASE_URL}/questions/#{@question.id}"
    mail to: question_to(@question), subject: "質問が更新されました"
  end

  def delete_question(question, user)
    @question = question
    @user = user
    mail to: question_to(@question), subject: "質問が削除されました"
  end

  private
  def question_to(question)
    question.qa_category.users.pluck(:email).push(question.user.email)
  end
end
