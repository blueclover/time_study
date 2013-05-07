module LogEntriesHelper
	def log_entry_url(log, entry)
		if entry.class == Date
			"/activity_logs/#{log}/log_entries/new?date=#{entry.strftime('%Y%m%d')}"
		else
			"/activity_logs/#{log}/log_entries/#{entry}"
		end
	end

	def hour_options
		(0..32).map { |n| n/4.0 }
	end
end
