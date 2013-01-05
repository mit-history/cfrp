class AddIrregularReceiptsTo1782to1786 < ActiveRecord::Migration
  def up
    rp = RegisterPeriod.find_by_period('1782 to 1786')
    sc = SeatingCategory.find_by_name('Irregular Receipts')
    last_rpsc = RegisterPeriodSeatingCategory.where(:register_period_id => rp.id).order(:ordering).last
    RegisterPeriodSeatingCategory.create(:register_period_id => rp.id,
                                         :seating_category_id => sc.id,
                                         :ordering => last_rpsc.ordering + 1)
  end

  def down
    rp = RegisterPeriod.find_by_period('1782 to 1786')
    last_rpsc = RegisterPeriodSeatingCategory.where(:register_period_id => rp.id).order(:ordering).last
    last_rpsc.destroy
  end
end
