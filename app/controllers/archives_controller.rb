class ArchivesController < ApplicationController

  def index
    @archives = Archive.find_archives(params)
  end

  def new
    @archive = Archive.new
  end

  def create
    @archive = Archive.new
    @archive.create_archive(params[:archive])
    redirect_to @archive, notice: I18n.t(:share_ok)
  rescue Exception => exception
    flash.now[:error] = exception.message
    render :new
  end

  def show
    @archive = Archive.find(params[:id])
  end

  def destroy
    @archive = Archive.find(params[:id])
    @archive.destroy
    redirect_to fetch_url, notice: I18n.t(:destroy_ok)
  end

  def download
    @archive = Archive.find(params[:id])
    unless @archive.is_include_file?
      redirect_to fetch_url, notice: I18n.t(:without_file)
      return
    end

    send_file @archive.file_path, :filename => @archive.file_origin_name
  end

end
