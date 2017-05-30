class AddLagrangeIdToRcfLagrangeAuthors < ActiveRecord::Migration
  def change
    add_column :rcf_lagrange_authors, :lagrange_id, :integer
  end
end
