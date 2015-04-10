#
# N.B. Information in the TSV warehouse files dumps views in the 'warehouse' schema.
#
#      Update periodically via this task.

desc "This task is called by the Heroku scheduler add-on"
# Should be invoked via a cron-style script. On Heroku, follow this recipe:
#   https://devcenter.heroku.com/articles/scheduler

namespace :db do
  namespace :warehouse do
    # See the ExpertDataSource migration (db/migrate/20150129140722_expert_data_source.rb)
    # This task refreshes the TSV data dumps from views declared in the migration.
    # Eventually, the task should instead copy the resulting files to Amazon S3 for download.
    task :refresh => :environment do
      puts "Dumping data warehouse to TSV"

      conn = ActiveRecord::Base.connection

      # plays omit primary key (use author/title instead in R/SciPy/Julia)
      conn.execute <<-SQL
        COPY (
          SELECT author,
                 title,
                 genre,
                 acts,
                 prose_vers,
                 prologue,
                 musique_danse_machine,
                 date_de_creation
          FROM warehouse.plays
        ) TO '/tmp/cfrp-plays.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      # performances TSV includes author and title rather than a foreign key
      conn.execute <<-SQL
        COPY (
          SELECT date,
                 plays.author,
                 plays.title,
                 ordering,
                 register_num,
                 receipts,
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
                 ex_place,
                 images.id_partition,
                 images.filename
           FROM warehouse.performances
           JOIN warehouse.plays USING (play_id)
           LEFT OUTER JOIN warehouse.images USING (date)
        ) TO '/tmp/cfrp-performances.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      conn.execute <<-SQL
        COPY (
          SELECT date,
                 sold,
                 price,
                 profile,
                 period,
                 category FROM warehouse.sales
        ) TO '/tmp/cfrp-sales.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL

      puts "Done."

    end
  end
end
