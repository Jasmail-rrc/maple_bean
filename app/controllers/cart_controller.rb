
class CartController < ApplicationController
  before_action :initialize_cart

  def index
    @cart_items = []

    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)

      next unless product

      @cart_items << {
        product: product,
        quantity: quantity.to_i,
        total: product.price * quantity.to_i
      }
    end

    @cart_total = @cart_items.sum { |item| item[:total] }
  end

  def add
    product = Product.find(params[:product_id])

    quantity = params.fetch(:quantity, 1).to_i
    quantity = 1 if quantity < 1

    product_id = product.id.to_s
    current_quantity = session[:cart].fetch(product_id, 0).to_i

    if current_quantity + quantity > product.stock_quantity
      redirect_to product_path(product),
                  alert: "Not enough stock available."
      return
    end

    session[:cart][product_id] = current_quantity + quantity

    redirect_to cart_path,
                notice: "#{product.name} added to your cart."
  end

  def update
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity < 1
      redirect_to cart_path,
                  alert: "Quantity must be at least 1."
      return
    end

    if quantity > product.stock_quantity
      redirect_to cart_path,
                  alert: "Not enough stock available."
      return
    end

    session[:cart][product.id.to_s] = quantity

    redirect_to cart_path,
                notice: "Cart quantity updated."
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)

    redirect_to cart_path,
                notice: "Product removed from cart."
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end
end
