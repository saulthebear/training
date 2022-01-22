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
    render json: params
  end
  
  def edit
    @cat = Cat.find_by(id: params[:id])
    @COLORS = Cat.COLORS
  end
  
  def create
    cat = Cat.new(cat_params)
    if cat.save
      redirect_to cat_url(cat)
    else
      render json: cat.errors.full_messages
    end
  end
  
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :description, :color, :sex)
  end
end
