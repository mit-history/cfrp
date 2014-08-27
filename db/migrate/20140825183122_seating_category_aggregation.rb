class SeatingCategoryAggregation < ActiveRecord::Migration
  def up

    # Listing seating category ids directly is obviously a sub-par approach... however,
    #
    #   (a) while the investigators' interpretations of periods and seating categories
    #       is still under transition, I decided it was best to avoid adding new columns
    #       or denormalizing the schema
    #
    #   (b) the kinds of aggregations necessary for measures like receipts are not
    #       possible with a faceted browser, so best to make it easy to back out later
    #       and adopt a real multidimensional indexer.

    execute <<-SQL

      CREATE FUNCTION bucket(val INT, size INT, fmt TEXT, nullval TEXT) RETURNS TEXT AS $$
        SELECT COALESCE(
          to_char(round(val / size) * size, fmt) || '-' || to_char(round(val / size) * size + size - 1, fmt), nullval);
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
      DROP FUNCTION bucket(INT, INT, TEXT, TEXT);
      DROP VIEW category_sales;
      DROP VIEW amalgamated_sales;
    SQL
  end
end
