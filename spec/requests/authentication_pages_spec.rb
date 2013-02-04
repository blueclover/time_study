require 'spec_helper'

describe "Authenication pages" do
  subject { page }

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

  describe "user sign in" do
    before do
      create(:user, email: "user@alameda.org")
      click_link "Sign in"
      fill_in "Email", with: "user@alameda.org"
      fill_in "Password", with: "password"
      click_button "Sign in"
    end
    it { should have_content("Signed in successfully.") }
  end
end