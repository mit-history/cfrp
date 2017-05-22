class AddActorAuthorToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_actor, :boolean
    add_column :people, :is_author, :boolean
  end
end
