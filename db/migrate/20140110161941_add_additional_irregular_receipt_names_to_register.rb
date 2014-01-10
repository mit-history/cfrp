class AddAdditionalIrregularReceiptNamesToRegister < ActiveRecord::Migration
  def change
  	[2, 3, 4, 5, 6, 7, 8, 9, 10].each do |i|
  		add_column(:registers, "irregular_receipts_name_#{i}".to_sym, :string)
  	end
  end
end
