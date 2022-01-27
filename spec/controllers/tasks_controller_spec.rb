require 'rails_helper'
require 'json'

RSpec.describe TasksController, type: :controller do

    describe "POST#create" do
        it "returns http success" do
            post :create, params: { task: {:description => "test1"}}
            expect(response).to have_http_status(:success)
        end

        it "returns an error if the task is not valid" do
            post :create, params: { task: {:description => nil}}
            expect(JSON.parse(response.body)).to eq("error" => "The task couldn't be added. Try again!")
        end
    end 

    describe "GET#index" do

        it "returns http success" do
            get :index
            expect(response).to have_http_status(:success)
        end

        it "retuns body with 2 tasks" do
            Task.create(description: "walk the dog")
            Task.create(description: "feed the dog")
            get :index
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end 
end