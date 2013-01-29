require 'spec_helper'

describe "Survey pages" do
  subject { page }

  let!(:survey) { create(:survey, name: "Test Survey") }

  before { visit root_path }

  describe "index" do

    it { should have_link("Test Survey") }

  end

  describe "survey creation" do
    before { click_link 'New Survey' }

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

  describe "edit" do
    before do
      click_link "Test Survey"
      click_link "Edit Survey"
    end

    describe "with valid input" do
      before do
        fill_in "Name", with: "Test Survey 2"
        click_button "Update Survey"
      end

      it { should have_content("Survey has been updated.") }
    end

    describe "with invalid input" do
      before do
        fill_in "Name", with: ""
        click_button "Update Survey"
      end

      it { should have_content("Survey has not been updated.") }
    end
  end

end