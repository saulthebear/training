class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def create
    band = Band.new(band_params)
    if band.save
      redirect_to band_url(band.id)
    else
      flash.now[:errors] = band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if @band
      render :edit
    else
      redirect_to bands_url
    end
  end

  def show
    @band = Band.includes(:albums).find_by(id: params[:id])
    if @band
      render :show
    else
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band.id)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
    
  end

  def destroy
  end
  
  private

  def band_params
    params.require(:band).permit(:name)
  end
end
