class RegisterTaskDefaults < ActiveRecord::Migration
  def self.up
    creator = RegisterTask.new(:name => 'creator')
    creator.id = 1
    creator.save

    editor = RegisterTask.new(:name => 'editor')
    editor.id = 2
    editor.save
  end

  def self.down
    RegisterTask.find(1, 2).each() { |register_task| register_task.destroy() }
  end
end
