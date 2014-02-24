class FilesController < ApplicationController
  before_action :set_file_category, only: [:index, :create]
  before_action :set_file, only: [:show, :destroy]
  before_action :require_owner_or_super, only: [:destroy]

  # GET /files/1
  def show
    send_file(@file.path, filename: @file.orig_name, type: @file.content_type)
  end

  # POST /files_categories/1/files
  def create
    begin
      ActiveRecord::Base.transaction do
        @file = Attachment.new_file(params[:attachment], @file_category, current_user)
        @file.save!
        local = File.open(@file.path, "wb")
        local.write(params[:attachment].read)
        local.close
      end

      redirect_to file_category_files_path(@file_category), notice: "ファイルを追加しました"
    rescue
      flash.now[:alert] = "ファイルの追加が失敗しました"
      render action: :index
    end
  end

  # DELETE /files/1
  def destroy
    category = @file.file_category
    FileUtils.rm(@file.path, force: true)
    @file.destroy
    redirect_to file_category_files_path(category), notice: "ファイルを削除しました"
  end

  private
  def set_file
    @file = Attachment.find(params[:id])
  end

  def set_file_category
    @file_category = FileCategory.find(params[:file_category_id])
  end

  def require_owner_or_super
    unless current_user.id == @file.user.id || current_user.super_user?
      render file: "public/404", status: 404, layout: false and return
    end
  end
end
