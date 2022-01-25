class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      redirect_to cats_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    
    redirect_to cats_url unless @cat # Redirect if cat not found
    
    render :edit
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    redirect_to cats_url unless @cat # Redirect if cat not found

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :description, :color, :sex)
  end
end
