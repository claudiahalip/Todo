class SessionController < ApplicationController

    def create
        @user = User.find_by(username: session_params[:username])
        if @user && @user.authenticate(session_params[:password])
            login
            render json: "You are logged in."
        else
            render json: "No such user, verify credentials and try again or signup."
        end
    end

    def is_logged_in?
        if logged_in? && current_user
            render json: {logged_in: true, user: current_user}
        else
            render json: {logged_in: false, message: "no such user"}
        end
    end

    def destroy
        logout
        render json: "You are logged out."
    end

    private 

    def session_params
        params.require(:user).permit(:username, :password)
    end
end
