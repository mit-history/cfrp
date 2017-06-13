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

DROP TABLE IF EXISTS normalized_genres;

CREATE TABLE normalized_genres (
    genre varchar(64),
    normalized varchar(64)
);

CREATE INDEX normalized_genres_genre_idx ON normalized_genres(genre);
CREATE INDEX normalized_genres_normalized_idx ON normalized_genres(normalized);

INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragédie', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES (null, null);
INSERT INTO normalized_genres (genre, normalized) VALUES ('drame', 'drame');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie-ballet', 'comédie-ballet');
INSERT INTO normalized_genres (genre, normalized) VALUES ('', null);
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie héroïque', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragi-comédie', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pastorale', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('prologue', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie en 5 actes', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièce', null);
INSERT INTO normalized_genres (genre, normalized) VALUES ('divertissement', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('drame héroïque', 'drame');
INSERT INTO normalized_genres (genre, normalized) VALUES ('intermède', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('scène lyrique', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie épisodique', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièce héroïque', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragedie', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pastorale héroïque', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('ambigu-comique', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('0', null);
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièce historique', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie - drame', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragédie bourgeoise', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie bouffonne', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('drame historique', 'drame');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie-pastorale', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièces dramatique', 'drame');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie-opéra', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('unidentified', null);
INSERT INTO normalized_genres (genre, normalized) VALUES ('musique', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragédie (traduite de l''anglais', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('dialogue', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragi-comédie / tragédie', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragi comédie', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièce allégorique', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('vaudeville', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie héori-féérie', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('Tragédie', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('tragédie-comédie-pastorale héroïque', 'tragédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('drame patriotique', 'drame');
INSERT INTO normalized_genres (genre, normalized) VALUES ('pièce héroïque nationale', 'autre');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie champêtre', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('comédie patriotique', 'comédie');
INSERT INTO normalized_genres (genre, normalized) VALUES ('divertissement comique', 'comédie');
