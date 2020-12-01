class ShoppingController < ApplicationController
  def index
    @cart = session[:cart]
    @products = []
    if @cart.nil?

    else
      @cart.each do |cart|
        total = cart["game"]["price"].to_i * cart["qty"].to_i

        new_product = { "game" => cart["game"], "qty" => cart["qty"], "total" => total }
        @products.push(new_product)
      end
    end
  end

  def update
    cart = session[:cart]

    found = false
    item_id = nil
    item_qty = nil
    item_index = nil

    cart.each_with_index do |item, index|
      next unless item["game"]["id"].to_i == params[:id].to_i

      found = true
      item_id = item["game"]
      item_qty = params[:keywords]
      item_index = index
    end

    if found
      newValue = { "game" => item_id, "qty" => item_qty }
      cart.delete_at(item_index)
      cart.push(newValue)
    end
    session[:cart] = cart
    redirect_to shopping_index_path
    # puts session[:cart]
  end

  def remove
    cart = session[:cart]
    found = false
    item_index = nil

    cart.each_with_index do |item, index|
      if item["game"]["id"].to_i == params[:id].to_i
        found = true
        item_index = index
      end
    end

    cart.delete_at(item_index) if found

    session[:cart] = cart
    redirect_to shopping_index_path
  end

  def checkout
    session[:province] = params[:selector]
    session[:name] = params[:name]
    redirect_to checkout__path
  end

  def checkout_
    @cart = session[:cart]
    @subtotal = 0
    @cart.each_with_index do |item, index|
      @subtotal += item["game"]["price"].to_i * item["qty"].to_i
    end

    province = session[:province]

    pst_amount = 0

    if province == "Alberta"
      pst_amount = 0.00
    elsif province == "British Columbia"
      pst_amount = 0.07
    elsif province == "Manitoba"
      pst_amount = 0.07
    elsif province == "New Brunswick"
      pst_amount = 0.10
    elsif province == "Newfoundland and Labrador"
      pst_amount = 0.10
    elsif province == "Northwest Territories"
      pst_amount = 0.00
    elsif province == "Nova Scotia"
      pst_amount = 0.10
    elsif province == "Nunavut"
      pst_amount = 0.00
    elsif province == "Ontario"
      pst_amount = 0.08
    elsif province == "Prince Edward Island"
      pst_amount = 0.10
    elsif province == "Quebec"
      pst_amount = 0.09975
    elsif province == "Saskatchewan"
      pst_amount = 0.06
    elsif province == "Yukon"
      pst_amount = 0.00
    end

    @gst = (@subtotal * 0.05).round(2)
    @pst = (@subtotal * pst_amount).round(2)

    @total = @subtotal + @gst + @pst

    session[:total] = @total
  end

  def final
    total = session[:total]
    cart = session[:cart]
    name = session[:name]
    province = session[:province]

    time = Time.new

    customer = Customer.find_or_create_by(name: name, address: province)
    customer.save

    new_order = Order.create(date: time.inspect, status: 1, comments: "test order", customer_id: customer.id)
    new_order.save

    cart.each do |n|
      new_item = new_order.order_games.create(
        product_id:  n["game"]["name"],
        qty:         n["qty"],
        order_price: (n["qty"].to_i * n["game"]["price"].to_i)
      )

      new_item.save
    end

    session[:total] = nil
    session[:cart] = nil

    @order = new_order
  end

  def show; end
end
