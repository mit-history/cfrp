# -*- coding: utf-8 -*-
class SeatingCategoryDefaults < ActiveRecord::Migration
  def self.up
    # First we create a Register Type for 1700s (Note to DD/self: get specific range of seasons for this type of register from Jeff)
    # We use the more manual process of new/set ID/save because 'ID' is a protected attribute.
    register_period_2    = RegisterPeriod.new(:period => '1770s/1780s')
    register_period_2.id = 2
    register_period_2.save

    seating_categories_data = [
                          { :id => '7', :name => 'Premières Loges 1', :description => 'Premières Loges 1' },
                          { :id => '8', :name => 'Premières Loges 2', :description => 'Premières Loges 2' },
                          { :id => '9', :name => 'Premières Loges 3', :description => 'Premières Loges 3' },
                          { :id => '10', :name => 'Premières Loges 4', :description => 'Premières Loges 4' },
                          { :id => '11', :name => 'Secondes Loges 1', :description => 'Secondes Loges 1' },
                          { :id => '12', :name => 'Secondes Loges 2', :description => 'Secondes Loges 2' },
                          { :id => '13', :name => 'Secondes Loges 3', :description => 'Secondes Loges 3' },
                          { :id => '5', :name => 'Troisièmes Loges', :description => 'Troisièmes Loges' },
                          { :id => '14', :name => 'Petites Loges', :description => 'Petites Loges' },
                          { :id => '15', :name => 'Premières Places', :description => 'Premières Places' },
                          { :id => '16', :name => 'Secondes Places', :description => 'Secondes Places' },
                          { :id => '17', :name => 'Troisièmes Places', :description => 'Troisièmes Places' },
                          { :id => '18', :name => 'Places de Parterre', :description => 'Places de Parterre'}
                         ]

    # Iterate through data, again using manual process 'cause of the ID's protected status.
    seating_categories_data.each() do |seating_category_data|
      seating_category = SeatingCategory.new(:name => seating_category_data[:name], :description => seating_category_data[:description])
      seating_category.id = seating_category_data[:id]
      seating_category.save
    end

    # Now create the specific entries in the Register Type - Seating Categories table.
    register_period_seating_data = [
                                    { :register_type_id => 2, :seating_category_id => 7,  :ordering => 1 },
                                    { :register_type_id => 2, :seating_category_id => 8,  :ordering => 2 },
                                    { :register_type_id => 2, :seating_category_id => 9,  :ordering => 3 },
                                    { :register_type_id => 2, :seating_category_id => 10, :ordering => 4 },
                                    { :register_type_id => 2, :seating_category_id => 11, :ordering => 5 },
                                    { :register_type_id => 2, :seating_category_id => 12, :ordering => 6 },
                                    { :register_type_id => 2, :seating_category_id => 13, :ordering => 7 },
                                    { :register_type_id => 2, :seating_category_id => 5,  :ordering => 8 },
                                    { :register_type_id => 2, :seating_category_id => 14, :ordering => 9 },
                                    { :register_type_id => 2, :seating_category_id => 15, :ordering => 10 },
                                    { :register_type_id => 2, :seating_category_id => 16, :ordering => 11 },
                                    { :register_type_id => 2, :seating_category_id => 17, :ordering => 12 },
                                    { :register_type_id => 2, :seating_category_id => 18, :ordering => 13 }
                                   ]

    register_period_seating_data.each() do |this_rtsc_data|
      this_rtsc = RegisterTypeSeatingCategory.create(:register_type_id => this_rtsc_data[:register_type_id], :seating_category_id => this_rtsc_data[:seating_category_id], :ordering => this_rtsc_data[:ordering])
    end
  end

  def self.down
    RegisterPeriod.find(2).destroy()
    SeatingCategory.find(7, 8, 9, 10, 11, 12, 13, 5, 14, 15, 16, 17, 18).each() { |seating_category| seating_category.destroy() }
    RegisterTypeSeatingCategory.all(:conditions => { :register_type_id => 2 }).each() { |this_rtsc| this_rtsc.destroy() }
  end
end
