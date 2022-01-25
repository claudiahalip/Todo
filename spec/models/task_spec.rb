require 'rails_helper'

RSpec.describe Task, type: :model do

    before(:all) do
        @task = Task.create(description: "walk the dog")
    end

    it "checks if a task can be created" do
        expect(@task).to be_valid
    end

    it " will not be created if not valid" do
        task = Task.create()
        expect(task).to_not be_valid
    end

end