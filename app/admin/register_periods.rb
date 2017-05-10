ActiveAdmin.register RegisterPeriod do
  menu false
  # config.filters = false
  index do
    selectable_column
    column :id
    column :period
    actions
  end
end
