class TasksController < ApplicationController

    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

    def create
        if current_user
            task = current_user.tasks.new(description: task_params[:description])
            if task.save
                render_response("The task was successfully created.")
            else
                render_response("The task couldn't be added. Try again!")
            end
        else
            render_response("You are not authorized to add this task.")
        end
    end

    def index
        if current_user
            render_response(current_user.tasks)
        else
            render_response("You are not authorized to see this list.")
        end
    end

    def update
        task = Task.find(params[:id])
        if current_user && task.user_id == current_user.id
            task.update(is_completed: params[:is_completed])
            render json: "The task was successfully updated."
        else
            render_response("You are not authorized to update this task.")
        end
    end

    def destroy
        task = Task.find(params[:id])
        if current_user && task.user_id == current_user.id
            task.destroy
            render_response("The task was successfully deleted.")
        else
            render_response("You are not authorized to delete this task.")
        end
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


