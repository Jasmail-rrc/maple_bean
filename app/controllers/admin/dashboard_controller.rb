
class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @total_products = Product.count
    @total_categories = Category.count
  end

  private

  def require_admin
    unless session[:admin_logged_in] == true
      redirect_to admin_login_path,
                  alert: "Please log in as an administrator."
    end
  end
end
