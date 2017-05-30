ActiveAdmin.register RegisterPlay do
  menu parent: "Registres", priority: 2
  config.filters = false
  index do
    selectable_column
    column :register_id
    column :play_id
    column :firstrun
    column :newactor
    column :actorrole
    column :firstrun_perfnum
    column :ordering
    column :free_access
    # column :ex_attendance
    # column :ex_representation
    # column :ex_place
    actions
  end

end
