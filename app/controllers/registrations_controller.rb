class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	county = County.find_by_id(params[:user][:county_id])
  	params[:user].delete(:county_id)

  	if county.blank?
  		@user = User.new(params[:user])
			if @user.save
				flash[:notice] = "User has been created."
				redirect_to root_path
			else
				render :new
			end
  	else
			@user = county.users.new(params[:user])
			if @user.save
				sign_in(:user, @user)
				flash[:notice] = "User has been created."
				redirect_to root_path
			else
				render :new
			end
		end

  end

  def update
    super
  end
end 