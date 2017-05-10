class FixPersonDepictionKey < ActiveRecord::Migration
	def change
		rename_column :person_depictions, :person_id, :ext_id
	end
end
