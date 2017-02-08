--
-- Name: lagrange_authors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE lagrange_authors (
    id character varying(16) NOT NULL,
    etype character varying(32),
    birth_death_years character varying(64),
    mainrole character varying(64),
    mainform character varying(64),
    firstname character varying(64),
    firstname1 character varying(64),
    formcompl character varying(64),
    lastname character varying(64),
    firstname2 character varying(64),
    computedform character varying(128),
    url character varying(128)
);


--
-- Name: lagrange_doc_authors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE lagrange_doc_authors (
    doc_id character varying(32),
    aut_id character varying(32)
);


--
-- Name: lagrange_docs; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE lagrange_docs (
    id character varying(32) NOT NULL,
    etype character varying(64),
    title character varying(256),
    title2 character varying(256),
    subtitle character varying(256),
    imgref character varying(128),
    imgurl character varying(128),
    url character varying(128)
);


--
-- Name: normalized_genres; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE normalized_genres (
    genre character varying(64),
    normalized character varying(64)
);



--
-- Name: person; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE person (
    id integer NOT NULL,
    first_name character varying(128),
    last_name character varying(128),
    honorific character varying(32),
    birthyear integer,
    deathyear integer,
    pref_label character varying(255),
    orig_label character varying(255),
    bnf_notes text
);


--
-- Name: play_person; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE play_person (
    play_id integer,
    person_id integer
);



--
-- Name: validated_plays; Type: MATERIALIZED VIEW; Schema: public; Owner: jamie
--

CREATE MATERIALIZED VIEW validated_plays AS
 SELECT plays.id,
    plays.author,
    plays.title,
    plays.genre,
    plays.created_at,
    plays.updated_at,
    plays.acts,
    plays.prose_vers,
    plays.prologue,
    plays.musique_danse_machine,
    plays.alternative_title,
    plays.url,
    plays.date_de_creation,
    plays.expert_validated,
    plays._packed_id
   FROM plays
  WHERE (plays.expert_validated = true)
  WITH NO DATA;


--
-- Name: performances; Type: MATERIALIZED VIEW; Schema: public; Owner: jamie
--

CREATE MATERIALIZED VIEW performances AS
 SELECT a.id AS author_id,
    a.pref_label AS author_name,
    r.id AS register_id,
    r.date,
    r.weekday,
    r.season,
    (((COALESCE(r.total_receipts_recorded_l, 0) * 240) + (COALESCE(r.total_receipts_recorded_s, 0) * 12)) + COALESCE(r.total_receipts_recorded_d, 0)) AS receipts,
    p.id AS play_id,
    p.title,
    p.genre,
    rp.debut,
    rp.reprise,
    rp.ordering
   FROM ((((registers r
     JOIN register_plays rp ON ((r.id = rp.register_id)))
     JOIN validated_plays p ON ((rp.play_id = p.id)))
     JOIN play_person pp ON ((pp.play_id = p.id)))
     JOIN person a ON ((pp.person_id = a.id)))
  WITH NO DATA;


--
-- Name: person_altlabels; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE person_altlabels (
    id integer NOT NULL,
    person_id integer,
    label character varying(255)
);


--
-- Name: person_altlabels_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE person_altlabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_altlabels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE person_altlabels_id_seq OWNED BY person_altlabels.id;


--
-- Name: person_depictions; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE person_depictions (
    id integer NOT NULL,
    person_id integer,
    url character varying(255)
);


--
-- Name: person_depictions_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE person_depictions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_depictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE person_depictions_id_seq OWNED BY person_depictions.id;


--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE person_id_seq OWNED BY person.id;


--
-- Name: person_same_as; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE person_same_as (
    person_id integer,
    url character varying(255)
);


--
-- Name: play_same_as; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE play_same_as (
    play_id integer,
    url character varying(255)
);




--
-- Name: rcf_lagrange_authors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE rcf_lagrange_authors (
    rcf_id integer,
    lagrange_id character varying(16)
);


--
-- Name: person id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- Name: person_altlabels id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_altlabels ALTER COLUMN id SET DEFAULT nextval('person_altlabels_id_seq'::regclass);


--
-- Name: person_depictions id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_depictions ALTER COLUMN id SET DEFAULT nextval('person_depictions_id_seq'::regclass);

--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: person_agg; Type: MATERIALIZED VIEW; Schema: public; Owner: jamie
--

CREATE MATERIALIZED VIEW person_agg AS
 SELECT p.id,
    p.first_name AS givenname,
    p.last_name AS familyname,
    p.honorific,
    p.birthyear AS birthdate,
    p.deathyear AS deathdate,
    p.pref_label AS name,
    p.bnf_notes,
    p.orig_label,
    array_agg(DISTINCT psa.url) AS ext_uris,
    array_agg(DISTINCT alt.label) AS alt_labels,
    array_agg(DISTINCT depict.url) AS depict_urls
   FROM (((((person p
     LEFT JOIN person_altlabels alt ON ((p.id = alt.person_id)))
     LEFT JOIN person_depictions depict ON ((p.id = depict.person_id)))
     LEFT JOIN person_same_as psa ON ((p.id = psa.person_id)))
     JOIN play_person pp ON ((pp.person_id = p.id)))
     JOIN validated_plays vp ON ((pp.play_id = vp.id)))
  GROUP BY p.id
  WITH NO DATA;


--
-- Name: lagrange_authors lagrange_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY lagrange_authors
    ADD CONSTRAINT lagrange_authors_pkey PRIMARY KEY (id);


--
-- Name: lagrange_docs lagrange_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY lagrange_docs
    ADD CONSTRAINT lagrange_docs_pkey PRIMARY KEY (id);

--
-- Name: person_altlabels person_altlabels_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_altlabels
    ADD CONSTRAINT person_altlabels_pkey PRIMARY KEY (id);


--
-- Name: person_depictions person_depictions_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_depictions
    ADD CONSTRAINT person_depictions_pkey PRIMARY KEY (id);

-- Name: lagrange_authors_computedform_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_computedform_idx ON lagrange_authors USING btree (computedform);


--
-- Name: lagrange_authors_firstname1_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_firstname1_idx ON lagrange_authors USING btree (firstname1);


--
-- Name: lagrange_authors_firstname2_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_firstname2_idx ON lagrange_authors USING btree (firstname2);


--
-- Name: lagrange_authors_firstname_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_firstname_idx ON lagrange_authors USING btree (firstname);


--
-- Name: lagrange_authors_formcompl_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_formcompl_idx ON lagrange_authors USING btree (formcompl);


--
-- Name: lagrange_authors_lastname_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_lastname_idx ON lagrange_authors USING btree (lastname);


--
-- Name: lagrange_authors_mainform_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_mainform_idx ON lagrange_authors USING btree (mainform);


--
-- Name: lagrange_authors_mainrole_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_authors_mainrole_idx ON lagrange_authors USING btree (mainrole);


--
-- Name: lagrange_doc_authors_aut_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_doc_authors_aut_idx ON lagrange_doc_authors USING btree (aut_id);


--
-- Name: lagrange_doc_authors_doc_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_doc_authors_doc_idx ON lagrange_doc_authors USING btree (doc_id);


--
-- Name: lagrange_docs_etype_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX lagrange_docs_etype_idx ON lagrange_docs USING btree (etype);


--
-- Name: normalized_genres_genre_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX normalized_genres_genre_idx ON normalized_genres USING btree (genre);


--
-- Name: normalized_genres_normalized_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX normalized_genres_normalized_idx ON normalized_genres USING btree (normalized);


--
-- Name: performances_author_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX performances_author_id_idx ON performances USING btree (author_id);


--
-- Name: performances_date_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX performances_date_idx ON performances USING btree (date);


--
-- Name: performances_play_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX performances_play_id_idx ON performances USING btree (play_id);


--
-- Name: performances_register_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX performances_register_id_idx ON performances USING btree (register_id);


--
-- Name: person_agg_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_agg_id_idx ON person_agg_old USING btree (id);


--
-- Name: person_altlabels_person_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_altlabels_person_id_idx ON person_altlabels USING btree (person_id);


--
-- Name: person_birthyear_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_birthyear_idx ON person USING btree (birthyear);


--
-- Name: person_deathyear_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_deathyear_idx ON person USING btree (deathyear);


--
-- Name: person_depictions_person_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_depictions_person_id_idx ON person_depictions USING btree (person_id);


--
-- Name: person_first_name_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_first_name_idx ON person USING btree (first_name);


--
-- Name: person_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_id_idx ON person USING btree (id);


--
-- Name: person_last_name_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_last_name_idx ON person USING btree (last_name);


--
-- Name: person_same_as_person_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX person_same_as_person_id_idx ON person_same_as USING btree (person_id);


--


--
-- Name: play_person_person_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX play_person_person_id_idx ON play_person USING btree (person_id);


--
-- Name: play_person_play_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX play_person_play_id_idx ON play_person USING btree (play_id);


--
-- Name: play_same_as_play_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX play_same_as_play_id_idx ON play_same_as USING btree (play_id);


--
-- Name: rcf_lagrange_authors_lagrange_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX rcf_lagrange_authors_lagrange_idx ON rcf_lagrange_authors USING btree (lagrange_id);


--
-- Name: rcf_lagrange_authors_rcf_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX rcf_lagrange_authors_rcf_idx ON rcf_lagrange_authors USING btree (rcf_id);

--
-- Name: validated_plays_genre_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX validated_plays_genre_idx ON validated_plays USING btree (genre);


--
-- Name: validated_plays_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX validated_plays_id_idx ON validated_plays USING btree (id);

--
-- Name: person_altlabels person_altlabels_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_altlabels
    ADD CONSTRAINT person_altlabels_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: person_depictions person_depictions_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_depictions
    ADD CONSTRAINT person_depictions_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: person_same_as person_same_as_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY person_same_as
    ADD CONSTRAINT person_same_as_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: play_person play_person_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY play_person
    ADD CONSTRAINT play_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: play_person play_person_play_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY play_person
    ADD CONSTRAINT play_person_play_id_fkey FOREIGN KEY (play_id) REFERENCES plays(id);


--
-- Name: play_same_as play_same_as_play_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY play_same_as
    ADD CONSTRAINT play_same_as_play_id_fkey FOREIGN KEY (play_id) REFERENCES plays(id);


