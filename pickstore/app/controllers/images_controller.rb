class ImagesController < ApplicationController
  def show
    @album = Album.find(params[:album_id])
    @image = @album.images.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def destroy
     @album = Album.find(params[:album_id])
     @image = @album.images.find(params[:id])
     @image.destroy
     #File.delete("#{RAILS_ROOT}/public/system/:attachment/:id/:style/:filename")

    respond_to do |format|
      format.html { redirect_to album_path(@album), notice: 'Image was destroyed sucessfully!' }
    end
  end
end
