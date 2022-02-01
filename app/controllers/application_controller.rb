class ApplicationController < ActionController::Base

    include JsonPresenterHelper
    skip_before_action :verify_authenticity_token

    def login
        session[:user_id] = @user.id
    end

    def logout
        session.clear
    end
end
