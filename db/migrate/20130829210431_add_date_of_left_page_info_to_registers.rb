class AddDateOfLeftPageInfoToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :date_of_left_page_info, :date
  end
end
