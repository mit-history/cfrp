class ChangeRcfIdToPersonId < ActiveRecord::Migration
  def change
	rename_column :rcf_lagrange_authors, :rcf_id, :person_id
  end
end
