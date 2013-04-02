class Population
	attr_reader :participants, :start_date, :end_date, :holidays, 
							:start_of_day, :end_of_day, :work_days

	def initialize(participants, start_date, end_date, holidays=[],
								 start_of_day=9, end_of_day=15)
		@participants = participants
		@start_date = start_date
		@end_date = end_date
		@holidays = holidays
		@start_of_day = start_of_day
		@end_of_day = end_of_day
	end


	def work_days
		@work_days ||= list_work_days
	end
	
	def start_time
		start_date.to_time
	end

	def end_time
		end_date.to_time + 1.day
	end


	def work_day?(date)
		!(date.saturday? || date.sunday? || holidays.include?(date))
	end

	def during_work_hours?(time)
		date = time.to_date
		return false unless work_day?(date)
		time >= date + start_of_day.hours && time < date + end_of_day.hours
	end

	def list_work_days
		dates = []
		date = start_date
		while date <= end_date
			dates << date if work_day?(date)
			date += 1.day
		end
		dates
	end

	def random_date
		work_days[rand(work_days.length)]
	end

	def random_moment
		time = Time.new
		begin
			time = Time.at(rand(end_time.to_i - start_time.to_i) + start_time.to_i)
		end until during_work_hours?(time)
		time
	end

	def random_user
		participants[rand(participants.length)]
	end
end