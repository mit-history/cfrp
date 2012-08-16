class FixUserForDevise < ActiveRecord::Migration
  def up
    # add reset_password_sent_at ( timestamp without time zone )
    add_column :users, :reset_password_sent_at, :timestamp
    change_column :users, :encrypted_password, :string, :limit => 255  # character varying(255)
    # empty encrypted_password NOT YET
    # not yet drop password_salt
  end

  def down
    drop_column :users, :reset_password_sent_at
    change_column :users, :encrypted_password, :string, :limit => 128
  end
end
