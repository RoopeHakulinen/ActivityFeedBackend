class CommentsController < ApplicationController
	before_action :set_activity, only: [:create]
	before_action :set_comment, only: [:show, :update, :destroy]
	before_action -> { check_access @comment.user }, only: [:update, :destroy]
	respond_to :json

	swagger_controller :comments, "Comments Management"

	swagger_api :index do
		summary "Returns users Comments"
		notes "This lists all the active Comments for current user"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def index
		@comments = Comment.all
		respond_with(@comments)
	end

	swagger_api :show do
		summary "Shows the Comment"
		notes "This shows the Comment"
		param :path, :id, :integer, :required, "Comment id"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def show
		respond_with(@comment)
	end

	swagger_api :create do
		summary "Creates an Comment AKA invite"
		notes "This creates the Comment, invites on other words"
		param :path, :activity_id, :integer, :required, "Activity id"
		param :form, :chat_message, :string, :optional, "Chat message"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user = current_user
		@comment.activity = @activity
		@comment.save
		respond_with(@comment)
	end

	swagger_api :update do
		summary "Updates the Comment"
		notes "This updates the Comment"
		param :path, :comment_id, :integer, :required, "Comment id"
		param :form, :status, :integer, :optional, "Status"
		response :unauthorized
		response :not_acceptable, "The request you made is not acceptable"
		response :unprocessable_entity
	end

	def update
		@comment.update(comment_params)
		respond_with(@comment)
	end

	def destroy
		@comment.destroy
		respond_with(@comment)
	end

	private

	def set_activity
		@activity = Activity.find(params[:activity_id])
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:text)
	end
end
