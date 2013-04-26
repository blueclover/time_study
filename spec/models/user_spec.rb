require 'spec_helper'

describe User do
	let(:county) { create(:county) }
	let!(:user) { create(:user, county: county) }
	
	describe "active moment count" do
		context 'with 3 expired moments' do
			before do
				create(:survey, county_id: county.id,
														start_date: 30.days.ago, end_date: 29.days.ago,
														sample_size: 3)
			end
			it "active count is correct" do
				user.user_moments.active.count.should eq 0
			end
		end
		context 'with 3 active moments' do
			before do
				create(:survey, county_id: county.id,
														start_date: 3.days.ago, end_date: 2.days.ago,
														sample_size: 3)
			end
			it "active count is correct" do
				user.user_moments.active.count.should eq 3
			end
		end
	end
end
