# == Schema Information
#
# Table name: ticket_sales
#
#  id                  :integer         not null, primary key
#  total_sold          :integer         default(0)
#  register_id         :integer         default(0)
#  seating_category_id :integer         default(0)
#  price_per_ticket_l  :integer         default(0)
#  price_per_ticket_s  :integer         default(0)
#  recorded_total_l    :integer         default(0)
#  recorded_total_s    :integer         default(0)
#  created_at          :datetime
#  updated_at          :datetime
#

class TicketSale < ActiveRecord::Base
  belongs_to :register
  belongs_to :seating_category

  attr_accessible :total_sold, :price_per_ticket_l, :price_per_ticket_s, :recorded_total_l, :recorded_total_s, :seating_category_id, :register_id

  def sc_ordering
    RegisterPeriodSeatingCategory
      .where(['register_period_id = ? AND seating_category_id = ?',
              register.register_period_id, seating_category_id])
      .first
      .ordering
  end
end
