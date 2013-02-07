require 'spec_helper'

describe Admin::UsersController do
	let(:user) { create(:user) }

	context "standard user" do
		before { sign_in(:user, user) }
		it "is not able to access the index action" do
			get 'index'
			response.should redirect_to(root_path)
			flash[:alert].should eql("You must be an admin to do that.")
		end
	end
end
