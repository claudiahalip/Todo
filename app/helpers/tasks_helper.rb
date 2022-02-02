module TasksHelper

    def task_belons_to_user?(id)
        current_user && id == current_user.id
    end
end
