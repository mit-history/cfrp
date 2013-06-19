ActiveAdmin.register RegisterPeriod do
  index do
    selectable_column
    column :id
    column :period
    default_actions
  end
end
