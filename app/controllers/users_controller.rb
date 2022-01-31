class UsersController < ApplicationController

    def index
        render json: User.all
    end

    def create
        user = User.new(user_params)
        if user.save
            render_response("A new account was successfully created!")
        else
            render_response(user.errors.full_messages)
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation)
    end

end

