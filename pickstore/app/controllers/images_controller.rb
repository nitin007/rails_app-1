class ImagesController < ApplicationController
  # Fixed: NG
 	before_filter :only_when_user_is_logged_in, :fetch_image
  def show  
    # Refactored: NG
      
    respond_to do |format|
	    format.html
	  end
  end

  def destroy
    # Refactored: NG

	  @image.destroy		  
		redirect_to albums_path, :notice => "Image was not destroyed!" if !@image.destroyed?

    respond_to do |format|
      format.html { redirect_to albums_path }
    end
  end
end
