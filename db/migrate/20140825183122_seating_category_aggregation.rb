class SeatingCategoryAggregation < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE FUNCTION bucket(val int, size int, padding int, nullval TEXT) RETURNS text AS $$
        SELECT COALESCE(lpad((round(val / size) * size) :: text, padding) || '-' || (round(val / size) * size + (size - 1)) :: text, nullval);
      $$ LANGUAGE SQL IMMUTABLE;

      CREATE VIEW category_sales AS
        SELECT register_id, date, total_sold, name, price_per_ticket_l, recorded_total_l, seating_category_id
        FROM registers
        JOIN ticket_sales ON (registers.id = register_id)
        JOIN seating_categories ON (seating_categories.id = seating_category_id);

      CREATE VIEW amalgamated_sales AS
          SELECT registers.id AS register_id, sum(recorded_total_l)::INT AS receipts, 'parterre' AS section
          FROM registers JOIN ticket_sales ON (registers.id = register_id)
          WHERE seating_category_id IN (18,39,60,80,88,94,101,108,116,126,137,143)
          GROUP BY registers.id
        UNION
          SELECT registers.id AS register_id, sum(recorded_total_l)::INT AS receipts, 'premiere-loge' AS section
          FROM registers JOIN ticket_sales ON (registers.id = register_id)
          WHERE seating_category_id IN (7,8,9,10,15,20,27,28,37,42,43,44,57,63,64,65,78,83,85,89,91,95,98,102,109,113,117,123,127,134,139)
          GROUP BY registers.id;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION bucket(INT, INT, INT, TEXT);
      DROP VIEW category_sales;
      DROP VIEW amalgamated_sales;
    SQL
  end
end
