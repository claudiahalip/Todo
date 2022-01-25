class TasksController < ApplicationController

    def create
        task = Task.new(task_params)
        if task.save
            render json: "The task was created"
        else
            render json: {error: "The task couldn't be added. Try again!"}
        end
    end

    private

    def task_params
        params.require(:task).request(:description)
    end

end
