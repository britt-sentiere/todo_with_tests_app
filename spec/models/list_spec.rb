require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do 
    it 'should mark all tasks from the list as complete' do 
      list = List.create(name: "Grocery List")
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: false)

      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do 
    it 'should delay all tasks by an hour' do
      moment_in_time = Time.now
      list = List.create(name: "Homework")
      Task.create(list_id: list.id, deadline: moment_in_time)
      Task.create(list_id: list.id, deadline: moment_in_time)

      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(moment_in_time + 1.hour)
      end 
    end
  end

  describe '#total_duration' do
    it 'should display the time necessary to complete the task' do

      list = List.create(name: "Cleaning")
      Task.create(list_id: list.id, duration: 30)
      Task.create(list_id: list.id, duration: 30)
      Task.create(list_id: list.id, duration: 30)

      list.total_duration

        expect(list.total_duration).to eq(90)
    end
  end 

  describe '#incomplete_tasks' do
    it 'should display incomplete_tasks' do
      list = List.create(name: "Shopping")
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: false)

      list.incomplete_tasks

      list.tasks.each do |task| 
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do
    it 'should select the favorite tasks' do
      list = List.create(name: "Yard Work")
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: true)
      Task.create(list_id: list.id, favorite: true)

      list.favorite_tasks

      list.tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end

