require 'spec_helper'

describe SurveysController do
  it "displays an error for a missing survey" do
    get :show, id: "not-here"
    response.should redirect_to(surveys_path)
    message = "The survey you were looking for could not be found."
    flash[:alert].should == message
  end
end
