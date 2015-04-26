class ActivitiesController < ApplicationController
	before_action :set_activity, only: [:show, :update, :destroy]
	before_action -> { check_access @activity.organizer }, only: [:show, :update, :destroy]
	respond_to :json

	swagger_controller :activities, "Activity Management"

	swagger_api :index do
		summary "Fetches all Activities"
		notes "This lists all the active Activities"
		#param :query, :page, :integer, :optional, "Page number"
		param :path, :activity_type_id, :integer, :optional, "Activity type id"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def index
		if not params.has_key?(:lat) or not params.has_key?(:lng) or not params.has_key?(:range)
			render :json => {errors: "Missing latitude, longitude or range."}, status: :precondition_failed and return
		end

		# First filter by range
		@activities = Activity.within(params[:range], :origin => [params[:lat], params[:lng]])

		@activities = @activities.includes(:suggestions).where('activities.id NOT IN (SELECT activity_id FROM suggestions WHERE user_id = ?)', current_user.id)
		if params.has_key?(:activity_type_id)
			@activities = @activities.where(activities: {activity_type_id: params[:activity_type_id]})
		end
		respond_with(@activities)
	end

	swagger_api :show do
		summary "Shows the Activity"
		notes "This shows the Activity"
		#param :query, :page, :integer, :optional, "Page number"
		param :path, :id, :integer, :optional, "Activity id"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def show
		respond_with(@activity)
	end

	swagger_api :create do
		summary "Create an Activity"
		notes "This creates an Activity"
		param :form, :activity_type_id, :integer, :required, "Activity type id"
		param :form, :from, :datetime, :required, "From"
		param :form, :to, :datetime, :required, "To"
		param :form, :location, :integer, :required, "Location"
		param :form, :party_size, :integer, :required, "Party size"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def create
		message = activity_params[:message]
		@activity = Activity.new(activity_params.slice!(:message))
		@activity.organizer = current_user
		@activity.save
		Comment.create writer: current_user, activity: @activity, text: message
		respond_with(@activity)
	end

	swagger_api :update do
		summary "Updates an Activity"
		notes "This updates an Activity"
		param :form, :activity_type_id, :integer, :optional, "Activity type id"
		param :form, :from, :datetime, :optional, "From"
		param :form, :to, :datetime, :optional, "To"
		param :form, :location, :integer, :optional, "Location"
		param :form, :party_size, :integer, :optional, "Party size"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def update
		@activity.update(activity_params)
		respond_with(@activity)
	end

	swagger_api :destroy do
		summary "Destroys the Activity"
		notes "This destroys the Activity"
		param :path, :activity_id, :integer, :required, "Activity id"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def destroy
		@activity.destroy
		respond_with(@activity)
	end

	private
	def set_activity
		@activity = Activity.find(params[:id])
	end

	def activity_params
		params.require(:activity).permit(:from, :to, :location_name, :lat, :lng, :activity_type_id, :message, :participant_count, :required_level)
	end
end
