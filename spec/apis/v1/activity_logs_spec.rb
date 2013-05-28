require "spec_helper"

describe "/api/v1/activity_logs", type: :api do
	let!(:user)   { create(:user) }
	let!(:token)  { user.authentication_token }
	let!(:user_log) { create(:activity_log, user_id: user.id) }
	let!(:other_log) { create(:activity_log) }

	context "activty logs viewable by this user" do
		let(:url) { "/api/v1/activity_logs" }
		it "json" do
			get "#{url}.json", :token => token
			activity_logs_json = ActivityLog.accessible_to(user).to_json
			last_response.body.should eql(activity_logs_json)
			last_response.status.should eql(200)
			activity_logs = JSON.parse(last_response.body)
			activity_logs.any? do |p|
				p["survey_id"] == user_log.survey_id && p["user_id"] == user.id
			end.should be_true
		end
	end
end