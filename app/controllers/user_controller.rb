class UserController < ApplicationController

	theme :theme_resolver
	layout "simple"

	def login
	end

	def logout
		reset_session
		flash[:notice] = t(:user_logged_out)
		redirect_to :action => "login"
	end

	def authenticate
		user = User.find_by_email(params["user"]["email"])
		if user.nil?
			redirect_to :action => 'unknown'
		else
			auten = false
			if auten == true

			else
				flash[:error] = t(:login_failure)
				redirect_to :action => 'login'
			end
		end
	end

	def loginfailure
	end

	def setup
		@user = User.new
		@server = Server.new
	end

	def unknown
	end

	def create
		@user = User.new
		@server = Server.new
		@user.email = params["user_email"]
		@user.first_name = params["user_first_name"]
		@user.last_name = params["user_last_name"]
		@server.name = params["server_name"]
		if @user.valid? and @server.valid?
			@user.save
			@server.user_id = @user.id
			@server.save
			flash[:notice] = t(:setup_done)
			redirect_to :action => 'login'
		else
			render "setup"
		end
	end

end
