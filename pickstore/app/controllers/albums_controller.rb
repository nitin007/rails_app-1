class AlbumsController < ApplicationController
	before_filter :only_when_user_is_logged_in
	
  def index
  	@user = User.find(session[:current_user_id])
    @albums = @user.albums.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def show
  	@user = User.find(session[:current_user_id])
  	
    if @user.albums.exists?(params[:id])
    	@album = @user.albums.find(params[:id])
			respond_to do |format|
			  format.html # show.html.erb
			  format.json { render json: @album }
		  end
		else
			redirect_to albums_path
		end
  end

  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  def edit
  	@user = User.find(session[:current_user_id])
  	
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
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
end
