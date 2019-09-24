class UploadController < ApplicationController
  def create
    owner = Owner
      .where(name: owner_params[:name])
      .first_or_initialize(owner_params)

    attach_new_images(owner) unless owner.new_record?

    if owner.save
      render json: owner, serializer: OwnerSerializer
    else
      render json: { errors: owner.errors.full_messages }, status: :bad_request
    end
  end

  private

  def owner_params
    params.require(:owner).permit(:name, images_attributes: [:description, :file])
  end

  def attach_new_images(owner)
    return if owner_params[:images_attributes].blank?

    owner_params[:images_attributes].each do |image_param|
      owner.images.build(image_param)
    end
  end
end
