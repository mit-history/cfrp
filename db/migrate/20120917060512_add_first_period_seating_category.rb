# -*- coding: utf-8 -*-
class AddFirstPeriodSeatingCategory < ActiveRecord::Migration
  def up
    rp1 = RegisterPeriod.create(:period => '1769-1770')
    rp2 = RegisterPeriod.find(2)
    rp2.period = '1770 until 1782'
    rp2.save!
    rp3 = RegisterPeriod.create(:period => '1782 until ...')

    [ SeatingCategory.create(:name => 'Premières Loges', :description => 'Premières Loges'),
      SeatingCategory.create(:name => 'Balcons 1', :description => 'Balcons 1'),
      SeatingCategory.create(:name => 'Balcons 2', :description => 'Balcons 2'),
      SeatingCategory.create(:name => 'Secondes Loges', :description => 'Secondes Loges'),
      SeatingCategory.find_by_name('Troisièmes Loges'),
      SeatingCategory.create(:name => 'Petites Loges 1', :description => 'Petites Loges 1'),
      SeatingCategory.create(:name => 'Petites Loges 2', :description => 'Petites Loges 2'),
      SeatingCategory.create(:name => 'Petites Loges 3', :description => 'Petites Loges 3'),
      SeatingCategory.find_by_name('Premières Places'),
      SeatingCategory.find_by_name('Secondes Places'),
      SeatingCategory.find_by_name('Troisièmes Places'),
      SeatingCategory.find_by_name('Places de Parterre') ].each_with_index do |sc, i|

      RegisterPeriodSeatingCategory.create(:register_period_id => rp1.id,
                                           :seating_category_id => sc.id,
                                           :ordering => i+1)
    end
  end

  def down
    rp1 = RegisterPeriod.find_by_period('1769-1770')
    RegisterPeriodSeatingCategory.find_all_by_register_period_id(rp1.id).each do |rpsc|
      rpsc.destroy
    end

    ['Premières Loges', 'Balcons 1', 'Balcons 2', 'Secondes Loges', 'Troisièmes Loges', 'Petites Loges 1', 'Petites Loges 2', 'Petites Loges 3'].each do |sc|
      SeatingCategory.find_by_name(sc).destroy
    end

    RegisterPeriod.all.each do |rp|
      unless rp.id == 2
        rp.destroy
      end
    end
  end
end
