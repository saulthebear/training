class AlbumsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      redirect_to '/'
    end
  end
  
  def new
    @album = Album.new
    @bands = Band.all
    render :new
  end

  def edit
    @album = Album.includes(:band).find_by(id: params[:id])
    @bands = Band.all
    if @album
      render :edit
    else
      redirect_to '/'
    end
  end
  
  def create
    album = Album.new(album_params)
    if album.save
      redirect_to album_url(album.id)
    else
      flash.now[:erors] = album.errors.full_messages
      @album = album
      @bands = Band.all
      render :new
    end
  end
  
  private

  def album_params
    params.require(:album).permit(:title, :band_id, :year, :is_live)
  end
end
