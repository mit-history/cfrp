class AddSocietairePensionnaireToPeople < ActiveRecord::Migration
  def change
    add_column :people, :societaire_pensionnaire, :string
  end
end
