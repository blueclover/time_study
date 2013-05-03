require 'spec_helper'

describe "Participant submits response" do 
  let(:county) { create(:county) }
  let!(:user) { create(:user, county: county) }
  let!(:response_option_1) { create(:q1option) }
  let!(:response_option_2) { create(:q2option, parent: response_option_1) }
  let!(:response_option_3) { create(:q3option) }

  before do
    create(:survey, county_id: county.id,
      start_date: 3.days.ago, end_date: 2.days.ago,
      sample_size: 1)
    sign_in_as user
    select response_option_1.description, from: 'response[q1selection]'
    select response_option_2.description, from: 'response[q2selection]'
    select response_option_3.description, from: 'response[q3selection]'
    click_button "Submit"
  end
  it "takes the user to active moments" do
    page.should have_content('Active moments')
  end

end