class FixPersonSameAsKey < ActiveRecord::Migration
  def change
    rename_column :person_same_as, :person_id, :ext_id
  end
end
