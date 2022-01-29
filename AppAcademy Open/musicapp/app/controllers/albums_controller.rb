class AlbumsController < ApplicationController
  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      redirect_to '/'
    end
  end
end