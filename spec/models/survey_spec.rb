require 'spec_helper'

describe Survey do
	start_date = Date.parse '2013-01-01'
	end_date   = Date.parse '2013-01-31'
	let!(:survey) { create(:survey, 
													start_date: start_date, end_date: end_date,
													sample_size: 100) }

	describe "user_moments" do
		it "has 100 user moments" do
			survey.user_moments.count.should eq 100
		end
	end  
end
