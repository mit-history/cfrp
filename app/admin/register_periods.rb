ActiveAdmin.register RegisterPeriod do
  menu parent: "Registres", priority: 3
  # config.filters = false
  index do
    selectable_column
    column :id
    column :period
    actions
  end
end
