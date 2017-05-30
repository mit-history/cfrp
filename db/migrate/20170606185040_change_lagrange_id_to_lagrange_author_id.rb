class ChangeLagrangeIdToLagrangeAuthorId < ActiveRecord::Migration
  def change
	rename_column :rcf_lagrange_authors, :lagrange_id, :lagrange_author_id
  end
end
