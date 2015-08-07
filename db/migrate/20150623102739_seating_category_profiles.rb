class SeatingCategoryProfiles < ActiveRecord::Migration
  def up
    execute <<-SQL

    -- NB * Profiles should partition the entire ticket sale data set! *
    -- Otherwise data analytics based on them will be incorrect.
    CREATE TABLE seating_category_profile(
      id SERIAL PRIMARY KEY,
      profile TEXT NOT NULL,
      period TEXT NOT NULL,
      start_date DATE NOT NULL,
      end_date DATE NOT NULL,
      seating_category_ids INT ARRAY NOT NULL,
      category TEXT NOT NULL,
      estimated_seats REAL DEFAULT 1.0,
      note TEXT
    );

    CREATE VIEW ticket_sales_by_profile AS
      WITH temp AS (
        SELECT ticket_sales.*, date, profile
        FROM ticket_sales, registers,
             (SELECT DISTINCT profile FROM seating_category_profile) AS profile
        WHERE register_id = registers.id)
      SELECT temp.*, seating_category_profile.id AS seating_category_profile_id, category
        FROM temp LEFT OUTER JOIN seating_category_profile
          ON (date >= start_date AND date <= end_date
              AND seating_category_id = ANY(seating_category_ids));

    CREATE VIEW ticket_sales_by_profile_lint AS
      SELECT date, total_sold, seating_category_id, seating_categories.name, ticket_sales_by_profile.category, period
      FROM ticket_sales_by_profile
      JOIN seating_categories ON (seating_category_id = seating_categories.id)
      LEFT OUTER JOIN seating_category_profile ON (seating_category_profile.id = seating_category_profile_id)
      ORDER BY date;

SQL

  end

  def down
    execute <<-SQL

    DROP TABLE IF EXISTS seating_category_profile CASCADE;

    SQL
  end
end
