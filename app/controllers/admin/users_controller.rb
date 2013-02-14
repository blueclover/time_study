class Admin::UsersController < Admin::BaseController
	before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
  	@users = User.all(order: "email")
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
		@user = User.new(params[:user], as: :admin)
		if @user.save
			flash[:notice] = "User has been created."
			redirect_to admin_users_path
		else
			flash.now[:alert] = "User has not been created."
			render :new
		end
  end

  def edit
  end

  def update
  	if params[:user][:password].blank?
			params[:user].delete(:password)
			params[:user].delete(:password_confirmation)
		end
		if @user.update_attributes(params[:user], as: :admin)
			flash[:notice] = "User has been updated."
			redirect_to admin_users_path
		else
			flash[:alert] = "User has not been updated."
			render :edit
		end
  end

  def destroy
  	if @user == current_user
  		flash[:alert] = "You cannot delete your own account."
  	else
    	@user.destroy
	  	flash[:notice] = "User has been deleted."
    end
  	redirect_to admin_users_path
  end

  private
		def find_user
			@user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The record you were looking" +
          " for could not be found."
      redirect_to admin_users_path
		end
end
