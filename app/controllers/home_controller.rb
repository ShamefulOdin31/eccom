class HomeController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
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
