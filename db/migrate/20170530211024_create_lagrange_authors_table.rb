class CreateLagrangeAuthorsTable < ActiveRecord::Migration
  def up
    create_table :lagrange_authors do |t|
      t.string :ext_id, limit: 16, null: false
      t.string :etype, limit: 32
      t.string :birth_death_years, limit: 64
      t.string :mainrole, limit: 64
      t.string :mainform, limit: 64
      t.string :firstname, limit: 64
      t.string :firstname1, limit: 64
      t.string :formcompl, limit: 64
      t.string :lastname, limit: 64
      t.string :firstname2, limit: 64
      t.string :computedform, limit: 128
      t.string :url, limit: 128
    
      t.timestamps
    end

    add_index "lagrange_authors", ["computedform"], name: "lagrange_authors_computedform_idx", using: :btree
    add_index "lagrange_authors", ["firstname1"], name: "lagrange_authors_firstname1_idx", using: :btree
    add_index "lagrange_authors", ["firstname2"], name: "lagrange_authors_firstname2_idx", using: :btree
    add_index "lagrange_authors", ["firstname"], name: "lagrange_authors_firstname_idx", using: :btree
    add_index "lagrange_authors", ["formcompl"], name: "lagrange_authors_formcompl_idx", using: :btree
    add_index "lagrange_authors", ["lastname"], name: "lagrange_authors_lastname_idx", using: :btree
    add_index "lagrange_authors", ["mainform"], name: "lagrange_authors_mainform_idx", using: :btree
    add_index "lagrange_authors", ["mainrole"], name: "lagrange_authors_mainrole_idx", using: :btree
  end

  def down
    drop_table :lagrange_authors
  end
end
