class AddPlayOrderingToPlays < ActiveRecord::Migration
  def self.up
    add_column :register_plays, :ordering, :integer

    #  Set ordering sequentially based on register_play id
    Register.all.each do |register|
      register_plays = register.register_plays
      sorted = register_plays.sort { |a, b| a.id <=> b.id }
      ordering = 0
      sorted.each do |rp|
        ordering += 1
        rp.ordering = ordering
        rp.save
      end
    end
  end

  def self.down
    remove_column :register_plays, :ordering
  end
end
