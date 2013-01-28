require 'spec_helper'

describe "Survey pages" do
  subject { page }

  describe "survey creation" do
    before do
      visit root_path
      click_link 'New Survey'
      fill_in 'Name', with: 'Test Survey'
      fill_in 'Description', with: 'Alameda County'
      click_button 'Create Survey'
    end

    it { should have_content('Survey has been created.') }

  end
end