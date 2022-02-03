require 'rails_helper'
require 'json'

RSpec.describe TasksController, type: :controller do

    user_object = {
        first_name: "TestFirstName", 
        last_name: "TestLastName", 
        email:"TestEmail",
        username: "TestUsername",
        password: "TestPassword",
        password_confirmation: "TestPassword"
    }

    describe "POST#create" do

        it "returns a success message" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            post :create, params: { task: {description: "test1"}}

            expect(response.body).to eq("The task was successfully created.")
        end

        it "returns an error if the task is not valid" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            post :create, params: { task: {:description => nil}}

            expect(response.body).to eq("The task couldn't be added. Try again!")
        end

        it "returns an error message if the user is not logged in" do
            user = User.create(user_object)
            post :create, params: { task: {description: "test1"}}

            expect(response.body).to eq("You are not authorized to add this task.")
        end
    end 

    describe "GET#index" do

        it "returns http success" do
            get :index

            expect(response).to have_http_status(:success)
        end

        it "returns body with 1 tasks" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            get :index

            expect(JSON.parse(response.body).size).to eq(1)
        end

        it "returns body with 2 tasks" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            task = user.tasks.create(description: "feed the cat")
            get :index

            expect(JSON.parse(response.body).size).to eq(2)
        end

        it "returns an error message if the user is not logged in" do
            get :index

            expect(response.body).to eq("You are not authorized to see this list.")
        end
    end
    
    describe "DELETE#destroy" do
        
        it "returns http success" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            delete :destroy, params: {id: task.id}

            expect(response).to have_http_status(:success)
        end

        it "returns a message that the task was deleted" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            delete :destroy, params: {id: task.id}

            expect(response.body).to eq("The task was successfully deleted.")
        end

        it "returns a message that the task wasn't found if task doesn't exist" do
            delete :destroy, params: {id: 1}

            expect(JSON.parse(response.body)).to eq("error" => "Couldn't find Task with 'id'=1")
        end

        it "will delete a task" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")

            expect{
                delete :destroy, params: {id: task.id}
            }.to change(Task, :count).by(-1)
        end

        it "returns an error message if the user is not logged in" do
            user = User.create(user_object)
            task = user.tasks.create(description: "walk the dog")
            delete :destroy, params: {id: task.id}

            expect(response.body).to eq("You are not authorized to delete this task.")
        end
    end

    describe "PATCH#update" do

        it "returns http success" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            patch :update, params: {id: task.id}

            expect(response).to have_http_status(:success)
        end

        it "returns a message that the task succesfuly updated" do
            user = User.create(user_object)
            allow_any_instance_of(TasksController).to receive(:current_user).and_return(user)
            task = user.tasks.create(description: "walk the dog")
            patch :update, params: {id: task.id}

            expect(response.body).to eq("The task was successfully updated.")
        end

        it "returns a message that the task wasn't found if task doesn't exist" do
            patch :update, params: {id: 1}

            expect(JSON.parse(response.body)).to eq("error" => "Couldn't find Task with 'id'=1")
        end

        it "returns an error message if the user is not logged in" do
            user = User.create(user_object)
            task = user.tasks.create(description: "walk the dog")
            patch :update, params: {id: task.id}

            expect(response.body).to eq("You are not authorized to update this task.")
        end
    end
end



