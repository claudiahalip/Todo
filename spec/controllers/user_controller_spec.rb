require 'rails_helper'
require 'json'

RSpec.describe UsersController, type: :controller do

    describe "POST#create" do
        it "returns http success" do
            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword"}}

            expect(response).to have_http_status(:success)
        end

        it "returns a successfull message if the user is valid" do
            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword"}}

            expect(response.body).to eq("A new account was successfully created!")
        end

        it "returns an error message if the email is missing" do
            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email: nil,
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword"}}
            expect(JSON.parse(response.body)[0]).to eq("Email can't be blank")
        end

        it "returns an error message if the passowrd is missing" do
            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email: "TestEmail",
            username: "TestUsername",
            password: nil,
            password_confirmation:nil}}
            expect(JSON.parse(response.body)[0]).to eq("Password can't be blank")
        end

        it "returns an error message if the email is not unique" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email: "TestEmail",
            username: "Username",
            password: "TestPassword",
            password_confirmation: "TestPassword"}}
            expect(JSON.parse(response.body)[0]).to eq("Email has already been taken")
        end

        it "returns an error message if the username is not unique" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

            post :create, params: { user: {first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email: "Email",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword"}}
            expect(JSON.parse(response.body)[0]).to eq("Username has already been taken")
        end
    end 

    describe "GET#index" do

        it "returns http success" do
            get :index

            expect(response).to have_http_status(:success)
        end

        it "retuns body with 1 user" do
            user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")
            get :index

            expect(JSON.parse(response.body).size).to eq(1)
        end
    end
end