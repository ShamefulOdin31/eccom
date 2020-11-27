class ShoppingController < ApplicationController
  def index
    @cart = session[:cart]
    @products = []
    if @cart.nil?

    else
      @cart.each do |cart|
        total = cart['game']['price'].to_i * cart['qty'].to_i

        new_product = { "game" => cart['game'], "qty" => cart['qty'], "total" => total }
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
      if item['game']["id"].to_i == params[:id].to_i
        found = true
        item_id = item['game']
        item_qty = params[:keywords]
        item_index = index
      end
    end

    if found
      newValue = { "game" => item_id, "qty" => item_qty }
      cart.delete_at(item_index)
      cart.push(newValue)
    end
    session[:cart] = cart
    redirect_to shopping_index_path
    puts session[:cart]
  end

  def remove
    cart = session[:cart]
    found = false
    item_index = nil

    cart.each_with_index do |item, index|
      if item['game']["id"].to_i == params[:id].to_i
        found = true
        item_index = index
      end
    end

    if found
      cart.delete_at(item_index)
    end

    session[:cart] = cart
    redirect_to shopping_index_path
  end

  def checkout
    @cart = session[:cart]
    @total = 0
    @cart.each_with_index do |item, index|
      @total = @total + item['game']['price'].to_i * item['qty'].to_i
    end
  end

  def show

  end
end
