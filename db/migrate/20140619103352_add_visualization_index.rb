class AddVisualizationIndex < ActiveRecord::Migration
  def up
    execute("CREATE INDEX registers_updated_at_ndx ON registers(updated_at)")
    execute("CREATE INDEX registers_visualization_ndx ON registers(date_part('month', registers.date), date_part('day', registers.date))")
  end

  def down
    execute("DROP INDEX registers_visualization_ndx")
    execute("DROP INDEX registers_updated_at_ndx")
  end
end
