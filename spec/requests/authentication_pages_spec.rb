require 'spec_helper'

describe "Authenication pages" do
  subject { page }

  before do
    visit root_path
  end

  describe "activity log creation" do
    before { click_link 'Sign up' }

    describe "with invalid data" do
      before do
        fill_in "Email", with: "user@alameda.org"
				fill_in "Password", with: "password"
				fill_in "Password confirmation", with: "password"
				click_button "Sign up"
      end

      it { should have_content("You have signed up successfully.") }
    end
  end
end