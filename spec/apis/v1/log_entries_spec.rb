require "spec_helper"

describe "/api/v1/log_entries", type: :api do
	let!(:user)   { create(:user) }
	let!(:token)  { user.authentication_token }
	let!(:user_log) { create(:activity_log, user_id: user.id) }
	let!(:user_entry) { create(:log_entry, activity_log_id: user_log.id) }
	let!(:other_entry) { create(:log_entry) }

	context "log entries viewable by this user" do
		let(:url) { "/api/v1/log_entries" }
		it "json" do
			get "#{url}.json", :token => token
			log_entries_json = 
					ActivityLog.accessible_to(user).first.log_entries.to_json
			last_response.body.should eql(log_entries_json)
			last_response.status.should eql(200)
			log_entries = JSON.parse(last_response.body)
			log_entries.any? do |json|
				json["date"] == user_entry.date.to_s
			end.should be_true
		end
	end

	
end