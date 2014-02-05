class AddIndexToRegisterPlays < ActiveRecord::Migration
  def change
    add_index :register_plays, :register_id, :name => 'register_id_ix'
    add_index :register_plays, :play_id, :name => 'play_id_ix'
  end
end
