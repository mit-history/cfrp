class AddMissingIndexesForPlayTicketSales < ActiveRecord::Migration
  def change
    add_index :registers, :register_period_id
    add_index :register_period_seating_categories, :register_period_id
    add_index :register_period_seating_categories, :seating_category_id
    add_index :ticket_sales, :register_id
    add_index :ticket_sales, :seating_category_id
  end
end
