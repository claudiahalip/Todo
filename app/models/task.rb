class Task < ApplicationRecord

    belongs_to :user
    validates :description, presence: true

    scheduler = Rufus::Scheduler.new

    def self.update_task
        Task.where('is_completed = ?', true).update_all(is_completed: false )
    end

    scheduler.every '300s' do
        update_task 
    end
end
