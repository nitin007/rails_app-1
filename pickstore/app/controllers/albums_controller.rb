class AlbumsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
  def index
    #Fixed: NG
    @albums = current_user.albums.to_a

    # FIXME: WA: @albums is nil			->?
    # Fixed: NG
    respond_to do |format|
      format.html
      format.json { render json: @albums }
    end
  end

  def show
    # OPTIMIZE: WA: Usually we create instance variable to keep
    # information that we use in our views or helpers. In
    # following case, @user is not used anywhere in the
    # views. There is no need to put current_user in @user.
  	#@user = current_user#User.find(session[:current_user_id])
  	
    # Optimized: NG

    # OPTIMIZE: WA: Try to minimize code inside begin rescue
    # block. In our case the ActiveRecord::RecordNotFound
    # exception will be raise only by ActiveRecord#find.
    # We can try and remove respond_to block from begin
    # rescue block.
    
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
    # TODO: WA: Use current_user instead.
    #
    # OPTIMIZE: WA: Usually we create instance variable to keep
    # information that we use in our views or helpers. In
    # following case, @user is not used anywhere in the
    # views. There is no need to put current_user in @user.
    
    # Fixed: NG
  	#@user = User.find(session[:current_user_id])
  	
    # OPTIMIZE: WA: .exists? and then .find will
    # fire off two SQL queries. Use only find or
    # find_by_id and take decision depending upon
    # the result.
    
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
        # OPTIMIZE: WA: Sending full album information back to the client
        # is inefficient. Client, that is consuming the JSON API, already 
        # has all the information that it sent for album creation. Our
        # server can only send a head :ok to indicate that creation of
        # the album was successful and it can use the information that it
        # already has with it to display proper results to the user.
        
        # -> Optimized: NG
        format.json { head :ok, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # FIXME: WA: Following might raise an ActiveRecord::RecordNotFound
    # exception, handle that.
    
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
    # FIXME: WA: Following might raise an ActiveRecord::RecordNotFound
    # exception, handle that.
    
    #Fixed: NG
    begin
	    @album = Album.find(params[:id])
 		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path and return
		end

    # FIXME: WA: What if the album is not destroyed. Handle that situation.
    
    @album.destroy
    #Fixed: NG
   	redirect_to albums_path, :notice => "Album was not destroyed!" if !@album.destroyed?

    respond_to do |format|
      format.html { redirect_to albums_url }
    end
  end
end
