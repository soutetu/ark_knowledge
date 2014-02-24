class SessionsController < ApplicationController
  skip_before_action :require_signin
  layout false

  # POST /signin
  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user
      session[:user] = @user.id
      redirect_to home_path
    else
      flash.now[:alert] = "メールアドレスかパスワードが違います"
      render action: :new
    end
  end

  # GET /signout
  def destroy
    reset_session
    redirect_to signin_path
  end
end
