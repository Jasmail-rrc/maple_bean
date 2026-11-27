class Admin::PagesController < ApplicationController
  before_action :require_admin

  def index
    @pages = Page.order(:title)
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(page_params)
      redirect_to admin_pages_path, notice: "Page successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def page_params
    params.require(:page).permit(:content)
  end

  def require_admin
    unless session[:admin_logged_in] == true
      redirect_to admin_login_path, alert: "Please log in as an administrator."
    end
  end
end