require 'spec_helper'

describe "User pages" do
	subject { page }

	let!(:admin) { create(:admin) }
	let!(:user)  { create(:user) }

	before do
	  sign_in_as!(admin)
	  visit root_path
	  click_link "Admin"
	  click_link "Users"
	end

	describe "creating a new user" do
		before { click_link "New User" }
		describe "with invalid input" do
			before do
			  fill_in "Email", with: ""
			  fill_in "Password", with: "password"
			  click_button "Create User"
			end

			it { should have_content("Please review the problems below:") }
			it { should have_content("can't be blank") }
		end

		describe "with valid input" do
			before do
				page.select(user.county.name, from: "County")
				page.select(user.job_classification.name, from: "Job classification")
			  fill_in "Email", with: "new@county.org"
			  fill_in "Password", with: "password"
			end

			describe "with 'Admin' unchecked" do
				before { click_button "Create User" }
				it { should have_content("User has been created.") }
				it { should have_content("new@county.org") }
			end

			describe "with 'Admin' checked" do
				before do
				  check "Admin"
				  click_button "Create User" 
				end
				it { should have_content("User has been created.") }
				it { should have_content("new@county.org") }
			end
		end
	end

	describe "modifying existing user" do
		# click 'View' on row with user's email
		before do
		 find(:xpath, "//tr[contains(.,'#{user.email}')]/td/a", text: 'View').click
		end

		describe "editing a user" do
			before { click_link "Edit User" }

			describe "with valid input" do
				before do
				  fill_in "Email", with: "new_name@example.com"
				  click_button "Update User"
				end
				
				it { should have_content "User has been updated." }
				it { should have_content "new_name@example.com" }
				it { should_not have_content user.email }
			end
		end

		describe "deleting a user" do
			before { click_link "Delete User" }			
			it { should have_content("User has been deleted.") }
		end
	end

	describe "modifying current user" do
		before { find(:xpath, "//tr[contains(.,'#{admin.email}')]/td/a", text: 'View').click}
			
		it { should_not have_link "Delete User" }
	end
end