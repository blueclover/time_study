require 'spec_helper'

describe Population do

	let(:holidays) do
		['2013-01-01', '2013-01-21', '2013-02-18', '2013-05-27',
		 '2013-07-04', '2013-09-02', '2013-10-14', '2013-11-11',
		 '2013-11-28', '2013-12-25'].map {|date| Date.parse(date) }
	end
	let(:population) { Population.new([1,2,3], Date.parse('2013-01-01'), 
														Date.parse('2013-01-31'), holidays, 9, 15) }

	describe "calendar" do
		it "doesn't include weekends" do
			times = ['2013-01-12 10:00', '2013-01-13 10:00']
			times.each do |time|
				population.during_work_hours?(Time.parse(time)).should be_false
			end			
		end

		it "doesn't include holidays" do
			times = ['2013-01-01 10:00', '2013-01-21 10:00']
			times.each do |time|
				population.during_work_hours?(Date.parse(time)).should be_false
			end			
		end

		it "includes normal weekdays" do
			population.during_work_hours?(Time.parse('2013-01-25 10:00')).should be_true
		end

		it "doesn't include non-work hours" do
			times = ['2013-01-25 8:00', '2013-01-25 18:00']
			times.each do |time|
				population.during_work_hours?(Time.parse(time)).should be_false
			end	
		end

		it "has the correct number work days" do
			population.work_days.length.should eq 21
		end

		it "uses the correct time zone" do
			population.start_time.to_i.should eq 1357027200 # CA 01/01/13 00:00
			population.end_time.to_i.should eq 1359705600   # CA 02/01/13 00:00
		end
	end
end