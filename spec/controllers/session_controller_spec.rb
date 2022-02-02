require 'rails_helper'
require 'json'

RSpec.describe SessionController, type: :controller do

    valid_user = {
        first_name: "TestFirstName", 
        last_name: "TestLastName", 
        email:"TestEmail",
        username: "TestUsername",
        password: "TestPassword",
        password_confirmation: "TestPassword"
    }

    describe "POST#create" do
        it "returns a success login message if logged in" do
            user = User.create(valid_user)
            post :create, params: {user: { username: "TestUsername", password: "TestPassword"}}

            expect(response.body).to eq("You are logged in.")
        end

        it "returns an error message if couldn't login with different username" do
            user = User.create(valid_user)
            post :create, params: {user: { username: "Username", password: "TestPassword"}}

            expect(response.body).to eq("No such user, verify credentials and try again or signup.")
        end

        it "returns an error message if the password is incorect" do
            user = User.create(valid_user)
            post :create, params: {user: { username: "Username", password: "Password"}}

            expect(response.body).to eq("No such user, verify credentials and try again or signup.")
        end
    end 

    describe "GET#is_logged_in" do
        it "returns a true logged_in status and the user's username if logged in" do
            user = User.create(valid_user)
            post :create, params: {user: { username: "TestUsername", password: "TestPassword"}}
            get :is_logged_in 

            expect(JSON.parse(response.body)).to eq({"logged_in"=>true, "user"=>"TestUsername"})
        end

        it "returns a false logged_in status and an error message if not logged in" do
            get :is_logged_in 

            expect(JSON.parse(response.body)).to eq({"logged_in"=>false, "message" => "no such user"})
        end
    end

    describe "DELETE#destroy" do
        it "returns a success message when logged out" do
            user = User.create(valid_user)
            post :create, params: {user: { username: "TestUsername", password: "TestPassword"}}
            delete :destroy 

            expect(response.body).to eq("You are logged out.")
        end
    end
end



