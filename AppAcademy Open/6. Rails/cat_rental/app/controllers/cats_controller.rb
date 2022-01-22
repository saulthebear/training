class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
  end

  def update
  end
  
  def create
  end
end
