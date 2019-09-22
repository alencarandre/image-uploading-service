class ImagesController < ApplicationController
  def index
    render json: Image.all, each_serializer: ImageWithOwnerSerializer
  end
end
