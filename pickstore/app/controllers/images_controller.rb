class ImagesController < ApplicationController
  # Fixed: NG
 	before_filter :only_when_user_is_logged_in
  def show

    # Fixed: NG
    begin
      # OPTIMIZE: WA: Following makes three SQL queries.
      # Reduce it to one. Use joins etcetera.

      # OPTIMIZE: WA: Usually we create instance variable to keep
      # information that we use in our views or helpers. In
      # following case, @user is not used anywhere in the
      # views. There is no need to put current_user in @user.

      # REFACTOR: WA: Fetching of a specific image can be carried
      # out in a before filter and used in both show and destroy
      # actions.
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
    # Fixed: NG   
    begin
      # OPTIMIZE: WA: Following makes three SQL queries.
      # Reduce it to one. Use joins etcetera.

      # OPTIMIZE: WA: Usually we create instance variable to keep
      # information that we use in our views or helpers. In
      # following case, @user is not used anywhere in the
      # views. There is no need to put current_user in @user.

      # REFACTOR: WA: Fetching of a specific image can be carried
      # out in a before filter and used in both show and destroy
      # actions.
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
