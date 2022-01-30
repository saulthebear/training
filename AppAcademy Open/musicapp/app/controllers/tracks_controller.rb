class TracksController < ApplicationController
  def new
    album = Album.includes(:band).find(params[:album_id])
    @track = Track.new(album: album)
    @albums = Album.where(band: album.band)
    render :new
  end

  def create
    @track = Track.new(track_params)
    
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:errors] = @track.errors.full_messages
      album = Album.includes(:band).find(@track.album_id)
      @albums = Album.where(band: album.band)
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def destroy
  end
  
  private

  def track_params
    params.require(:track).permit(:title, :is_bonus, :album_id, :ord)
  end
end
