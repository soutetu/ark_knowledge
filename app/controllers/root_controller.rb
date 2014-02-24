class RootController < ApplicationController
  skip_before_action :require_signin
  layout false

  # GET /
  def index
    redirect_to home_path if current_user
  end
end
