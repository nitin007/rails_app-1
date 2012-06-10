class AlbumsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
  def index
#  	@user = current_user #User.find(session[:current_user_id])
		# Fixed: NG
    
    #Fixed: NG
#    @albums = @user.albums

    # FIXME: WA: @albums is nil
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def show
    # OPTIMIZE: WA: Usually we create instance variable to keep
    # information that we use in our views or helpers. In
    # following case, @user is not used anywhere in the
    # views. There is no need to put current_user in @user.
  	@user = current_user#User.find(session[:current_user_id])
  	
    # Optimized: NG

    # OPTIMIZE: WA: Try to minimize code inside begin rescue
    # block. In our case the ActiveRecord::RecordNotFound
    # exception will be raise only by ActiveRecord#find.
    # We can try and remove respond_to block from begin
    # rescue block.
		begin
    	@album = @user.albums.find(params[:id])
			respond_to do |format|
			  format.html # show.html.erb
			  format.json { render json: @album }
		  end
		rescue ActiveRecord::RecordNotFound
			redirect_to albums_path
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
  	@user = User.find(session[:current_user_id])
  	
    # OPTIMIZE: WA: .exists? and then .find will
    # fire off two SQL queries. Use only find or
    # find_by_id and take decision depending upon
    # the result.
    if @user.albums.exists?(params[:id])
    	@album = @user.albums.find(params[:id])
		else
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
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # FIXME: WA: Following might raise an ActiveRecord::RecordNotFound
    # exception, handle that.
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        # TODO: WA: :no_content sends an HTTP 204. In this case 205 will be more suitable.
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # FIXME: WA: Following might raise an ActiveRecord::RecordNotFound
    # exception, handle that.
    @album = Album.find(params[:id])

    # FIXME: WA: What if the album is not destroyed. Handle that situation.
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
