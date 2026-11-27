class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.all

    if params[:category_id].present?
      @products = @products.joins(:categories)
                           .where(categories: { id: params[:category_id] })
    end

    if params[:search].present?
      keyword = "%#{Product.sanitize_sql_like(params[:search].strip)}%"

      @products = @products.where(
        "LOWER(products.name) LIKE LOWER(:keyword) OR LOWER(products.description) LIKE LOWER(:keyword)",
        keyword: keyword
      )
    end

    case params[:filter]
    when "new"
      @products = @products.where(
        "products.created_at >= ?", 3.days.ago
      )
    when "recently_updated"
      @products = @products.where(
        "products.updated_at >= ? AND products.created_at < ?",
        3.days.ago, 3.days.ago
      )
    end

    @products = @products.distinct.order(:name).page(params[:page]).per(6)
  end

  def show
    @product = Product.find(params[:id])
  end
end
