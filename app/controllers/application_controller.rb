class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
	acts_as_token_authentication_handler_for User
	respond_to :json

	after_filter :cors_set_access_control_headers

	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		#headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
		#headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
		headers['Access-Control-Max-Age'] = "1728000"
	end

	protected

	def auth_vip_required
		unless current_user.vip?
			render :json => {error: 'Only allowed for VIP users.'}, :status => 403
		end
	end

	def auth_admin_only
		unless current_user.admin?
			render :json => {error: 'Only allowed for Admin users.'}, :status => 403
		end
	end

	def secure_params
		params.require(:user).permit(:role)
	end
end
