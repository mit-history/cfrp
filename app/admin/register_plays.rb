ActiveAdmin.register RegisterPlay do
  # menu false
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
    default_actions
  end
  
end
