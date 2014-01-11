class AddDeniersToTicketSales < ActiveRecord::Migration
  def change
    add_column :ticket_sales, :price_per_ticket_d, :integer, :default => 0
    add_column :ticket_sales, :recorded_total_d, :integer, :default => 0
  end
end
