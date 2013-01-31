# -*- coding: utf-8 -*-
class Add17921793RegisterPeriodSeatingCategory < ActiveRecord::Migration
  SEATING_CATEGORIES = ['Premieres Loges à 6 places, à 6 liv.',
                        'Premieres Loges à 5 places, à 6 liv.',
                        'Premieres Loges à places, à 6 liv.',
                        'Loges au Rez-de-chaussée, à pl. à 6 l.',
                        'Loges au Rez-de-chaussée, à pl. à 6 l.',
                        'Loges au Rez-de-chaussée, à pl. à 6 l.',
                        'Secondes Loges à 4 places, à 3 liv 15 sous',
                        'Secondes Loges à 3 places, à 3 liv 15 sous',
                        'Troisiemes Loges à 8 places, à 2 l. 10 s.',
                        'Troisiemes Loges à 6 places, à 2 l. 10 s.',
                        'Troisiemes Loges à 4 places, à 2 l. 10 s.',
                        'Troisiemes Loges à 3 places, à 2 l. 10 s.',
                        'Troisiemes Loges à places, à 2 l. 10 s.',
                        'Quatriemes Loges à 4 places, à 2 l. 10 s.',
                        'Quatriemes Loges à 3 places, à 2 l. 10 s.',
                        'Places de Premieres à 6 liv.',
                        'Places de Galerie & Secondes à 3 liv.',
                        'Places de Parquet à 1 liv. 16 sous.',
                        'Places de Troisiemes à 2 liv.',
                        'Places de Paradis à 1 liv 10 sous']

  def up
    rp = RegisterPeriod.new(:period => '1792-1793')
    rp.save

    last_i = 0

    SEATING_CATEGORIES.each_with_index do |name, i|
      sc = SeatingCategory.create!(:name => name, :description => name)
      RegisterPeriodSeatingCategory.create(:register_period_id => rp.id,
                                           :seating_category_id => sc.id,
                                           :ordering => i + 1)
      last_i = i
    end

    irsc = SeatingCategory.find_by_name('Irregular Receipts')
    RegisterPeriodSeatingCategory.create(:register_period_id => rp.id,
                                         :seating_category_id => irsc.id,
                                         :ordering => last_i + 2)

  end

  def down
    rp = RegisterPeriod.find_by_period('1792-1793')
    SEATING_CATEGORIES.each { |name| SeatingCategory.find_by_name(name).delete }
    RegisterPeriodSeatingCategory.find_all_by_register_period_id(rp.id).each {|rpsc| rpsc.delete}
    rp.delete
  end
end
