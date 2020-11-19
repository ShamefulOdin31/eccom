class ShoppingController < ApplicationController
  def index
    @cart = session[:cart]
  end

  def show
  end
end
