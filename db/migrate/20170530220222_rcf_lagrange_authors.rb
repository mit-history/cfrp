class RcfLagrangeAuthors < ActiveRecord::Migration
  def up
    create_table :rcf_lagrange_authors do |t|
      t.string :rcf_id
      t.string :lagrange_author_ext_id

      t.timestamps
    end
    add_index "rcf_lagrange_authors", ["rcf_id"], name: "rcf_lagrange_authors_rcf_idx", using: :btree
    add_index "rcf_lagrange_authors", ["lagrange_author_ext_id"], name: "rcf_lagrange_authors_lagrange_idx", using: :btree
  end

  def down
    drop_table :rcf_lagrange_authors 
  end
end
