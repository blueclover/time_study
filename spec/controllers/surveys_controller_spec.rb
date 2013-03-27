require 'spec_helper'

describe SurveysController do
	let(:admin)   { create(:admin) }
	let(:user)    { create(:user) }

	# create a mock model of a survey
	# (will raise an error if any methods are called on it)
	# this will ensure that nothing is making it past authorization
	let(:survey) { mock_model(Survey, id: 1)}

	context "standard users" do
		before { sign_in(:user, user) }

		actions = { new:     :get,
			          create:  :post,
		          	edit:    :get,
			          update:  :put,
			          destroy: :delete }

		actions.each do |action, method|
			it "cannot access the #{action} action" do
				send(method, action, id: survey.id)
				response.should redirect_to(new_user_session_path)		
				# message = "Your county does not have any active surveys."
				# flash[:alert].should == message
			end
		end
	end

  describe "request for missing survey" do

  	context "anonymous users" do
	    before { get :show, id: "not-here" }

	    specify { response.should redirect_to(new_user_session_path) }
	    message = "You need to sign in or sign up before continuing."
	    specify { flash[:alert].should == message }
	  end

  	context "admins" do
	    before do
	    	sign_in(:user, admin)
	     	get :show, id: "not-here"
	    end

	    specify { response.should redirect_to(surveys_path) }
	    message = "The survey you were looking for could not be found."
	    specify { flash[:alert].should == message }
	  end

  end
end
