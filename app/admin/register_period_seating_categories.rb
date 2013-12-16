ActiveAdmin.register RegisterPeriodSeatingCategory do
  menu false
  index do
    selectable_column
    column :id
    column :register_period_id
    column :seating_category_id
    column :ordering
    default_actions
  end

  form do |f|
      f.inputs "Details" do
        f.input :register_period_id, :as => :select, :collection => Hash[RegisterPeriod.all.map{|b| [b.period,b.id]}]
        f.input :seating_category_id, :as => :select, :collection => Hash[SeatingCategory.all.map{|b| [b.name,b.id]}]
        f.input :ordering
      end
      f.actions
    end
end
