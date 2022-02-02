class ApplicationController < ActionController::Base

    include JsonPresenterHelper
    skip_before_action :verify_authenticity_token

    def login
        session[:user_id] = @user.id
    end

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logout
        session.clear
    end
end
