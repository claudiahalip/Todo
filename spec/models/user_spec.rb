require 'rails_helper'

RSpec.describe User, type: :model do

    it "checks if a task can be created" do
        user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

        expect(user).to be_valid
    end

    it "will not be created if not valid" do
        user = User.create()

        expect(user).to_not be_valid
    end

    it "will have a first_name attribute" do
        user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

        expect(user.first_name).to eq("TestFirstName")
    end

    it "will have a last_name attribute" do
        user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

        expect(user.last_name).to eq("TestLastName")
    end

    it "will have an email attribute" do
        user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

        expect(user.email).to eq("TestEmail")
    end

    it "will have a username attribute" do
        user = User.create(first_name: "TestFirstName", 
            last_name: "TestLastName", 
            email:"TestEmail",
            username: "TestUsername",
            password: "TestPassword",
            password_confirmation: "TestPassword")

        expect(user.username).to eq("TestUsername")
    end

end