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

    # This task is an ETL (extract, transform, and load) script that creates a star-schema style data warehouse for
    # the queryable data in the CFRP entry forms.

    # Schema mirrors the OLTP database, but in a modified first normal form.  Dimension tables are copied in case
    # we decide to use a separate analytics database in the future.

    # Run as a scheduler task because the schema will change depending on the contents of
    # the database.

    task :refresh => :environment do

      conn = ActiveRecord::Base.connection

      ActiveRecord::Base.transaction do

        conn.execute <<-SQL

          DROP SCHEMA IF EXISTS warehouse CASCADE;

          CREATE SCHEMA warehouse;

          CREATE TABLE warehouse.sales_facts AS
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
            ORDER BY date ASC, price DESC, sold DESC;

          CREATE TABLE warehouse.play_dim AS
            SELECT id,
                   author,
                   title,
                   genre,
                   acts,
                   prose_vers,
                   prologue,
                   musique_danse_machine,
                   date_de_creation
            FROM plays
--            WHERE expert_validated
            ORDER BY author, title;
          ALTER TABLE warehouse.play_dim ADD PRIMARY KEY (id);

          CREATE TABLE warehouse.performance_dim AS
            SELECT register_plays.id,
                   ouverture,
                   cloture,
                   free_access,
                   firstrun,
                   firstrun_perfnum,
                   reprise,
                   reprise_perfnum,
                   newactor,
                   actorrole,
                   ex_attendance,
                   ex_representation,
                   ex_place,
                   debut
            FROM register_plays
            JOIN registers ON (registers.id = register_id)
            WHERE verification_state_id IN (1,6)
            ORDER BY date;
          ALTER TABLE warehouse.performance_dim ADD PRIMARY KEY (id);

          CREATE TABLE warehouse.seating_category_dim AS
            SELECT id,
                   period,
                   category
            FROM seating_category_profile
            ORDER BY period, category;
          ALTER TABLE warehouse.seating_category_dim ADD PRIMARY KEY (id);
        SQL

        seating_profiles = conn.select_values(%q{SELECT DISTINCT profile FROM seating_category_profile})

        seating_profiles.each do |profile|
          col = conn.quote_column_name(norm("#{profile}_seating_category_id"))
          conn.execute("ALTER TABLE warehouse.sales_facts ADD COLUMN #{col} INT REFERENCES warehouse.seating_category_dim(id)")
          conn.execute <<-SQL2
            UPDATE warehouse.sales_facts SET #{col} =
              (SELECT min(id)
               FROM seating_category_profile
               WHERE profile = #{conn.quote(profile)} AND
                     start_date <= date AND date <= end_date AND
                     raw_seating_category_id = ANY(seating_category_ids))
          SQL2
        end

        playbill_max = conn.select_value(%q{SELECT max(ordering) FROM register_plays JOIN registers ON (registers.id = register_id) WHERE verification_state_id IN (1,6)}).to_i

        (1..playbill_max).each do |i|
          conn.execute("ALTER TABLE warehouse.sales_facts ADD COLUMN performance_#{i}_id INT REFERENCES warehouse.performance_dim(id)")
          conn.execute("ALTER TABLE warehouse.sales_facts ADD COLUMN play_#{i}_id INT REFERENCES warehouse.play_dim(id)")

          conn.execute("UPDATE warehouse.sales_facts SET performance_#{i}_id = (SELECT min(register_plays.id) FROM register_plays WHERE ordering = #{i} AND register_plays.register_id = sales_facts.register_id)")
          conn.execute("UPDATE warehouse.sales_facts SET play_#{i}_id = (SELECT min(play_id) FROM register_plays WHERE ordering = #{i} AND register_plays.register_id = sales_facts.register_id)")
        end

        conn.execute("ALTER TABLE warehouse.sales_facts DROP COLUMN register_id")
        conn.execute("ALTER TABLE warehouse.sales_facts DROP COLUMN raw_seating_category_id")

        # Log the warehouse timestmap

        conn.execute <<-SQL

          CREATE TABLE warehouse.warehouse_hash AS
            SELECT md5(t1.s || t2.s || t3.s || t4.s),
                   now() AS created_at
            FROM
              (SELECT md5(array_agg(t.* ORDER BY date)::text) AS s FROM warehouse.sales_facts t) AS t1,
              (SELECT md5(array_agg(t.* ORDER BY id)::text) AS s FROM warehouse.play_dim t) AS t2,
              (SELECT md5(array_agg(t.* ORDER BY id)::text) AS s FROM warehouse.performance_dim t) AS t3,
              (SELECT md5(array_agg(t.* ORDER BY id)::text) AS s FROM warehouse.seating_category_dim t) AS t4;
        SQL

        # Utility function for querying by season
        #
        # based on http://www.adp-gmbh.ch/ora/plsql/calendar.html

        conn.execute <<-SQL

          CREATE FUNCTION warehouse.easter(yr int) RETURNS date AS $$
          DECLARE
            a        INT;
            b        INT;
            c        INT;
            d        INT;
            e        INT;
            m        INT;
            n        INT;
            day_     INT;
            month_   INT;
            result_  DATE;

          BEGIN
            if yr < 1583 or yr > 2299 then
              return null;
            end if;

            if yr < 1700 then
              m := 22;
              n :=  2;
            elsif yr < 1800 then
              m := 23;
              n :=  3;
            elsif yr < 1900 then
              m := 23;
              n :=  4;
            elsif yr < 2100 then
              m := 24;
              n :=  5;
            elsif yr < 2200 then
              m := 24;
              n :=  6;
            else
              m := 25;
              n :=  0;
            end if;

            a := mod (yr,19);
            b := mod (yr, 4);
            c := mod (yr, 7);
            d := mod (19*a + m, 30);
            e := mod (2*b + 4*c + 6*d + n,7);

            day_   := 22 + d + e;
            month_ := 3;

            if day_ > 31 then
              day_  := day_-31;
              month_:= month_+1;
            end if;

            if day_ = 26 and  month_ = 4 then
              day_ := 19;
            end if;

            if day_ = 25 and month_ = 4 and d = 28 and e = 6 and a > 10 then
              day_:=18;
            end if;

            return to_date(
              to_char(day_,    '00') || '.' ||
              to_char(month_,  '00') || '.' ||
              to_char(yr,   '0000'),
             'DD.MM.YYYY'
            );
          END;
          $$ LANGUAGE plpgsql IMMUTABLE;

          CREATE FUNCTION warehouse.easter_floor(d0 date) RETURNS DATE AS $$
          DECLARE
            yr INT;
            e DATE;
          BEGIN
            yr := date_part('year', d0);
            e := warehouse.easter(yr);
            IF e < d0 THEN
              RETURN e;
            ELSE
              RETURN warehouse.easter(yr-1);
            END IF;
          END;
          $$ LANGUAGE plpgsql IMMUTABLE;

          CREATE FUNCTION warehouse.cfrp_season(d0 date) RETURNS TEXT AS $$
          DECLARE
            yr   INT;
          BEGIN
            yr := date_part('year', warehouse.easter_floor(d0));
            RETURN yr::TEXT || '-' || (yr+1)::TEXT;
          END;
          $$ LANGUAGE plpgsql IMMUTABLE;

          CREATE INDEX sales_facts_cfrp_season_idx ON warehouse.sales_facts( warehouse.cfrp_season(date) );
        SQL

      end

    end
  end
end
