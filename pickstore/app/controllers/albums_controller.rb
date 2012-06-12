class AlbumsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
  def index
    #Fixed: NG
    @albums = current_user.albums.to_a

    # Fixed: NG
    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end

  def show
    # Optimized: NG

    # Optimized: NG
		begin
    	@album = current_user.albums.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path and return
		end
		
		respond_to do |format|
			format.html
		end
  end

  def new
    @album = Album.new

    respond_to do |format|
      format.html
      format.json { render json: @album }
    end
  end

  def edit
    # Fixed: NG
  	#@user = User.find(session[:current_user_id])
  	
    # Optimized: NG
    begin
    	@album = current_user.albums.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path
		end
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        # -> Optimized: NG
        format.json { head :ok, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #Fixed: NG
    begin
	    @album = Album.find(params[:id])
 		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path and return
		end

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    #Fixed: NG
    begin
	    @album = Album.find(params[:id])
 		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path and return
		end

    @album.destroy
    #Fixed: NG

    # FIXME: WA: Following will give double render or redirect
    # error.
   	redirect_to albums_path, :notice => "Album was not destroyed!" if !@album.destroyed?

    respond_to do |format|
      format.html { redirect_to albums_url }
    end
  end
end
