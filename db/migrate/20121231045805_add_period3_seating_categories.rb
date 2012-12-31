# -*- coding: utf-8 -*-
class AddPeriod3SeatingCategories < ActiveRecord::Migration

  SEATING_CATEGORIES = ['Premieres loges à 6 places', 
                        'Premieres loges à 5 places',
                        'Secondes Loges à 4 places',
                        'Secondes Loges à 3 places',
                        'Troisième Loges à 6 places',
                        'Troisième Loges à 4 places',
                        'Troisièmes Loges à',
                        'Petites Loges',
                        'Petites loges à',
                        'Galeries à 4 livres',
                        'Premiers Places à 6 livres',
                        'Secondes Places à 3 livres',
                        'Parterre assis à 2 livres 8 s',
                        'Troisième Places à 2 livres',
                        'Paradis à 1 livre 10']

  def up
    register_period_3 = RegisterPeriod.new(:period => '1782 to 1786')
    register_period_3.save

    SEATING_CATEGORIES.each_with_index do |name, i|
      sc = SeatingCategory.create!(:name => name, :description => name)
      RegisterPeriodSeatingCategory.create(:register_period_id => register_period_3.id,
                                           :seating_category_id => sc.id,
                                           :ordering => i + 1)
    end
  end

  def down
    register_period_3 = RegisterPeriod.find_by_period('1782 to 1786')
    SEATING_CATEGORIES.each { |name| SeatingCategory.find_by_name(name).delete }
    RegisterPeriodSeatingCategory.find_by_register_period_id(register_period_3.id).each {|rpsc| rpsc.delete}
    register_period_3.delete
  end
end
