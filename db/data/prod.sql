CREATE TABLE plays (
    id integer NOT NULL,
    author character varying(255),
    title character varying(255),
    genre character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    acts integer,
    prose_vers character varying(255),
    prologue boolean,
    musique_danse_machine boolean,
    alternative_title character varying(255),
    url character varying(255),
    date_de_creation date,
    expert_validated boolean,
    _packed_id integer NOT NULL
);


ALTER TABLE plays OWNER TO jamie;

--
-- Name: register_plays; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_plays (
    id integer NOT NULL,
    register_id integer,
    play_id integer,
    firstrun boolean,
    newactor character varying(255),
    actorrole character varying(255),
    firstrun_perfnum integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ordering integer,
    free_access boolean,
    ex_attendance character varying(255),
    ex_representation character varying(255),
    ex_place character varying(255),
    reprise boolean,
    debut boolean,
    reprise_perfnum integer
);
