class AddRcfExtIdToRcfLagrangeAuthors < ActiveRecord::Migration
  def change
    add_column :rcf_lagrange_authors, :rcf_ext_id, :integer
  end
end
