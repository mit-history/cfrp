class CreateRegisters < ActiveRecord::Migration
  def self.up
    create_table :registers do |t|
      t.datetime :date
      t.string :weekday
      t.string :season
      t.integer :register_num
      t.text :payment_notes
      t.text :payment_notes
      t.boolean :date_flag
      t.boolean :season_flag
      t.boolean :regnum_flag
      t.boolean :totalreceipts_flag
      t.boolean :payment_notes_flag
      t.text :page_text
      t.boolean :page_text_flag
      t.integer :total_receipts_recorded_l
      t.integer :total_receipts_recorded_s
      t.integer :representation
      t.string :signatory
      t.boolean :signatory_flag
      t.boolean :rep_flag
      t.text :misc_notes
      t.boolean :misc_notes_flag
      t.text :for_editor_notes
      t.boolean :ouverture
      t.boolean :ouverture_flag
      t.boolean :cloture
      t.boolean :cloture_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :registers
  end
end
