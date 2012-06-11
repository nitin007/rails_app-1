class ImagesController < ApplicationController
  # Fixed: NG
 	before_filter :only_when_user_is_logged_in, :fetch_image
  def show  
    # OPTIMIZE: WA: Following makes three SQL queries.
    # Reduce it to one. Use joins etcetera.
		# Optimized: NG
		
    # OPTIMIZE: WA: Usually we create instance variable to keep
    # information that we use in our views or helpers. In
    # following case, @user is not used anywhere in the
    # views. There is no need to put current_user in @user.
    # Optimized: NG

    # REFACTOR: WA: Fetching of a specific image can be carried
    # out in a before filter and used in both show and destroy
    # actions.
    # Refactored: NG
      
    respond_to do |format|
	    format.html
	  end
  end

  def destroy
    # OPTIMIZE: WA: Following makes three SQL queries.
    # Reduce it to one. Use joins etcetera.
		# Optimized: NG      

    # OPTIMIZE: WA: Usually we create instance variable to keep
    # information that we use in our views or helpers. In
    # following case, @user is not used anywhere in the
    # views. There is no need to put current_user in @user.
		# Optimized: NG      

    # REFACTOR: WA: Fetching of a specific image can be carried
    # out in a before filter and used in both show and destroy
    # actions.
    # Refactored: NG

	  @image.destroy		  
		redirect_to albums_path, :notice => "Image was not destroyed!" if !@image.destroyed?

    respond_to do |format|
      format.html { redirect_to albums_path }
    end
  end
end
