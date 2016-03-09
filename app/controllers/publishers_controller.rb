class PublishersController < ApplicationController
  before_action :set_publisher, only: [:edit, :update, :destroy]

  respond_to :html
  respond_to :json, only: [:index, :show]

  def index
    @publishers = Publisher.order("id DESC")
    respond_with(@publishers)
  end

  def show
    @publisher = Publisher.includes(:albums).find(params[:id])
    respond_with(@publisher)
  end

  def new
    @publisher = Publisher.new
    respond_with(@publisher)
  end

  def edit
  end

  def create
    @publisher = Publisher.new(publisher_params)
    @publisher.save
    respond_with(@publisher)
  end

  def update
    @publisher.update(publisher_params)
    respond_with(@publisher)
  end

  def destroy
    @publisher.destroy
    respond_with(@publisher)
  end

  private
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    def publisher_params
      params.require(:publisher).permit(:name, :address, :city, :state, :zip, :phone, :url)
    end
end
