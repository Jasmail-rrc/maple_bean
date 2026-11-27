class Admin::ProductsController < ApplicationController
  before_action :require_admin
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.order(:name)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Product successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      redirect_to admin_products_path, notice: "Product successfully deleted.", status: :see_other
    else
      redirect_to admin_products_path, alert: "Product could not be deleted.", status: :see_other
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :stock_quantity,
      category_ids: []
    )
  end

  def require_admin
    unless session[:admin_logged_in] == true
      redirect_to admin_login_path, alert: "Please log in as an administrator."
    end
  end
end
