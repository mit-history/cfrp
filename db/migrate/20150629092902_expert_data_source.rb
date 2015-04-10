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

=begin

  http://s3.amazonaws.com/images.cfregisters.org/register_images/images/000/031/276/original/M119_02_R155_339r.jpg

        CREATE VIEW warehouse.images AS
          WITH temp0 AS (
            SELECT (regexp_matches(coalesce(image_file_name, filepath), '([^/]*)$'))[1] AS filename, 
            min(register_images.id) AS id
            FROM register_images
            GROUP BY filename
          ), temp1 AS (
            SELECT filename, id, (regexp_matches(filename, '_R(\d+)'))[1]::int AS volume FROM temp0
          ), temp2 AS (
            SELECT filename, id, volume, (row_number() over (partition by volume ORDER BY filename) - 1) AS page FROM temp1
          ), temp3 AS (
            SELECT min(register_images.id) AS id, date
            FROM registers JOIN register_images ON (registers.id = register_id) 
            WHERE orientation = 'recto' AND verification_state_id in (1,6)
            GROUP BY register_id, date
          ) SELECT filename,
                   to_char(id, '099/999/999') AS id_partition,
                   volume,
                   page,
                   date
            FROM temp2 LEFT OUTER JOIN temp3 USING (id)
            ORDER BY volume, page;

=end


  end

  def down
    execute <<-SQL
      DROP SCHEMA warehouse CASCADE;
    SQL
  end
end
