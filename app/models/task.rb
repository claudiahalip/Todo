class Task < ApplicationRecord

    belongs_to :user
    validates :description, presence: true

    scheduler = Rufus::Scheduler.new

    scheduler.every '300s' do
        Task.all.each { |task_obj| task_obj.update(is_completed: false) if task_obj.is_completed == true} 
    end

end
