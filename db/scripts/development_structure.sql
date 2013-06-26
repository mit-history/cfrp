--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- Name: signature; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE signature;


--
-- Name: sig_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_in(cstring) RETURNS signature
    LANGUAGE c STRICT
    AS 'signature.so', 'sig_in';


--
-- Name: sig_out(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_out(signature) RETURNS cstring
    LANGUAGE c STRICT
    AS 'signature.so', 'sig_out';


--
-- Name: signature; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE signature (
    INTERNALLENGTH = variable,
    INPUT = sig_in,
    OUTPUT = sig_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


--
-- Name: contains(signature, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION contains(signature, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'contains';


--
-- Name: count(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION count(signature) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'count';


--
-- Name: expand_nesting(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION expand_nesting(tbl text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  cols  TEXT[];
  len   INT;
  aggr  TEXT;
BEGIN
  -- determine column names
  SELECT array_agg(col) INTO cols FROM nest_levels(tbl) AS col;
  len := array_length(cols, 1);
  
  -- add unique index on facet value columns
  aggr := array_to_string(cols, ', ');
  EXECUTE 'CREATE UNIQUE INDEX ' || quote_ident(tbl) || '_ndx  ON ' || quote_ident(tbl) || '(' || aggr || ')';
    
  -- expand each level in turn
  FOR i IN REVERSE (len-1)..1 LOOP
    aggr := array_to_string(cols[1:i], ', ');
    EXECUTE 'INSERT INTO ' || quote_ident(tbl) || '(' || aggr || ', level, signature)'
         || ' SELECT ' || aggr || ', ' || i || ' AS level, collect(signature)'
         || ' FROM ' || quote_ident(tbl)
         || ' GROUP BY ' || aggr;
  END LOOP;
  
  -- root node
  EXECUTE 'INSERT INTO ' || quote_ident(tbl) || '(level, signature)'
       || ' SELECT 0 AS level, collect(signature) FROM ' || quote_ident(tbl);
END;
$$;


--
-- Name: members(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION members(signature) RETURNS SETOF integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'members';


--
-- Name: nest_levels(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nest_levels(tbl text) RETURNS SETOF text
    LANGUAGE sql
    AS $_$
  SELECT quote_ident(a.attname::TEXT)
    FROM pg_attribute a LEFT JOIN pg_attrdef d ON a.attrelid = d.adrelid AND a.attnum = d.adnum
    WHERE a.attrelid = $1::regclass
      AND NOT a.attname IN ('signature', 'level')
      AND a.attnum > 0 AND NOT a.attisdropped
    ORDER BY a.attnum;
$_$;


--
-- Name: recreate_table(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION recreate_table(tbl text, select_expr text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  SET client_min_messages = warning;
  EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(tbl);
  EXECUTE 'CREATE TABLE ' || quote_ident(tbl) || ' AS ' || select_expr;
  RESET client_min_messages;
END;
$$;


--
-- Name: renumber_table(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION renumber_table(tbl text, col text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN renumber_table(tbl, col, 0.15);
END;
$$;


--
-- Name: renumber_table(text, text, real); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION renumber_table(tbl text, col text, threshold real) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  seq TEXT;
  wastage REAL;
  renumber BOOLEAN;
BEGIN
  seq = tbl || '_' || col || '_seq';

  -- Drop numbered column if it already exists
  SET client_min_messages = 'WARNING';
  BEGIN
    IF signature_wastage(tbl, col) <= threshold THEN
      renumber := false;
    ELSE
      renumber := true;
      EXECUTE 'DROP INDEX IF EXISTS ' || quote_ident(tbl || '_' || col || '_ndx');
      EXECUTE 'ALTER TABLE ' || quote_ident(tbl) || ' DROP COLUMN ' || quote_ident(col);
      EXECUTE 'DROP SEQUENCE IF EXISTS ' || quote_ident(seq);
    END IF;
  EXCEPTION
    WHEN undefined_column THEN renumber := true;
  END;
  RESET client_min_messages;

  --  Create numbered column & its index
  IF renumber THEN
    EXECUTE 'CREATE SEQUENCE ' || quote_ident(seq) || ' MINVALUE 0 ';
    EXECUTE 'ALTER TABLE ' || quote_ident(tbl) || ' ADD COLUMN ' || quote_ident(col) || ' INT4 DEFAULT nextval(''' || quote_ident(seq) || ''')';
    EXECUTE 'ALTER SEQUENCE ' || quote_ident(seq) || ' OWNED BY ' || quote_ident(tbl) || '.' || quote_ident(col);
    EXECUTE 'CREATE INDEX ' || quote_ident(tbl || '_' || col || '_ndx') || ' ON ' || quote_ident(tbl) || '(' || col || ')';
  END IF;

  RETURN renumber;
END;
$$;


--
-- Name: sig_and(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_and(signature, signature) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_and';


--
-- Name: sig_cmp(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_cmp(signature, signature) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_cmp';


--
-- Name: sig_eq(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_eq(signature, signature) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_eq';


--
-- Name: sig_get(signature, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_get(signature, integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_get';


--
-- Name: sig_gt(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_gt(signature, signature) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_gt';


--
-- Name: sig_gte(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_gte(signature, signature) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_gte';


--
-- Name: sig_length(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_length(signature) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_length';


--
-- Name: sig_lt(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_lt(signature, signature) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_lt';


--
-- Name: sig_lte(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_lte(signature, signature) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_lte';


--
-- Name: sig_min(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_min(signature) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_min';


--
-- Name: sig_or(signature, signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_or(signature, signature) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_or';


--
-- Name: sig_resize(signature, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_resize(signature, integer) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_resize';


--
-- Name: sig_set(signature, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_set(signature, integer, integer) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_set';


--
-- Name: sig_set(signature, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_set(signature, integer) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_set';


--
-- Name: sig_xor(signature); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sig_xor(signature) RETURNS signature
    LANGUAGE c IMMUTABLE STRICT
    AS 'signature.so', 'sig_xor';


--
-- Name: signature_wastage(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION signature_wastage(tbl text, col text) RETURNS real
    LANGUAGE plpgsql
    AS $$
DECLARE
  max REAL;
  count REAL;
BEGIN
  EXECUTE 'SELECT count(*) FROM ' || quote_ident(tbl)
          INTO count;
  EXECUTE 'SELECT max(' || quote_ident(col) || ') FROM ' || quote_ident(tbl)
          INTO max;
  RETURN 1.0 - (count / (COALESCE(max, 0) + 1));
END;
$$;


--
-- Name: collect(signature); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE collect(signature) (
    SFUNC = sig_or,
    STYPE = signature
);


--
-- Name: filter(signature); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE filter(signature) (
    SFUNC = sig_and,
    STYPE = signature
);


--
-- Name: signature(integer); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE signature(integer) (
    SFUNC = public.sig_set,
    STYPE = signature,
    INITCOND = '0'
);


--
-- Name: &; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR & (
    PROCEDURE = sig_and,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = &
);


--
-- Name: +; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR + (
    PROCEDURE = sig_set,
    LEFTARG = signature,
    RIGHTARG = integer
);


--
-- Name: <; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR < (
    PROCEDURE = sig_lt,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <= (
    PROCEDURE = sig_lte,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


--
-- Name: =; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR = (
    PROCEDURE = sig_eq,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


--
-- Name: >; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR > (
    PROCEDURE = sig_gt,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >= (
    PROCEDURE = sig_gte,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


--
-- Name: |; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR | (
    PROCEDURE = sig_or,
    LEFTARG = signature,
    RIGHTARG = signature,
    COMMUTATOR = |
);


--
-- Name: signature_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS signature_ops
    DEFAULT FOR TYPE signature USING btree AS
    OPERATOR 1 <(signature,signature) ,
    OPERATOR 2 <=(signature,signature) ,
    OPERATOR 3 =(signature,signature) ,
    OPERATOR 4 >=(signature,signature) ,
    OPERATOR 5 >(signature,signature) ,
    FUNCTION 1 sig_cmp(signature,signature);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comment_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: comment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comment_types_id_seq OWNED BY comment_types.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    name character varying(255),
    value text,
    register_id integer,
    comment_type_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: page_text_templates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE page_text_templates (
    id integer NOT NULL,
    template_text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: page_text_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE page_text_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: page_text_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE page_text_templates_id_seq OWNED BY page_text_templates.id;


--
-- Name: plays; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plays (
    id integer NOT NULL,
    author character varying(255),
    title character varying(255),
    genre character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: plays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE plays_id_seq OWNED BY plays.id;


--
-- Name: register_contributors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_contributors (
    id integer NOT NULL,
    register_id integer,
    task_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: register_contributors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_contributors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_contributors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_contributors_id_seq OWNED BY register_contributors.id;


--
-- Name: register_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_images (
    id integer NOT NULL,
    filepath character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


--
-- Name: register_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_images_id_seq OWNED BY register_images.id;


--
-- Name: register_periods; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_periods (
    id integer NOT NULL,
    period character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: register_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_periods_id_seq OWNED BY register_periods.id;


--
-- Name: register_plays; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_plays (
    id integer NOT NULL,
    register_id integer,
    play_id integer,
    firstrun boolean,
    newactor character varying(255),
    actorrole character varying(255),
    editor_flag boolean,
    firstrun_perfnum integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ordering integer
);


--
-- Name: register_plays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_plays_id_seq OWNED BY register_plays.id;


--
-- Name: register_tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_tasks (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: register_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_tasks_id_seq OWNED BY register_tasks.id;


--
-- Name: register_type_seating_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE register_type_seating_categories (
    id integer NOT NULL,
    register_type_id integer,
    seating_category_id integer,
    ordering integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: register_type_seating_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE register_type_seating_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: register_type_seating_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE register_type_seating_categories_id_seq OWNED BY register_type_seating_categories.id;


--
-- Name: registers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE registers (
    id integer NOT NULL,
    date timestamp without time zone,
    weekday character varying(255),
    season character varying(255),
    register_num integer,
    payment_notes text,
    date_flag boolean,
    season_flag boolean,
    regnum_flag boolean,
    totalreceipts_flag boolean,
    payment_notes_flag boolean,
    page_text text,
    page_text_flag boolean,
    total_receipts_recorded_l integer,
    total_receipts_recorded_s integer,
    representation integer,
    signatory character varying(255),
    signatory_flag boolean,
    rep_flag boolean,
    misc_notes text,
    misc_notes_flag boolean,
    for_editor_notes text,
    ouverture boolean,
    ouverture_flag boolean,
    cloture boolean,
    cloture_flag boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    register_image_id integer,
    register_period_id integer
);


--
-- Name: registers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE registers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: registers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE registers_id_seq OWNED BY registers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: seating_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE seating_categories (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: seating_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seating_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: seating_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE seating_categories_id_seq OWNED BY seating_categories.id;


--
-- Name: ticket_sales; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ticket_sales (
    id integer NOT NULL,
    total_sold integer DEFAULT 0,
    register_id integer DEFAULT 0,
    seating_category_id integer DEFAULT 0,
    price_per_ticket_l integer DEFAULT 0,
    price_per_ticket_s integer DEFAULT 0,
    recorded_total_l integer DEFAULT 0,
    recorded_total_s integer DEFAULT 0,
    editor_flag boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: ticket_sales_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ticket_sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: ticket_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ticket_sales_id_seq OWNED BY ticket_sales.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    password_salt character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    remember_token character varying(255),
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    shortname character varying(255),
    last_name character varying(255),
    first_name character varying(255),
    bio text,
    institution character varying(255),
    institution_code character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE comment_types ALTER COLUMN id SET DEFAULT nextval('comment_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE page_text_templates ALTER COLUMN id SET DEFAULT nextval('page_text_templates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE plays ALTER COLUMN id SET DEFAULT nextval('plays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_contributors ALTER COLUMN id SET DEFAULT nextval('register_contributors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_images ALTER COLUMN id SET DEFAULT nextval('register_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_periods ALTER COLUMN id SET DEFAULT nextval('register_periods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_plays ALTER COLUMN id SET DEFAULT nextval('register_plays_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_tasks ALTER COLUMN id SET DEFAULT nextval('register_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE register_type_seating_categories ALTER COLUMN id SET DEFAULT nextval('register_type_seating_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE registers ALTER COLUMN id SET DEFAULT nextval('registers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE seating_categories ALTER COLUMN id SET DEFAULT nextval('seating_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ticket_sales ALTER COLUMN id SET DEFAULT nextval('ticket_sales_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: comment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comment_types
    ADD CONSTRAINT comment_types_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: page_text_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY page_text_templates
    ADD CONSTRAINT page_text_templates_pkey PRIMARY KEY (id);


--
-- Name: plays_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plays
    ADD CONSTRAINT plays_pkey PRIMARY KEY (id);


--
-- Name: register_contributors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_contributors
    ADD CONSTRAINT register_contributors_pkey PRIMARY KEY (id);


--
-- Name: register_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_images
    ADD CONSTRAINT register_images_pkey PRIMARY KEY (id);


--
-- Name: register_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_periods
    ADD CONSTRAINT register_periods_pkey PRIMARY KEY (id);


--
-- Name: register_plays_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_plays
    ADD CONSTRAINT register_plays_pkey PRIMARY KEY (id);


--
-- Name: register_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_tasks
    ADD CONSTRAINT register_tasks_pkey PRIMARY KEY (id);


--
-- Name: register_type_seating_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY register_type_seating_categories
    ADD CONSTRAINT register_type_seating_categories_pkey PRIMARY KEY (id);


--
-- Name: registers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY registers
    ADD CONSTRAINT registers_pkey PRIMARY KEY (id);


--
-- Name: seating_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY seating_categories
    ADD CONSTRAINT seating_categories_pkey PRIMARY KEY (id);


--
-- Name: ticket_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ticket_sales
    ADD CONSTRAINT ticket_sales_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20100803170252');

INSERT INTO schema_migrations (version) VALUES ('20100809211513');

INSERT INTO schema_migrations (version) VALUES ('20100809211624');

INSERT INTO schema_migrations (version) VALUES ('20100809212238');

INSERT INTO schema_migrations (version) VALUES ('20100810163745');

INSERT INTO schema_migrations (version) VALUES ('20100810163846');

INSERT INTO schema_migrations (version) VALUES ('20100810164119');

INSERT INTO schema_migrations (version) VALUES ('20100810175244');

INSERT INTO schema_migrations (version) VALUES ('20100810194838');

INSERT INTO schema_migrations (version) VALUES ('20100810194937');

INSERT INTO schema_migrations (version) VALUES ('20100810195134');

INSERT INTO schema_migrations (version) VALUES ('20100810195329');

INSERT INTO schema_migrations (version) VALUES ('20100810195504');

INSERT INTO schema_migrations (version) VALUES ('20100810195826');

INSERT INTO schema_migrations (version) VALUES ('20100825145959');

INSERT INTO schema_migrations (version) VALUES ('20100913203149');

INSERT INTO schema_migrations (version) VALUES ('20100913204111');

INSERT INTO schema_migrations (version) VALUES ('20100913204919');

INSERT INTO schema_migrations (version) VALUES ('20100913213751');

INSERT INTO schema_migrations (version) VALUES ('20100927135806');