require 'rails_helper'

RSpec.describe Task, type: :model do

    it "checks if a task can be created" do
        task = Task.create(description: "walk the dog")
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