desc "This task refreshes the views used by the RCF_UI Application, and is called by the Heroku scheduler add-on"
namespace :rcf_ui do
  namespace :mat_views do

    task :refresh => :environment do

      conn = ActiveRecord::Base.connection

      ActiveRecord::Base.transaction do

        conn.execute <<-SQL
          DROP MATERIALIZED VIEW IF EXISTS performances;
          DROP MATERIALIZED VIEW IF EXISTS person_agg;
          DROP MATERIALIZED VIEW IF EXISTS validated_plays;

          CREATE MATERIALIZED VIEW validated_plays AS
                 SELECT * FROM plays
                 WHERE expert_validated = TRUE;

          CREATE INDEX validated_plays_id_idx ON validated_plays(id);
          CREATE INDEX validated_plays_genre_idx ON validated_plays(genre);
          CREATE MATERIALIZED VIEW person_agg AS
                 SELECT p.ext_id AS id, p.first_name AS givenName, p.last_name AS familyName,
                        p.honorific, p.birthyear AS birthDate, p.deathyear AS deathDate,
                        p.pref_label AS name, p.bnf_notes, p.orig_label,
                        array_agg(DISTINCT psa.url) AS ext_uris,
                        array_agg(DISTINCT alt.label) AS alt_labels,
                        array_agg(DISTINCT depict.url) AS depict_urls
                 FROM people p LEFT OUTER JOIN person_altlabels alt ON (p.ext_id=alt.ext_id)
                               LEFT OUTER JOIN person_depictions depict ON (p.ext_id=depict.ext_id)
                               LEFT OUTER JOIN person_same_as psa ON (p.ext_id=psa.ext_id)
                               JOIN authorships au ON (au.ext_id=p.ext_id)
                               JOIN validated_plays vp ON (au.play_id=vp.id)
                 GROUP BY p.id;

          CREATE index person_agg_id_idx ON person_agg(id);


          CREATE MATERIALIZED VIEW performances AS
                 SELECT a.id AS author_id, a.pref_label AS author_name,
                        r.id as register_id, r.date, r.weekday, r.season,
                        (COALESCE(r.total_receipts_recorded_l, 0) * 240 +
                         COALESCE(r.total_receipts_recorded_s, 0) * 12 +
                         COALESCE(r.total_receipts_recorded_d, 0)) AS receipts,
                        p.id AS play_id, p.title, p.genre,
                        rp.debut, rp.reprise, rp.ordering
                 FROM registers r JOIN register_plays rp ON (r.id=rp.register_id)
                                  JOIN validated_plays p ON (rp.play_id=p.id)
                                  JOIN authorships au ON (au.play_id=p.id)
                                  JOIN people a ON (au.person_id=a.ext_id);

          CREATE INDEX performances_author_id_idx ON performances(author_id);
          CREATE INDEX performances_play_id_idx ON performances(play_id);
          CREATE INDEX performances_register_id_idx ON performances(register_id);
          CREATE INDEX performances_date_idx ON performances(date);
        SQL
      end
    end
  end
end
