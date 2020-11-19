class HomeController < ApplicationController
  def index
    @games = Game.all
  end

  def add
    if session[:cart]
      cart = session[:cart]
      cart.push(params[:id])
      session[:cart] = cart
    else
      session[:cart] = []
      cart = session[:cart]
      cart.push(params[:id])
      session[:cart] = cart
    end

    puts session[:cart]
  end

  def show
    @game = Game.find(params[:id])
  end

  def categories
    @cat = Category.all
  end

  def category
    @games = Game.where('category_id = ?', params[:id])
    @cat = Category.find(params[:id])
  end

  def search
    if params[:selector] == "1"
      @results = Game.where('name LIKE ?', "%#{params[:keywords]}%")
    elsif params[:selector] == "2"
      cat = Category.where('name LIKE ?', "%#{params[:keywords]}%").first
      
      @results = Game.where('category_id = ?', cat.id)
    else
      @results = []
    end
  end

  def searchResults
    
  end
end
