class RemoveFlagFieldsFromRegister < ActiveRecord::Migration
  def up
    # registers table flags
    remove_column :registers, :date_flag
    remove_column :registers, :season_flag
    remove_column :registers, :regnum_flag
    remove_column :registers, :totalreceipts_flag
    remove_column :registers, :payment_notes_flag
    remove_column :registers, :page_text_flag
    remove_column :registers, :signatory_flag
    remove_column :registers, :rep_flag
    remove_column :registers, :misc_notes_flag
    remove_column :registers, :ouverture_flag
    remove_column :registers, :cloture_flag

    # register plays table flags
    remove_column :register_plays, :editor_flag

    # ticket_sales table flags
    remove_column :ticket_sales, :editor_flag
  end

  def down
    # registers table flags
    add_column :registers, :date_flag, :boolean
    add_column :registers, :season_flag, :boolean
    add_column :registers, :regnum_flag, :boolean
    add_column :registers, :totalreceipts_flag, :boolean
    add_column :registers, :payment_notes_flag, :boolean
    add_column :registers, :page_text_flag, :boolean
    add_column :registers, :signatory_flag, :boolean
    add_column :registers, :rep_flag, :boolean
    add_column :registers, :misc_notes_flag, :boolean
    add_column :registers, :ouverture_flag, :boolean
    add_column :registers, :cloture_flag, :boolean

    # register plays table flags
    add_column :register_plays, :editor_flag, :boolean

    # ticket_sales table flags
    add_column :ticket_sales, :editor_flag, :boolean
  end
end
