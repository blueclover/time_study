require 'spec_helper'

describe "Survey pages" do
  subject { page }

  let(:survey_name) { "Test Survey" }
  let!(:survey) { create(:survey, name: survey_name) }

  before { visit root_path }

  describe "index" do

    it { should have_link(survey_name) }

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
      click_link survey_name
      click_link "Edit Survey"
    end

    describe "with valid input" do

      let(:new_name) { "Test Survey 2" }

      before do
        fill_in "Name", with: new_name
        click_button "Update Survey"
      end

      it { should have_content("Survey has been updated.") }
      it { should have_selector('h2', text: new_name) }
    end

    describe "with invalid input" do
      before do
        fill_in "Name", with: ""
        click_button "Update Survey"
      end

      it { should have_content("Survey has not been updated.") }
    end
  end

  describe "delete" do
    before do
      click_link survey_name
      click_link "Delete Survey"
    end

    it { should have_content("Survey has been deleted.")}
    it { should_not have_link(survey_name)}
  end

end