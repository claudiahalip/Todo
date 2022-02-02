require 'rails_helper'

RSpec.describe Task, type: :model do

    it "checks if a task can be created" do
        user = User.create(first_name: "FirstName", 
            last_name: "LastName", 
            email:"Email",
            username: "Username",
            password: "Password",
            password_confirmation: "Password")
        task = Task.create(description: "walk the dog", user_id: user.id)

        expect(task).to be_valid
    end

    it "will not be created if not valid" do
        task = Task.create()

        expect(task).to_not be_valid
    end

    it "will have a description attribute" do
        task = Task.create(description: "walk the dog")

        expect(task.description).to eq("walk the dog")
    end

    it "will have a is_completed attribute with a false value" do
        task = Task.create(description: "walk the dog")
        
        expect(task.is_completed).to be false
    end

end