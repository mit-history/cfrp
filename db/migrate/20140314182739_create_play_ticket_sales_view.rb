class CreatePlayTicketSalesView < ActiveRecord::Migration
  def up
view = 'create or replace view play_ticket_sales as select 
register_plays.id as play_performance_id,
6 as seating_capacity,
seating_categories.name,
plays.title,
plays.author,
plays.genre,
registers.date,
ticket_sales.total_sold

from 
  plays, 
  register_plays,
  registers,
  register_periods,
  register_period_seating_categories,
  seating_categories,
  ticket_sales

where 
  plays.id = register_plays.play_id 
  and registers.id = register_plays.register_id
  and registers.register_period_id = register_periods.id
  and register_periods.id = register_period_seating_categories.register_period_id
  and seating_categories.id = register_period_seating_categories.seating_category_id
  and ticket_sales.register_id = registers.id
  and ticket_sales.seating_category_id = seating_categories.id'

    Play.connection.execute(view)
  end

  def down
    Play.connection.execute('drop view play_ticket_sales')
  end
end
