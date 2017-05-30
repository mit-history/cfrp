class CreateLagrangeDocs < ActiveRecord::Migration
  def up
    create_table :lagrange_docs do |t|
      t.string :ext_id, limit: 32, null: false
      t.string :etype, limit: 64
      t.string :title, limit: 256
      t.string :title2, limit: 256
      t.string :subtitle, limit: 256
      t.string :imgref, limit: 128
      t.string :imgurl, limit: 128
      t.string :url, limit: 128
    
      t.timestamps
    end

    add_index "lagrange_docs", ["etype"], name: "lagrange_authors_etype_idx", using: :btree
  end

  def down
    drop_table :lagrange_docs
  end
end
