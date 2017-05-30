class AddLagrangeAuthorIdToLagrangeDocAuthors < ActiveRecord::Migration
  def change
    add_column :lagrange_doc_authors, :lagrange_author_id, :integer
  end
end
