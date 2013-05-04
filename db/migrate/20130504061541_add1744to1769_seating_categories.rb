# -*- coding: utf-8 -*-
class Add1744to1769SeatingCategories < ActiveRecord::Migration
  NEW_REGISTER_PERIODS = {
    "1744-45 to 1754-55" => ['Loge basse',
                             'Loge haute',
                             'Billet à',
                             'Billet à',
                             'Billet à',
                             'Billet à'],

    "1755-56 to 1757-58" => ['Loge à',
                             'Loge à',
                             'Billet à',
                             'Billet à',
                             'Billet à',
                             'Billet à'],

    "1758-59" => ['Premières loges à',
                  'Demye loge à',
                  'Secondes loges à',
                  'Billet à',
                  'Billet à',
                  'Billet à',
                  'Billet à'],

    "1759-60 to 1762-63" => ['Premières loges à',
                             'Balcons à',
                             'Secondes loges à',
                             'Billet à',
                             'Billet à',
                             'Billet à',
                             'Billet à'],

    "1763-64 to 1764-65" => ['Premières loges à',
                             'Balcons à',
                             'Secondes loges à',
                             'Petites loges à',
                             'Premières Places',
                             'Secondes Places',
                             'Troisièmes Places',
                             'Places de Parterre'],

    "1765-66" => ['Premières loges à',
                  'Balcons à',
                  'Secondes loges à',
                  'Troisièmes loges à',
                  'Petites loges à',
                  'Petites loges à',
                  'Premières Places',
                  'Secondes Places',
                  'Troisièmes Places',
                  'Places de Parterre'],

    "1766-67 to 1768-69" => ['Premières loges à',
                             'Balcons à',
                             'Secondes loges à',
                             'Troisièmes loges à',
                             'Petites loges à',
                             'Petites loges à',
                             'Petites loges à',
                             'Premières Places',
                             'Secondes Places',
                             'Troisièmes Places',
                             'Places de Parterre']
  } # new_register_periods

  def up
    NEW_REGISTER_PERIODS.keys.each do |rp_string|
      rp = RegisterPeriod.new(:period => rp_string)
      rp.save

      last_idx = 0

      puts rp.inspect

      NEW_REGISTER_PERIODS[rp_string].each_with_index do |rp_sc, idx|
        sc = SeatingCategory.create!(:name => rp_sc, :description => rp_sc)
        RegisterPeriodSeatingCategory.create(:register_period_id => rp.id,
                                             :seating_category_id => sc.id,
                                             :ordering => idx + 1)
        last_idx = idx
      end

      # Must add Irregular Receipts for each one.
      irsc = SeatingCategory.find_by_name('Irregular Receipts')
      RegisterPeriodSeatingCategory.create(:register_period_id => rp.id,
                                           :seating_category_id => irsc.id,
                                           :ordering => last_idx + 2)
    end
  end

  def down
    NEW_REGISTER_PERIODS.keys.each do |rp_string|
      rp = RegisterPeriod.find_by_period(rp_string)
      rpscs = RegisterPeriodSeatingCategory.find_all_by_register_period_id(rp.id)
      seating_categories = []
      rpscs.each do |rpsc|
        rpsc.delete
        seating_categories << rpsc.seating_category
      end

      seating_categories.each do |sc|
        sc.delete unless sc.name == "Irregular Receipts"
      end

      rp.delete
    end
  end
end
