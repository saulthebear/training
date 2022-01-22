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
    @COLORS = Cat.COLORS
  end

  def update
  end
  
  def create
    render json: params
  end
end
