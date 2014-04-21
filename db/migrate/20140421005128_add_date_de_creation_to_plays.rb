class AddDateDeCreationToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :date_de_creation, :date
  end
end
