class ImagesController < ApplicationController
  # FIXME: WA: No before filter to check if user is logged in.
  
  # Fixed: NG
 	before_filter :only_when_user_is_logged_in
  def show

    # FIXME: WA: One can see the image of any user
    # by placing id in params
    
    # Fixed: NG
    begin
		  @user = current_user
		  @album = @user.albums.find(params[:album_id])
		  @image = @album.images.find(params[:id])

		  respond_to do |format|
		    format.html
		  end
    rescue ActiveRecord::RecordNotFound
    	redirect_to albums_path
    end
  end

  def destroy
    # FIXME: WA: One can _destroy_ the image of any user
    # by placing id in params
    
    # Fixed: NG   
    begin
		  @user = current_user
		  @album = @user.albums.find(params[:album_id])
		  @image = @album.images.find(params[:id])
      @image.destroy
     #File.delete("#{RAILS_ROOT}/public/system/:attachment/:id/:style/:filename")

		  respond_to do |format|
		    format.html { redirect_to album_path(@album), notice: 'Image was destroyed sucessfully!' }
		  end
		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path
		end
  end
end
