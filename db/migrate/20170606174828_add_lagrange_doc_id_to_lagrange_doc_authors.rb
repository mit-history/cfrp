class AddLagrangeDocIdToLagrangeDocAuthors < ActiveRecord::Migration
  def change
    add_column :lagrange_doc_authors, :lagrange_doc_id, :integer
  end
end
