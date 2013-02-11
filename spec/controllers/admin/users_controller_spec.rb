require 'spec_helper'

describe Admin::UsersController do
	let(:user) { create(:user) }
	let(:admin) { create(:admin) }

	context "standard user" do
		before { sign_in(:user, user) }
		it "is not able to access the index action" do
			get 'index'
			response.should redirect_to(root_path)
			flash[:alert].should eql("You must be an admin to do that.")
		end
	end
	
	context "admin user" do
		before { sign_in(:user, admin) }
		it "is not able to delete itself" do
			delete 'destroy', id: admin.id
			response.should redirect_to(admin_users_path)
			flash[:alert].should eql("You cannot delete your own account.")
		end
	end
end
