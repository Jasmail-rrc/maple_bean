
class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    username = ENV["ADMIN_USERNAME"]
    password = ENV["ADMIN_PASSWORD"]

    if username.present? && password.present? &&
       ActiveSupport::SecurityUtils.secure_compare(params[:username].to_s, username) &&
       ActiveSupport::SecurityUtils.secure_compare(params[:password].to_s, password)

      reset_session
      session[:admin_logged_in] = true

      redirect_to admin_dashboard_path,
                  notice: "Successfully logged in."
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session

    redirect_to admin_login_path,
                notice: "Successfully logged out."
  end
end
