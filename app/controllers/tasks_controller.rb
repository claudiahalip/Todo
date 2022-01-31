class TasksController < ApplicationController

    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        task = Task.new(task_params)
        if task.save
            render_response(task)
        else
            render_response("The task couldn't be added. Try again!")
        end
    end

    def index
        render_response(Task.all)
    end

    def update
        task = Task.find(params[:id])
        task.update(is_completed: params[:is_completed])
        render json: "The task was successfully updated."
    end

    def destroy
        task = Task.find(params[:id])
        task.destroy
        render_response("The task was successfully deleted.")
    end

    private

    def task_params
        params.require(:task).permit(:description)
    end

    def record_not_found(exception)
        render json: {error: exception.message}.to_json, status: 404
        return
    end
end


