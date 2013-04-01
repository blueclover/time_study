require 'spec_helper'

describe "Survey pages" do
  subject { page }

  survey_name = "Test Survey"
  let!(:survey) { create(:survey, name: survey_name) }
  let!(:county) { create(:county) }
  let(:user)    { create(:user) }  
  let(:admin)   { create(:admin) }  

  describe "index" do 
    context "anonymous users" do
      before { visit root_path }

      it { should have_link("Sign in") }
      it { should have_link("Sign up") }
      it { should_not have_link(survey_name) }
      it { should_not have_link("New Survey") }

    end
    context "regular users" do

      before do
        sign_in_as!(user)
      end

      it { should have_content "Your county does not have any active surveys." }
      it { should have_link("Sign in") }
      it { should have_link("Sign up") }
      it { should_not have_link("New Survey") }

    end
    context "admin users" do
      before do
        sign_in_as!(admin)
        visit root_path
      end

      it { should have_link(survey_name) }
      it { should have_link("New Survey") }

    end
  end

  describe "restricted actions" do
    context "regular users" do
      describe "on survey show page" do
        before do
          sign_in_as!(user)
          visit survey_path(survey)
        end

        it { should_not have_selector('h2', text: survey_name) }
        it { should_not have_content("Edit Survey") }
        it { should_not have_link("Delete Survey") }
      end
    end
    context "admin users" do
      before do
        sign_in_as!(admin)
        visit root_path
      end

      describe "survey creation" do
        before { click_link 'New Survey' }

        describe "with invalid data" do
          before do
            click_button 'Create Survey'
          end

          it { should have_content("Survey has not been created.") }
          it { should have_content("can't be blank") }
        end

        describe "with valid data" do
          before do
            fill_in 'Name', with: 'Test Survey'
            page.select county.name, from: 'County'
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
  end
end