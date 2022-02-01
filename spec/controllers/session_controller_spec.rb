require 'rails_helper'
require 'json'

RSpec.describe SessionController, type: :controller do

    describe "POST#create" do
        it "returns a success login message if login" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")
            post :create, params: {user: { username: "TestUsername", password: "TestPassword"}}

            expect(response.body).to eq("You are logged in.")
        end

        it "returns an error message if couldn't login" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")
            post :create, params: {user: { username: "Username", password: "TestPassword"}}

            expect(response.body).to eq("No such user, verify credentaials and try again or signup.")
        end
    end 

    describe "DELETE#destroy" do
        it "returns a success message when logout" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")
            post :create, params: {user: { username: "TestUsername", password: "TestPassword"}}
            delete :destroy 

            expect(response.body).to eq("You are logged out.")
        end
    end
end



