class TasksController < ApplicationController

    def create
        task = Task.new(task_params)
        if task.save
            render json: task
        else
            render json: {error: "The task couldn't be added. Try again!"}
        end
    end

    def index
        render json: Task.all
    end

    private

    def task_params
        params.require(:task).permit(:description)
    end

end
