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

    def update
      @cart = session[:cart]
    end
    

    

  end

  def show
  end
end
