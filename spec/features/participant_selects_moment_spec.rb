require 'spec_helper'

describe "Participant selects moment" do 
  let(:county) { create(:county) }
  let!(:user) { create(:user, county: county) }

  context "when user has multiple active moments" do
    before do
      create(:survey, county_id: county.id,
        start_date: 3.days.ago, end_date: 2.days.ago,
        sample_size: 2)
    end
    context "and has not yet responded" do
      before do
        sign_in_as user
      end
      it "shows the correct number of moments" do
        page.all('table#moments tr').count.should == 3
        page.should have_link "respond now"
      end

      it "links to new response page" do
        click_link "respond now"
        page.should have_selector('legend', text: 'New response')
      end
    end
    context 'and has already responded' do
      before do
        create(:response, user_moment: user.user_moments.first)
        sign_in_as user
      end
      it "links to edit response page" do
        click_link "edit response"
        page.should have_selector('legend', text: 'Edit response')
      end
    end
  end
  context "when user has one active moment" do
    before do
      create(:survey, county_id: county.id,
        start_date: 3.days.ago, end_date: 2.days.ago,
        sample_size: 1)
      sign_in_as user
    end

    it "redirects to new response" do
      page.should have_selector('legend', text: 'New response')
    end
  end
end