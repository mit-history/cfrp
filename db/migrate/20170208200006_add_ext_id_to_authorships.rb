class AddExtIdToAuthorships < ActiveRecord::Migration
  def change
    add_column :authorships, :ext_id, :integer
  end
end
