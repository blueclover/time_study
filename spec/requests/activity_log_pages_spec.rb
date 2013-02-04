require 'spec_helper'

describe "Activity Log pages" do
  subject { page }

  survey_name = "Test Survey"
  let!(:survey) { create(:survey, name: survey_name) }

  before do
    visit root_path
    click_link survey_name
  end

  #describe "index" do
  #
  #  it { should have_link(survey_name) }
  #
  #end

  describe "activity log creation" do
    before { click_link 'New Activity Log' }

    describe "with invalid data" do
      before do
        click_button "Create Activity log"
      end

      it { should have_content("Staff can't be blank") }
    end

    describe "with valid data" do
      before do
        fill_in 'Staff',      with: 1
        fill_in 'Start date', with: DateTime.now
        click_button 'Create Activity log'
      end

      it { should have_content('Activity log has been created.') }
    end
  end

  #describe "edit" do
  #  before do
  #    click_link "Edit Activity Log"
  #  end
  #
  #  describe "with valid input" do
  #
  #    let(:new_name) { "Test Survey 2" }
  #
  #    before do
  #      fill_in "Name", with: new_name
  #      click_button "Update Survey"
  #    end
  #
  #    it { should have_content("Survey has been updated.") }
  #    it { should have_selector('h2', text: new_name) }
  #  end
  #
  #  describe "with invalid input" do
  #    before do
  #      fill_in "Name", with: ""
  #      click_button "Update Survey"
  #    end
  #
  #    it { should have_content("Survey has not been updated.") }
  #  end
  #end
  #
  #describe "delete" do
  #  before do
  #    click_link survey_name
  #    click_link "Delete Activity Log"
  #  end
  #
  #  it { should have_content("Survey has been deleted.")}
  #  it { should_not have_link(survey_name)}
  #end

end