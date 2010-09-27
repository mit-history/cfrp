# == Schema Information
# Schema version: 20100927135806
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
#  editor_flag         :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

class TicketSale < ActiveRecord::Base
end
