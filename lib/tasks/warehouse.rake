#
# N.B. Information in the TSV warehouse files dumps views in the 'warehouse' schema.
#
#      Update periodically via this task.

desc "This task is called by the Heroku scheduler add-on"
# Should be invoked via a cron-style script. On Heroku, follow this recipe:
#   https://devcenter.heroku.com/articles/scheduler

def norm(s)
  s.gsub(/ /, '-').underscore
end

namespace :db do
  namespace :warehouse do
    # For a more human-readable version of these views, see the expert data source
    # db/migrate/20150629092902_expert_data_source.rb

    # This task creates a star-schema style data warehouse for all of the data in the CFRP
    # database.

    # Run as a scheduler task because the schema will change depending on the contents of
    # the database.

    task :refresh => :environment do

      conn = ActiveRecord::Base.connection

      ActiveRecord::Base.transaction do

        # drop old warehouse

        conn.execute (%q{DROP SCHEMA IF EXISTS warehouse})

        # create core of fact table

        conn.execute (%q{CREATE SCHEMA warehouse})

        # NB reuses the data entry tables as dimension tables... better to copy completely?

        conn.execute <<-SQL
          CREATE TABLE warehouse.facts AS
            SELECT date,
                   ticket_sales.id AS ticket_sales_id,
                   total_sold AS sold,
                   price_per_ticket_l::REAL + (price_per_ticket_s::REAL / 20.0) + (price_per_ticket_d::REAL / 240.0) AS price,
                   register_id,
                   seating_category_id AS raw_seating_category_id
            FROM ticket_sales
            JOIN registers ON (register_id = registers.id)
            WHERE verification_state_id IN (1,6)
              AND total_sold > 0 AND price_per_ticket_l + price_per_ticket_s + price_per_ticket_d > 0
            ORDER BY date ASC, price DESC, sold DESC
        SQL

        seating_profiles = conn.select_values(%q{SELECT DISTINCT profile FROM seating_category_profile})

        seating_profiles.each do |profile|
          col = conn.quote_column_name(norm("#{profile}_seating_category_profile_id"))
          conn.execute("ALTER TABLE warehouse.facts ADD COLUMN #{col} INT REFERENCES seating_category_profile(id)")
          conn.execute <<-SQL2
            UPDATE warehouse.facts SET #{col} =
              (SELECT min(id)
               FROM seating_category_profile
               WHERE profile = #{conn.quote(profile)} AND
                     start_date <= date AND date <= end_date AND
                     raw_seating_category_id = ANY(seating_category_ids))
          SQL2
        end

        playbill_max = conn.select_value(%q{SELECT max(ordering) FROM register_plays JOIN registers ON (registers.id = register_id) WHERE verification_state_id IN (1,6)}).to_i

        (1..playbill_max).each do |i|
          conn.execute("ALTER TABLE warehouse.facts ADD COLUMN performance_#{i}_id INT REFERENCES register_plays(id)")
          conn.execute("ALTER TABLE warehouse.facts ADD COLUMN play_#{i}_id INT REFERENCES public.plays(id)")

          conn.execute("UPDATE warehouse.facts SET performance_#{i}_id = (SELECT min(register_plays.id) FROM register_plays WHERE ordering = #{i} AND register_plays.register_id = facts.register_id)")
          conn.execute("UPDATE warehouse.facts SET play_#{i}_id = (SELECT min(play_id) FROM register_plays WHERE ordering = #{i} AND register_plays.register_id = facts.register_id)")
        end

        # Log the warehouse timestmap

        conn.execute <<-SQL
          CREATE TABLE fact_stamps AS
            SELECT md5(count(*)::text || max(created_at)::text) AS hash_stamp, now() AS created_at FROM ticket_sales;
        SQL

        puts "Success"

      end


=begin

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

=end

    end
  end
end
