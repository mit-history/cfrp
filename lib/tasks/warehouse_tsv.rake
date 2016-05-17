namespace :db do
  namespace :warehouse do

    # This task is an ETL (extract, transform, and load) script that creates a star-schema style data warehouse for
    # the queryable data in the CFRP entry forms.

    # Schema mirrors the OLTP database, but in a modified first normal form.  Dimension tables are copied in case
    # we decide to use a separate analytics database in the future.

    # Run as a scheduler task because the schema will change depending on the contents of
    # the database.

    task :tsv => :environment do

      conn = ActiveRecord::Base.connection

      conn.execute <<-SQL

        SET search_path = warehouse;

        DROP VIEW IF EXISTS warehouse.cfrp CASCADE;

        CREATE VIEW warehouse.cfrp AS
          SELECT date, cfrp_season(date), sold, price,
            play_1.author AS author_1,
            play_1.title AS title_1,
            play_1.genre AS genre_1,
            play_1.acts AS acts_1,
            play_1.prose_vers AS prose_vers_1,
            play_1.prologue AS prologue_1,
            play_1.musique_danse_machine AS musique_danse_machine_1,
            play_1.date_de_creation AS date_de_creation_1,
            play_2.author AS author_2,
            play_2.title AS title_2,
            play_2.genre AS genre_2,
            play_2.acts AS acts_2,
            play_2.prose_vers AS prose_vers_2,
            play_2.prologue AS prologue_2,
            play_2.musique_danse_machine AS musique_danse_machine_2,
            play_2.date_de_creation AS date_de_creation_2,
            play_3.author AS author_3,
            play_3.title AS title_3,
            play_3.genre AS genre_3,
            play_3.acts AS acts_3,
            play_3.prose_vers AS prose_vers_3,
            play_3.prologue AS prologue_3,
            play_3.musique_danse_machine AS musique_danse_machine_3,
            play_3.date_de_creation AS date_de_creation_3,
            performance_1.ouverture AS ouverture_1,
            performance_1.cloture AS cloture_1,
            performance_1.free_access AS free_access_1,
            performance_1.firstrun AS firstrun_1,
            performance_1.firstrun_perfnum AS firstrun_perfnum_1,
            performance_1.reprise AS reprise_1,
            performance_1.reprise_perfnum AS reprise_perfnum_1,
            performance_1.newactor AS newactor_1,
            performance_1.actorrole AS actorrole_1,
            performance_1.debut AS debut_1,
            performance_1.ex_attendance AS ex_attendance_1,
            performance_1.ex_representation AS ex_representation_1,
            performance_1.ex_place AS ex_place_1,
            performance_2.ouverture AS ouverture_2,
            performance_2.cloture AS cloture_2,
            performance_2.free_access AS free_access_2,
            performance_2.firstrun AS firstrun_2,
            performance_2.firstrun_perfnum AS firstrun_perfnum_2,
            performance_2.reprise AS reprise_2,
            performance_2.reprise_perfnum AS reprise_perfnum_2,
            performance_2.newactor AS newactor_2,
            performance_2.actorrole AS actorrole_2,
            performance_2.debut AS debut_2,
            performance_2.ex_attendance AS ex_attendance_2,
            performance_2.ex_representation AS ex_representation_2,
            performance_2.ex_place AS ex_place_2,
            performance_3.ouverture AS ouverture_3,
            performance_3.cloture AS cloture_3,
            performance_3.free_access AS free_access_3,
            performance_3.firstrun AS firstrun_3,
            performance_3.firstrun_perfnum AS firstrun_perfnum_3,
            performance_3.reprise AS reprise_3,
            performance_3.reprise_perfnum AS reprise_perfnum_3,
            performance_3.newactor AS newactor_3,
            performance_3.actorrole AS actorrole_3,
            performance_3.debut AS debut_3,
            performance_3.ex_attendance AS ex_attendance_3,
            performance_3.ex_representation AS ex_representation_3,
            performance_3.ex_place AS ex_place_3
       FROM sales_facts
          LEFT OUTER JOIN play_dim AS play_1 ON (play_1_id = play_1.id)
          LEFT OUTER JOIN play_dim AS play_2 ON (play_2_id = play_2.id)
          LEFT OUTER JOIN play_dim AS play_3 ON (play_3_id = play_3.id)
          LEFT OUTER JOIN performance_dim AS performance_1 ON (performance_1_id = performance_1.id)
          LEFT OUTER JOIN performance_dim AS performance_2 ON (performance_2_id = performance_2.id)
          LEFT OUTER JOIN performance_dim AS performance_3 ON (performance_3_id = performance_3.id);

       COPY (SELECT * FROM warehouse.cfrp) TO '/tmp/cfrp.tsv' WITH CSV HEADER DELIMITER E'\t';
      SQL
    end
  end
end