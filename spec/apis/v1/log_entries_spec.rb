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
			get "#{url}.json", token: token
			log_entries_json = 
					ActivityLog.where(user_id: user.id).first.log_entries.to_json
			last_response.body.should eql(log_entries_json)
			last_response.status.should eql(200)
			log_entries = JSON.parse(last_response.body)
			log_entries.any? do |json|
				json["date"] == user_entry.date.to_s
			end.should be_true
		end
	end

	context "creating a log entry" do
		let(:url) { "/api/v1/log_entries" }
		it "successful JSON" do
			post "#{url}.json", token: token,
			log_entry: { 
				date: Date.today,
				activities_attributes: {
					"0" => { activity_category_id: 1, hours: 1},
					"1" => { activity_category_id: 2, hours: 0},
					"2" => { activity_category_id: 3, hours: 0},
					"3" => { activity_category_id: 4, hours: 1.25},
					"4" => { activity_category_id: 5, hours: 0}
				}
			}
			entry = LogEntry.find_by_date!(Date.today)
			route = "/api/v1/log_entries/#{entry.id}"
			last_response.status.should eql(201)
			last_response.headers["Location"].should eql(route)
			last_response.body.should eql(entry.to_json)
		end

		it "unsuccessful JSON" do
			post "#{url}.json", :token => token,
			:log_entry => {}
			last_response.status.should eql(422)
			errors = {"errors" => {
				"date" => ["can't be blank"]
				}}.to_json
				last_response.body.should eql(errors)
			end
	end
end