class User::OrdersController < ApplicationController
  before_action :exclude_admin

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    nickname = params[:order][:address_id]
    address = current_user.find_address(nickname)
    order = current_user.orders.new(address_id: address.id)
    order.save
      cart.items.each do |item|
        order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
          })
      end
    session.delete(:cart)
    flash[:notice] = "Order created successfully!"
    redirect_to '/profile/orders'
  end

  def cancel
    order = current_user.orders.find(params[:id])
    order.cancel
    redirect_to "/profile/orders/#{order.id}"
  end

  def update
    nickname = params[:order][:address_id]
    address = current_user.find_address(nickname)
    order = Order.find(params[:id])
    order.update(address_id: address.id)
    redirect_to "/profile/orders/#{order.id}"
  end
end
