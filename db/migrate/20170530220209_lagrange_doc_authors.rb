class LagrangeDocAuthors < ActiveRecord::Migration
  def up
    create_table :lagrange_doc_authors do |t|
      t.string :lagrange_doc_ext_id
      t.string :lagrange_author_ext_id

      t.timestamps
    end
    add_index "lagrange_doc_authors", ["lagrange_author_ext_id"], name: "lagrange_doc_authors_aut_idx", using: :btree
    add_index "lagrange_doc_authors", ["lagrange_doc_ext_id"], name: "lagrange_doc_authors_doc_idx", using: :btree
  end

  def down
    drop_table :lagrange_doc_authors 
  end
end
