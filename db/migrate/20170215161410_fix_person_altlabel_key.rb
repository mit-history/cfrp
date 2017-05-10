class FixPersonAltlabelKey < ActiveRecord::Migration
  def change
    rename_column :person_altlabels, :person_id, :ext_id
  end
end
