class UploadController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json 

  def image
    @upload = Upload.create( upload_params )

    if @upload.save
      render text: "{\"filelink\":\"#{@upload.attached.url}\"}"
    else
      render json: @upload.errors
    end
  end


  private
    def upload_params
      params.permit(:attached)
    end

end



