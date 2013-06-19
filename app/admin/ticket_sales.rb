ActiveAdmin.register TicketSale do
  index do
    selectable_column
    column :id
    column :total_sold
    column :register_id
    column :seating_category_id
    column :price_per_ticket_l
    column :price_per_ticket_s
    column :recorded_total_l
    column :recorded_total_s
    default_actions
  end
end
