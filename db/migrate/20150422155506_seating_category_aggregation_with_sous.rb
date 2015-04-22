class SeatingCategoryAggregationWithSous < ActiveRecord::Migration
  def up

    # Incorporate both livres and sous into tallies of per-diem receipts

    execute <<-SQL

      DROP FUNCTION IF EXISTS bucket(INT, INT, TEXT, TEXT) CASCADE;
      DROP VIEW IF EXISTS category_sales CASCADE;
      DROP VIEW IF EXISTS amalgamated_sales CASCADE;

      CREATE FUNCTION bucket(val DOUBLE PRECISION, size INT, fmt TEXT, nullval TEXT) RETURNS TEXT AS $$
        SELECT COALESCE(
          to_char(round(val / size) * size, fmt) || '-' || to_char(round(val / size) * size + size - 1, fmt), nullval);
      $$ LANGUAGE SQL IMMUTABLE;

      CREATE VIEW amalgamated_sales AS
          SELECT registers.id AS register_id, sum(recorded_total_l + recorded_total_s / 20.0) AS receipts, 'parterre' AS section
          FROM registers JOIN ticket_sales ON (registers.id = register_id)
          WHERE seating_category_id IN (18,39,60,80,88,94,101,108,116,126,137,143)
          GROUP BY registers.id
        UNION
          SELECT registers.id AS register_id, sum(recorded_total_l + recorded_total_s / 20.0) AS receipts, 'premiere-loge' AS section
          FROM registers JOIN ticket_sales ON (registers.id = register_id)
          WHERE seating_category_id IN (7,8,9,10,15,20,27,28,37,42,43,44,57,63,64,65,78,83,85,89,91,95,98,102,109,113,117,123,127,134,139)
          GROUP BY registers.id;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION bucket(DOUBLE PRECISION, INT, TEXT, TEXT) CASCADE;
      DROP VIEW amalgamated_sales CASCADE;
    SQL
  end
end

