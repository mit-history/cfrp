class AddReprisePerfnumToRegisterPlays < ActiveRecord::Migration
  def change
    add_column :register_plays, :reprise_perfnum, :integer
  end
end
