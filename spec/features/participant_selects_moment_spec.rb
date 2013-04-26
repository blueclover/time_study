require 'spec_helper'

describe 'Participant selects moment' do 
  let(:county) { create(:county) }
  let!(:user) { create(:user, county: county) }

  before do
    create(:survey, county_id: county.id,
      start_date: 3.days.ago, end_date: 2.days.ago,
      sample_size: 2)
    sign_in_as user
  end

  it "shows the correct number of moments" do
    page.all('table#moments tr').count.should == 3
    page.should have_link "respond now"
  end
end