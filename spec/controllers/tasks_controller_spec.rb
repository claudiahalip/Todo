require 'rails_helper'

RSpec.describe TasksController, type: :controller do

    describe "POST#create" do
        it"returns http success" do
            post :create, params: { task: {:description => "test1", :is_completed => true}}
            expect(response).to have_http_status(:success)
        end
    end 
end