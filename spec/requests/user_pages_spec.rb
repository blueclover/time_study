require 'spec_helper'

describe "User pages" do
	subject { page }

	let!(:admin) { create(:admin) }
	before do
	  sign_in_as!(admin)
	  visit root_path
	  click_link "Admin"
	  click_link "Users"
	end

	describe "creating new user" do
		before { click_link "New User" }
		describe "with invalid input" do
			before do
			  fill_in "Email", with: ""
			  fill_in "Password", with: "password"
			  click_button "Create User"
			end

			it { should have_content("User has not been created.") }
			it { should have_content("Email can't be blank") }
		end

		describe "with valid input" do
			before do
			  fill_in "Email", with: "new@county.org"
			  fill_in "Password", with: "password"
			  click_button "Create User"
			end

			it { should have_content("User has been created.") }
		end
	end
end