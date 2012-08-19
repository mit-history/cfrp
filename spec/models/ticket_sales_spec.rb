require 'spec_helper'

describe TicketSale do
  before :each do
    @sc = SeatingCategory.create( :name => "test 1" )
    @period = RegisterPeriod.create( :period => 'test !' )

    # NOT this seating category's RPSC
    @rpsc = RegisterPeriodSeatingCategory.create( :register_period_id => @period.id,
                                                  :seating_category_id => 1234,
                                                  :ordering => 4 )

    @rpsc2 = RegisterPeriodSeatingCategory.create( :register_period_id => @period.id,
                                                  :seating_category_id => @sc.id,
                                                  :ordering => 5 )

    @register = Register.create( :register_num => 1,
                                 :date => '1750-01-01',
                                 :season => '1749-1750',
                                 :register_period_id => @period.id )

    @ts = TicketSale.create( :register_id => @register.id,
                             :seating_category_id => @sc.id,
                             :total_sold => 0,
                             :price_per_ticket_l => 0,
                             :price_per_ticket_s => 0,
                             :recorded_total_l => 0,
                             :recorded_total_s => 0 )
  end

  it "returns the ordering based on the seating category for the register" do
    @ts.sc_ordering.should == 5
  end
end
