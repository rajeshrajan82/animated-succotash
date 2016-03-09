class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :json, only: [:index, :show]

  def index
    @artists = Artist.order("id DESC")
    respond_with(@artists)
  end

  def show
    if @artist.url.nil?
      update_url
    end
    respond_with(@artist)
  end

  def new
    @artist = Artist.new
    respond_with(@artist)
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.save
    respond_with(@artist)
  end

  def update
    @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  private
    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_params
      params.require(:artist).permit(:name)
    end
    
    def update_url
      require 'net/http'
      require 'json'
      begin
        url = 'https://randomuser.me/api/'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        responseDate = JSON.parse(response)
        artist_url = responseDate["results"][0]["user"]["picture"]["medium"]
        @artist.update_attribute(:url, artist_url)
      rescue
        print "Error on updating url"
      end  
    end
end
