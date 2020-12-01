class HomeController < ApplicationController
  def index
    @games = Game.all
  end

  def add
    if session[:cart]
      cart = session[:cart]

      found = false
      item_id = nil
      item_qty = nil
      item_index = nil

      cart.each_with_index do |item, index|
        next unless item["game"]["id"].to_i == params[:id].to_i

        found = true
        item_id = item["game"]
        item_qty = item["qty"] + 1
        item_index = index
      end

      if found
        newValue = { "game" => item_id, "qty" => item_qty }
        cart.delete_at(item_index)
        cart.push(newValue)
      else
        newValue = { "game" => Game.find(params[:id]), "qty" => 1 }
        cart.push(newValue)
      end
      session[:cart] = cart
    else
      session[:cart] = []
      cart = session[:cart]
      cart.push({ "game" => Game.find(params[:id]), "qty" => 1 })
      session[:cart] = cart
    end
    puts session[:cart]
  end

  def show
    @game = Game.find(params[:id])
    @cat = Category.find(@game.category_id)
  end

  def categories
    @cat = Category.all
  end

  def category
    @games = Game.where("category_id = ?", params[:id])
    @cat = Category.find(params[:id])
  end

  def search
    if params[:selector] == "1"
      @results = Game.where("name LIKE ?", "%#{params[:keywords]}%")
    elsif params[:selector] == "2"
      cat = Category.where("name LIKE ?", "%#{params[:keywords]}%").first

      @results = Game.where("category_id = ?", cat.id)
    else
      @results = []
    end
  end

  def searchResults; end
end
