class ExpertDataSource < ActiveRecord::Migration
  def up
    execute <<-SQL

      CREATE SCHEMA warehouse;

      CREATE VIEW warehouse.plays AS
        SELECT id AS play_id,
               author,
               title,
               genre,
               acts,
               prose_vers,
               prologue,
               musique_danse_machine,
               date_de_creation
        FROM plays
        ORDER BY author, title;

      CREATE VIEW warehouse.performances AS
        SELECT date,
               play_id,
               ordering,
               total_receipts_recorded_l::REAL + (total_receipts_recorded_s::REAL / 20.0) + (total_receipts_recorded_d::REAL / 240.0) AS receipts,
               representation,
               signatory,
               COALESCE(ouverture, false) AS ouverture,
               COALESCE(cloture, false)   AS cloture,
               COALESCE(free_access, false) AS free_access,
               COALESCE(firstrun, false)  AS firstrun,
               firstrun_perfnum,
               COALESCE(reprise, false)   AS reprise,
               reprise_perfnum,
               newactor,
               actorrole,
               debut,
               ex_attendance,
               ex_representation,
               ex_place,
               register_num
        FROM registers
        JOIN register_plays ON (registers.id = register_plays.register_id)
        WHERE registers.verification_state_id IN (1,6)
        ORDER BY date, ordering;

      CREATE VIEW warehouse.sales AS
        SELECT date,
               total_sold AS sold,
               price_per_ticket_l::REAL + (price_per_ticket_s::REAL / 20.0) + (price_per_ticket_d::REAL / 240.0) AS price,
               estimated_seats::REAL,
               seating_category_profile.profile AS profile,
               seating_category_profile.period AS period,
               seating_category_profile.category AS category
        FROM ticket_sales_by_profile
        JOIN seating_category_profile ON (seating_category_profile.id = seating_category_profile_id)
        ORDER BY date ASC, total_sold DESC;

        CREATE VIEW warehouse.images AS
          SELECT date,
                 register_id,
                 to_char(register_images.id, 'FM099/999/999') AS id_partition,
                 image_file_name AS filename
          FROM register_images
          JOIN registers ON (registers.id = register_id)
          WHERE register_images.id IN (SELECT min(id) FROM register_images WHERE orientation = 'recto' GROUP BY register_id)
          ORDER BY date;
    SQL
  end

  def down
    execute <<-SQL
      DROP SCHEMA warehouse CASCADE;
    SQL
  end
end
