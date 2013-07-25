ActiveAdmin.register Play do

  menu :priority => 2
  
  index do
    selectable_column
    column :id
    column :author
    column :title
    column :genre
    column :acts
    column :prose_vers
    column :prologue
    column :musique_danse_machine
    default_actions
  end
end
