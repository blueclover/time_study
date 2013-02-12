require 'spec_helper'

describe "Authenication pages" do
  subject { page }

  let(:admin) { create(:admin, email: "admin@alameda.org") }

  before do
    visit root_path
  end

  describe "user creation" do
    before { click_link 'Sign up' }

    describe "with valid data" do
      before do
        fill_in "Email", with: "user@alameda.org"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
      end

      it { should have_content("You have signed up successfully.") }
    end

    describe "with invalid data" do
      before do
        fill_in "Email", with: ""
        click_button "Sign up"
      end

      it { should have_content("Email can't be blank") }
    end
  end

  describe "user signin" do
    before do
      click_link "Sign in"
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Sign in"
    end
    it { should have_content("Signed in successfully.") }
  end

  describe "authorization" do

    describe "for non-signed-in users" do

      describe "in the Surveys controller" do

        describe "creating a survey" do
          before { visit new_survey_path }
          it { should have_content("You need to sign in or sign up") }

          describe "after signing in as admin" do
            before do
              fill_in "Email", with: admin.email
              fill_in "Password", with: admin.password
              click_button "Sign in"
            end

            it "should render the desired protected page" do
              page.should have_selector('legend', text: 'New Survey')
            end
          end
        end
      end
    end
  end
end