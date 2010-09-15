class CreateTicketSales < ActiveRecord::Migration
  def self.up
    create_table :ticket_sales do |t|
      t.integer :total_sold, :default => 0
      t.integer :register_id, :default => 0
      t.integer :seating_category_id, :default => 0
      t.integer :price_per_ticket_l, :default => 0
      t.integer :price_per_ticket_s, :default => 0
      t.integer :recorded_total_l, :default => 0
      t.integer :recorded_total_s, :default => 0
      t.boolean :editor_flag, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_sales
  end
end
