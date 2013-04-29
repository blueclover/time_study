require 'spec_helper'

describe "Participant submits response" do 
  let(:county) { create(:county) }
  let!(:user) { create(:user, county: county) }
  let(:response_option_1) do
    create(:q1option, description: 'Playing in the field')
  end
  let!(:response_option_2) do
    create(:q2option, description: 'Flying a kite', 
      parent: response_option_1)
  end
  let!(:response_option_3) { create(:q3option, description: 'Bob') }

  before do
    create(:survey, county_id: county.id,
      start_date: 3.days.ago, end_date: 2.days.ago,
      sample_size: 1)
    sign_in_as user
    select "Playing in the field", from: 'response[q1selection]'
    select "Flying a kite", from: 'response[q2selection]'
    select "Bob", from: 'response[q3selection]'
    click_button "Submit"
  end
  it "takes the user to active moments" do
    page.should have_content('Active moments')
  end
end