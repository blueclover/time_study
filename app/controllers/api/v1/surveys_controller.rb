class Api::V1::SurveysController < Api::V1::BaseController
	def index
		respond_with(Survey.all)
	end
end