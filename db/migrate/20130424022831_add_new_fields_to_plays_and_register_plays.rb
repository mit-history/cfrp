class AddNewFieldsToPlaysAndRegisterPlays < ActiveRecord::Migration
  def change
    add_column :plays, :acts, :integer
    add_column :plays, :prose_vers, :string
    add_column :plays, :prologue, :boolean
    add_column :plays, :musique_danse_machine, :boolean

    add_column :register_plays, :free_access, :boolean
    add_column :register_plays, :ex_attendance, :string
    add_column :register_plays, :ex_representation, :string
    add_column :register_plays, :ex_place, :string
  end
end
