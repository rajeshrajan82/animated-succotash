class AlbumsController < ApplicationController
  before_action :set_album, only: [:edit, :update, :destroy]

  respond_to :html
  respond_to :json, only: [:index, :show]

  def index
    @albums = Album.includes(:publisher).order("id DESC")
    respond_with(@albums)
  end

  def show
    @album = Album.includes([:publisher, :songs]).find(params[:id])
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.save
    respond_with(@album)
  end

  def update
    @album.update(album_params)
    respond_with(@album)
  end

  def destroy
    @album.destroy
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :cover_art, :publisher_id, :released_on)
    end
end
