require 'spec_helper'

describe "Activity Log pages" do
  subject { page }

  survey_name = "Test Survey"
  let!(:survey) { create(:survey, name: survey_name) }
  let!(:user) { create(:user) }
  let!(:log) { create(:activity_log, survey: survey) }

  before do
    sign_in_as!(user)
    visit root_path
    click_link survey_name
  end

  #describe "index" do
  #
  #  it { should have_link(survey_name) }
  #
  #end

  describe "new" do
    before do 
      click_link 'New Activity Log' 
    end

    describe "with invalid input" do
      before do
        click_button "Create Activity log"
      end

      it { should have_content "Activity log has not been created." }
      it { should have_content("Start datecan't be blank") }
    end

    # describe "with valid input" do
    #   before do
    #     fill_in 'Start date', with: 2.days.ago.strftime("%m/%d/%Y")
    #     click_button 'Create Activity log'
    #   end

    #   it { should have_content('Activity log has been created.') }
    # end
  end

  describe "existing" do
    before do
      click_link log.id.to_s
    end

    describe "view" do
      it { should have_content(log.user.email) }
    end

    # describe "edit" do
    #   before { click_link "Edit Activity Log" }

    #   describe "with invalid input" do
    #     before do
    #       fill_in "Start date", with: "wrong"
    #       click_button "Update Activity log"
    #     end

    #     it { should have_content "Activity log has not been updated" }
    #   end
    #   describe "with valid input" do  
    #     before do
    #       fill_in "Start date", with: 10.days.ago
    #       click_button "Update Activity log"
    #     end

    #     it { should have_content "Activity log has been updated" }
    #   end
    # end

    describe "delete" do
      before do
        click_link "Delete Activity Log"
      end
      
      it { should have_content "Activity Log has been deleted." }
    end
   
  end
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