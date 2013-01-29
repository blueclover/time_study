require 'spec_helper'

describe "Survey pages" do
  subject { page }

  describe "index" do
    let!(:survey) { create(:survey, name: "Test Survey") }

    before do
      visit root_path
    end

    it { should have_link("Test Survey") }

  end

  describe "survey creation" do
    before do
      visit root_path
      click_link 'New Survey'
    end

    describe "with invalid data" do
      before do
        click_button 'Create Survey'
      end

      it { should have_content("Name can't be blank") }
    end

    describe "with valid data" do
      before do
        fill_in 'Name', with: 'Test Survey'
        fill_in 'Description', with: 'Alameda County'
        click_button 'Create Survey'
      end

      it { should have_content('Survey has been created.') }
    end
  end
end