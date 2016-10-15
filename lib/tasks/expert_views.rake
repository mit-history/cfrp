desc "This task is called by the Heroku scheduler add-on"
# Should be invoked via a cron-style script. On Heroku, follow this recipe:
#   https://devcenter.heroku.com/articles/scheduler

namespace :db do
  namespace :expert_views do
    # This task refreshes the TSV data dumps of the entire database.
    # Eventually, the task should copy the resulting files to Amazon S3 for download.
    task :refresh => :environment do
      puts "Dumping expert data views to TSV"

      conn = ActiveRecord::Base.connection

      # plays omit primary key (use author/title instead in R/SciPy/Julia)
      conn.execute <<-SQL
        COPY (
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
        ) TO '/tmp/cfrp-plays.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      # performances TSV includes author and title rather than a foreign key
      # in a tool like R or SciPy, join on these two fields
      conn.execute <<-SQL
        COPY (
          SELECT date,
                 author,
                 title,
                 play_id,
                 ordering,
                 register_num,
                 total_receipts_recorded_l::REAL + (total_receipts_recorded_s::REAL / 20.0) + (total_receipts_recorded_d::REAL / 240.0) AS receipts,
                 representation,
                 signatory,
                 ouverture,
                 cloture,
                 free_access,
                 firstrun,
                 firstrun_perfnum,
                 reprise,
                 reprise_perfnum,
                 newactor,
                 actorrole,
                 debut,
                 ex_attendance,
                 ex_representation,
                 ex_place
           FROM registers
           JOIN register_plays ON (registers.id = register_id)
           JOIN plays ON (plays.id = play_id)
        ) TO '/tmp/cfrp-performances.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      conn.execute <<-SQL
        COPY (
          SELECT date,
                 total_sold AS sold,
                 price_per_ticket_l::REAL + (price_per_ticket_s::REAL / 20.0) + (price_per_ticket_d::REAL / 240.0) AS price,
                 seating_categories.name AS seating_category
          FROM ticket_sales
          JOIN registers ON (registers.id = register_id)
          JOIN seating_categories ON (seating_categories.id = seating_category_id)
        ) TO '/tmp/cfrp-sales.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      puts "Done."

    end
  end
end
