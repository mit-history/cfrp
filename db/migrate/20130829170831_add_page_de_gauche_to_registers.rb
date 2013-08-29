class AddPageDeGaucheToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :page_de_gauche, :string
  end
end
