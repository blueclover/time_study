require 'spec_helper'

describe Survey do
	start_date = Date.parse '2013-01-01'
	end_date   = Date.parse '2013-01-31'
	let(:county) { create(:county) }
	let!(:user) { create(:user, county: county) }
	let!(:survey) { create(:survey, county_id: county.id,
													start_date: start_date, end_date: end_date,
													sample_size: 100) }

	
	it "has 1 participant" do
		survey.participants.count.should eq 1
	end
	
	describe "user_moments" do
		it "has 100 user moments" do
			survey.user_moments.count.should eq 100
		end
	end  
end
