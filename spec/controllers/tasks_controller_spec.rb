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

            expect(response.body).to eq("The task couldn't be added. Try again!")
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
    
    describe "DELETE#destroy" do

        it "returns http success" do
            task = Task.create(description: "walk the dog")
            delete :destroy, params: {id: task.id}

            expect(response).to have_http_status(:success)
        end

        it "returns a message that the task was deleted" do
            task = Task.create(description: "walk the dog")
            delete :destroy, params: {id: task.id}

            expect(response.body).to eq("The task was successfully deleted.")
        end

        it "returns a message that the task wasn't found if task doesn't exist" do
            delete :destroy, params: {id: 1}

            expect(JSON.parse(response.body)).to eq("error" => "Couldn't find Task with 'id'=1")
        end

        it "will delete a task" do
            task = Task.create(description: "walk the dog")

            expect{
                delete :destroy, params: {id: task.id}
            }.to change(Task, :count).by(-1)
        end
    end

    describe "PATCH#update" do
        it "returns http success" do
            task = Task.create(description: "walk the dog")
            patch :update, params: {id: task.id}

            expect(response).to have_http_status(:success)
        end

        it "returns a message that the task succesfuly updated" do
            task = Task.create(description: "walk the dog")
            patch :update, params: {id: task.id}

            expect(response.body).to eq("The task was successfully updated.")
        end

        it "returns a message that the task wasn't found if task doesn't exist" do
            patch :update, params: {id: 1}

            expect(JSON.parse(response.body)).to eq("error" => "Couldn't find Task with 'id'=1")
        end
    end
end



