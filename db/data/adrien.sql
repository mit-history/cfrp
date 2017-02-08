--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: facet; Type: SCHEMA; Schema: -; Owner: jamie
--

CREATE SCHEMA facet;


ALTER SCHEMA facet OWNER TO jamie;

--
-- Name: warehouse; Type: SCHEMA; Schema: -; Owner: jamie
--

CREATE SCHEMA warehouse;


ALTER SCHEMA warehouse OWNER TO jamie;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = facet, pg_catalog;

--
-- Name: sig_resize(bytea, integer); Type: FUNCTION; Schema: facet; Owner: jamie
--

CREATE FUNCTION sig_resize(sig bytea, bits integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
  len INT;
  bytes INT;
BEGIN
  bytes := ceil(bits / 8.0)::INT;
  len := length(sig);
  IF bytes > len THEN
    -- RAISE NOTICE 'Extending signature from % to % bytes', len, bytes;
    RETURN sig || ('\x' || repeat('00', bytes - len))::BYTEA;
  ELSIF bits < len THEN
    -- no provision in PostgreSQL for truncating a BYTEA
    RETURN sig;
  END IF;
  RETURN sig;
END $$;


ALTER FUNCTION facet.sig_resize(sig bytea, bits integer) OWNER TO jamie;

--
-- Name: sig_set(bytea, integer); Type: FUNCTION; Schema: facet; Owner: jamie
--

CREATE FUNCTION sig_set(sig bytea, pos integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
BEGIN
  RETURN facet.sig_set(sig, pos, 1);
END $$;


ALTER FUNCTION facet.sig_set(sig bytea, pos integer) OWNER TO jamie;

--
-- Name: sig_set(bytea, integer, integer); Type: FUNCTION; Schema: facet; Owner: jamie
--

CREATE FUNCTION sig_set(sig bytea, pos integer, val integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
BEGIN
  RETURN set_bit(facet.sig_resize(sig, pos+1), pos, val);
END $$;


ALTER FUNCTION facet.sig_set(sig bytea, pos integer, val integer) OWNER TO jamie;

--
-- Name: wastage_accum(integer[], integer); Type: FUNCTION; Schema: facet; Owner: jamie
--

CREATE FUNCTION wastage_accum(state integer[], val integer) RETURNS integer[]
    LANGUAGE sql
    AS $$
  SELECT ARRAY[ state[1]+1, GREATEST(state[2], val) ];
$$;


ALTER FUNCTION facet.wastage_accum(state integer[], val integer) OWNER TO jamie;

--
-- Name: wastage_proportion(integer[]); Type: FUNCTION; Schema: facet; Owner: jamie
--

CREATE FUNCTION wastage_proportion(state integer[]) RETURNS double precision
    LANGUAGE sql
    AS $$
  SELECT (1.0 - (state[1]::double precision / (COALESCE(state[2], 0.0) + 1.0)))
$$;


ALTER FUNCTION facet.wastage_proportion(state integer[]) OWNER TO jamie;

SET search_path = public, pg_catalog;

--
-- Name: bucket(double precision, integer, text, text); Type: FUNCTION; Schema: public; Owner: jamie
--

CREATE FUNCTION bucket(val double precision, size integer, fmt text, nullval text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
        SELECT COALESCE(
          to_char(trunc(val / size) * size, fmt) || '-' || to_char(trunc(val / size) * size + size - 1, fmt), nullval);
      $$;


ALTER FUNCTION public.bucket(val double precision, size integer, fmt text, nullval text) OWNER TO jamie;

--
-- Name: expand_nesting(text); Type: FUNCTION; Schema: public; Owner: jamie
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


ALTER FUNCTION public.expand_nesting(tbl text) OWNER TO jamie;

--
-- Name: nest_levels(text); Type: FUNCTION; Schema: public; Owner: jamie
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


ALTER FUNCTION public.nest_levels(tbl text) OWNER TO jamie;

--
-- Name: recreate_table(text, text); Type: FUNCTION; Schema: public; Owner: jamie
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


ALTER FUNCTION public.recreate_table(tbl text, select_expr text) OWNER TO jamie;

--
-- Name: renumber_table(text, text); Type: FUNCTION; Schema: public; Owner: jamie
--

CREATE FUNCTION renumber_table(tbl text, col text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN renumber_table(tbl, col, 0.15);
END;
$$;


ALTER FUNCTION public.renumber_table(tbl text, col text) OWNER TO jamie;

--
-- Name: renumber_table(text, text, real); Type: FUNCTION; Schema: public; Owner: jamie
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


ALTER FUNCTION public.renumber_table(tbl text, col text, threshold real) OWNER TO jamie;

--
-- Name: signature_wastage(text, text); Type: FUNCTION; Schema: public; Owner: jamie
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


ALTER FUNCTION public.signature_wastage(tbl text, col text) OWNER TO jamie;

SET search_path = warehouse, pg_catalog;

--
-- Name: cfrp_season(date); Type: FUNCTION; Schema: warehouse; Owner: jamie
--

CREATE FUNCTION cfrp_season(d0 date) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
          DECLARE
            yr   INT;
          BEGIN
            yr := date_part('year', warehouse.easter_floor(d0));
            RETURN yr::TEXT || '-' || (yr+1)::TEXT;
          END;
          $$;


ALTER FUNCTION warehouse.cfrp_season(d0 date) OWNER TO jamie;

--
-- Name: easter(integer); Type: FUNCTION; Schema: warehouse; Owner: jamie
--

CREATE FUNCTION easter(yr integer) RETURNS date
    LANGUAGE plpgsql IMMUTABLE
    AS $$
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
          $$;


ALTER FUNCTION warehouse.easter(yr integer) OWNER TO jamie;

--
-- Name: easter_floor(date); Type: FUNCTION; Schema: warehouse; Owner: jamie
--

CREATE FUNCTION easter_floor(d0 date) RETURNS date
    LANGUAGE plpgsql IMMUTABLE
    AS $$
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
          $$;


ALTER FUNCTION warehouse.easter_floor(d0 date) OWNER TO jamie;

SET search_path = facet, pg_catalog;

--
-- Name: signature(integer); Type: AGGREGATE; Schema: facet; Owner: jamie
--

CREATE AGGREGATE signature(integer) (
    SFUNC = facet.sig_set,
    STYPE = bytea,
    INITCOND = ''
);


ALTER AGGREGATE facet.signature(integer) OWNER TO jamie;

--
-- Name: wastage(integer); Type: AGGREGATE; Schema: facet; Owner: jamie
--

CREATE AGGREGATE wastage(integer) (
    SFUNC = wastage_accum,
    STYPE = integer[],
    INITCOND = '{0,0}',
    FINALFUNC = wastage_proportion
);


ALTER AGGREGATE facet.wastage(integer) OWNER TO jamie;

--
-- Name: +; Type: OPERATOR; Schema: facet; Owner: jamie
--

CREATE OPERATOR + (
    PROCEDURE = sig_set,
    LEFTARG = bytea,
    RIGHTARG = integer
);


ALTER OPERATOR facet.+ (bytea, integer) OWNER TO jamie;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


ALTER TABLE active_admin_comments OWNER TO jamie;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE active_admin_comments_id_seq OWNER TO jamie;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE admin_users OWNER TO jamie;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_users_id_seq OWNER TO jamie;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: registers; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE registers (
    id integer NOT NULL,
    date date,
    weekday character varying(255),
    season character varying(255),
    register_num integer,
    payment_notes text,
    page_text text,
    total_receipts_recorded_l integer,
    total_receipts_recorded_s integer,
    representation integer,
    signatory character varying(255),
    misc_notes text,
    for_editor_notes text,
    ouverture boolean,
    cloture boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    register_image_id integer,
    register_period_id integer,
    verification_state_id integer,
    irregular_receipts_name character varying(255),
    page_de_gauche character varying(255),
    date_of_left_page_info date,
    register_images_count integer DEFAULT 0,
    irregular_receipts_name_2 character varying(255),
    irregular_receipts_name_3 character varying(255),
    irregular_receipts_name_4 character varying(255),
    irregular_receipts_name_5 character varying(255),
    irregular_receipts_name_6 character varying(255),
    irregular_receipts_name_7 character varying(255),
    irregular_receipts_name_8 character varying(255),
    irregular_receipts_name_9 character varying(255),
    irregular_receipts_name_10 character varying(255),
    total_receipts_recorded_d integer,
    _packed_id integer NOT NULL
);


ALTER TABLE registers OWNER TO jamie;

--
-- Name: ticket_sales; Type: TABLE; Schema: public; Owner: jamie
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
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    price_per_ticket_d integer DEFAULT 0,
    recorded_total_d integer DEFAULT 0
);


ALTER TABLE ticket_sales OWNER TO jamie;

--
-- Name: amalgamated_sales; Type: VIEW; Schema: public; Owner: jamie
--

CREATE VIEW amalgamated_sales AS
 SELECT registers.id AS register_id,
    sum(((ticket_sales.recorded_total_l)::numeric + ((ticket_sales.recorded_total_s)::numeric / 20.0))) AS receipts,
    'parterre'::text AS section
   FROM (registers
     JOIN ticket_sales ON ((registers.id = ticket_sales.register_id)))
  WHERE (ticket_sales.seating_category_id = ANY (ARRAY[18, 39, 60, 80, 88, 94, 101, 108, 116, 126, 137, 143]))
  GROUP BY registers.id
UNION
 SELECT registers.id AS register_id,
    sum(((ticket_sales.recorded_total_l)::numeric + ((ticket_sales.recorded_total_s)::numeric / 20.0))) AS receipts,
    'premiere-loge'::text AS section
   FROM (registers
     JOIN ticket_sales ON ((registers.id = ticket_sales.register_id)))
  WHERE (ticket_sales.seating_category_id = ANY (ARRAY[7, 8, 9, 10, 15, 20, 27, 28, 37, 42, 43, 44, 57, 63, 64, 65, 78, 83, 85, 89, 91, 95, 98, 102, 109, 113, 117, 123, 127, 134, 139]))
  GROUP BY registers.id;


ALTER TABLE amalgamated_sales OWNER TO jamie;

--
-- Name: assignments; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE assignments (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE assignments OWNER TO jamie;

--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE assignments_id_seq OWNER TO jamie;

--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE assignments_id_seq OWNED BY assignments.id;


--
-- Name: comment_types; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE comment_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE comment_types OWNER TO jamie;

--
-- Name: comment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE comment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_types_id_seq OWNER TO jamie;

--
-- Name: comment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE comment_types_id_seq OWNED BY comment_types.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: jamie
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


ALTER TABLE comments OWNER TO jamie;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO jamie;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE delayed_jobs OWNER TO jamie;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE delayed_jobs_id_seq OWNER TO jamie;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: foo; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE foo (
    x boolean
);


ALTER TABLE foo OWNER TO jamie;

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


ALTER TABLE lagrange_authors OWNER TO jamie;

--
-- Name: lagrange_doc_authors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE lagrange_doc_authors (
    doc_id character varying(32),
    aut_id character varying(32)
);


ALTER TABLE lagrange_doc_authors OWNER TO jamie;

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


ALTER TABLE lagrange_docs OWNER TO jamie;

--
-- Name: lhp_category_assignments; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE lhp_category_assignments (
    id integer NOT NULL,
    register_id integer NOT NULL,
    page_de_gauche_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE lhp_category_assignments OWNER TO jamie;

--
-- Name: lhp_category_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE lhp_category_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lhp_category_assignments_id_seq OWNER TO jamie;

--
-- Name: lhp_category_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE lhp_category_assignments_id_seq OWNED BY lhp_category_assignments.id;


--
-- Name: normalized_genres; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE normalized_genres (
    genre character varying(64),
    normalized character varying(64)
);


ALTER TABLE normalized_genres OWNER TO jamie;

--
-- Name: page_de_gauches; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE page_de_gauches (
    id integer NOT NULL,
    category character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE page_de_gauches OWNER TO jamie;

--
-- Name: page_de_gauches_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE page_de_gauches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_de_gauches_id_seq OWNER TO jamie;

--
-- Name: page_de_gauches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE page_de_gauches_id_seq OWNED BY page_de_gauches.id;


--
-- Name: page_text_templates; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE page_text_templates (
    id integer NOT NULL,
    template_text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE page_text_templates OWNER TO jamie;

--
-- Name: page_text_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE page_text_templates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_text_templates_id_seq OWNER TO jamie;

--
-- Name: page_text_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE page_text_templates_id_seq OWNED BY page_text_templates.id;


--
-- Name: participations; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE participations (
    id integer NOT NULL,
    role character varying(255),
    person_id integer,
    debut boolean,
    "character" character varying(255),
    register_play_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE participations OWNER TO jamie;

--
-- Name: participations_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE participations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE participations_id_seq OWNER TO jamie;

--
-- Name: participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE participations_id_seq OWNED BY participations.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE people (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    full_name character varying(255),
    pseudonym character varying(255),
    honorific character varying(255),
    url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    alias character varying(255),
    societaire_pensionnaire character varying(255),
    dates character varying(255)
);


ALTER TABLE people OWNER TO jamie;

--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE people_id_seq OWNER TO jamie;

--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


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


ALTER TABLE person OWNER TO jamie;

--
-- Name: play_person; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE play_person (
    play_id integer,
    person_id integer
);


ALTER TABLE play_person OWNER TO jamie;

--
-- Name: plays; Type: TABLE; Schema: public; Owner: jamie
--

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


ALTER TABLE register_plays OWNER TO jamie;

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


ALTER TABLE validated_plays OWNER TO jamie;

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


ALTER TABLE performances OWNER TO jamie;

--
-- Name: person_altlabels; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE person_altlabels (
    id integer NOT NULL,
    person_id integer,
    label character varying(255)
);


ALTER TABLE person_altlabels OWNER TO jamie;

--
-- Name: person_altlabels_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE person_altlabels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_altlabels_id_seq OWNER TO jamie;

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


ALTER TABLE person_depictions OWNER TO jamie;

--
-- Name: person_depictions_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE person_depictions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_depictions_id_seq OWNER TO jamie;

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


ALTER TABLE person_id_seq OWNER TO jamie;

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


ALTER TABLE person_same_as OWNER TO jamie;

--
-- Name: play_same_as; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE play_same_as (
    play_id integer,
    url character varying(255)
);


ALTER TABLE play_same_as OWNER TO jamie;

--
-- Name: register_period_seating_categories; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_period_seating_categories (
    id integer NOT NULL,
    register_period_id integer,
    seating_category_id integer,
    ordering integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE register_period_seating_categories OWNER TO jamie;

--
-- Name: register_periods; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_periods (
    id integer NOT NULL,
    period character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE register_periods OWNER TO jamie;

--
-- Name: seating_categories; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE seating_categories (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE seating_categories OWNER TO jamie;

--
-- Name: play_ticket_sales; Type: VIEW; Schema: public; Owner: jamie
--

CREATE VIEW play_ticket_sales AS
 SELECT register_plays.id AS play_performance_id,
    6 AS seating_capacity,
    seating_categories.name,
    plays.title,
    plays.author,
    plays.genre,
    registers.date,
    ticket_sales.total_sold
   FROM plays,
    register_plays,
    registers,
    register_periods,
    register_period_seating_categories,
    seating_categories,
    ticket_sales
  WHERE ((plays.id = register_plays.play_id) AND (registers.id = register_plays.register_id) AND (registers.register_period_id = register_periods.id) AND (register_periods.id = register_period_seating_categories.register_period_id) AND (seating_categories.id = register_period_seating_categories.seating_category_id) AND (ticket_sales.register_id = registers.id) AND (ticket_sales.seating_category_id = seating_categories.id));


ALTER TABLE play_ticket_sales OWNER TO jamie;

--
-- Name: plays__packed_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE plays__packed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plays__packed_id_seq OWNER TO jamie;

--
-- Name: plays__packed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE plays__packed_id_seq OWNED BY plays._packed_id;


--
-- Name: plays_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plays_id_seq OWNER TO jamie;

--
-- Name: plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE plays_id_seq OWNED BY plays.id;


--
-- Name: rcf_lagrange_authors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE rcf_lagrange_authors (
    rcf_id integer,
    lagrange_id character varying(16)
);


ALTER TABLE rcf_lagrange_authors OWNER TO jamie;

--
-- Name: register_contributors; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_contributors (
    id integer NOT NULL,
    register_id integer,
    task_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE register_contributors OWNER TO jamie;

--
-- Name: register_contributors_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_contributors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_contributors_id_seq OWNER TO jamie;

--
-- Name: register_contributors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_contributors_id_seq OWNED BY register_contributors.id;


--
-- Name: register_images; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_images (
    id integer NOT NULL,
    filepath character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    register_id integer,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone,
    orientation character varying(255)
);


ALTER TABLE register_images OWNER TO jamie;

--
-- Name: register_images_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_images_id_seq OWNER TO jamie;

--
-- Name: register_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_images_id_seq OWNED BY register_images.id;


--
-- Name: register_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_periods_id_seq OWNER TO jamie;

--
-- Name: register_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_periods_id_seq OWNED BY register_periods.id;


--
-- Name: register_plays_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_plays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_plays_id_seq OWNER TO jamie;

--
-- Name: register_plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_plays_id_seq OWNED BY register_plays.id;


--
-- Name: register_tasks; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE register_tasks (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE register_tasks OWNER TO jamie;

--
-- Name: register_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_tasks_id_seq OWNER TO jamie;

--
-- Name: register_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_tasks_id_seq OWNED BY register_tasks.id;


--
-- Name: register_type_seating_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE register_type_seating_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE register_type_seating_categories_id_seq OWNER TO jamie;

--
-- Name: register_type_seating_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE register_type_seating_categories_id_seq OWNED BY register_period_seating_categories.id;


--
-- Name: registers__packed_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE registers__packed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE registers__packed_id_seq OWNER TO jamie;

--
-- Name: registers__packed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE registers__packed_id_seq OWNED BY registers._packed_id;


--
-- Name: registers_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE registers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE registers_id_seq OWNER TO jamie;

--
-- Name: registers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE registers_id_seq OWNED BY registers.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255)
);


ALTER TABLE roles OWNER TO jamie;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_id_seq OWNER TO jamie;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE schema_migrations OWNER TO jamie;

--
-- Name: seating_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE seating_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seating_categories_id_seq OWNER TO jamie;

--
-- Name: seating_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE seating_categories_id_seq OWNED BY seating_categories.id;


--
-- Name: seating_category_profile; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE seating_category_profile (
    id integer NOT NULL,
    profile text NOT NULL,
    period text NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    seating_category_ids integer[] NOT NULL,
    category text NOT NULL,
    estimated_seats real DEFAULT 1.0,
    note text
);


ALTER TABLE seating_category_profile OWNER TO jamie;

--
-- Name: seating_category_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE seating_category_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seating_category_profile_id_seq OWNER TO jamie;

--
-- Name: seating_category_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE seating_category_profile_id_seq OWNED BY seating_category_profile.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE taggings OWNER TO jamie;

--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taggings_id_seq OWNER TO jamie;

--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE tags OWNER TO jamie;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO jamie;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: ticket_sales_by_profile; Type: VIEW; Schema: public; Owner: jamie
--

CREATE VIEW ticket_sales_by_profile AS
 WITH temp AS (
         SELECT ticket_sales.id,
            ticket_sales.total_sold,
            ticket_sales.register_id,
            ticket_sales.seating_category_id,
            ticket_sales.price_per_ticket_l,
            ticket_sales.price_per_ticket_s,
            ticket_sales.recorded_total_l,
            ticket_sales.recorded_total_s,
            ticket_sales.created_at,
            ticket_sales.updated_at,
            ticket_sales.price_per_ticket_d,
            ticket_sales.recorded_total_d,
            registers.date,
            profile.profile
           FROM ticket_sales,
            registers,
            ( SELECT DISTINCT seating_category_profile_1.profile
                   FROM seating_category_profile seating_category_profile_1) profile
          WHERE (ticket_sales.register_id = registers.id)
        )
 SELECT temp.id,
    temp.total_sold,
    temp.register_id,
    temp.seating_category_id,
    temp.price_per_ticket_l,
    temp.price_per_ticket_s,
    temp.recorded_total_l,
    temp.recorded_total_s,
    temp.created_at,
    temp.updated_at,
    temp.price_per_ticket_d,
    temp.recorded_total_d,
    temp.date,
    temp.profile,
    seating_category_profile.id AS seating_category_profile_id,
    seating_category_profile.category
   FROM (temp
     LEFT JOIN seating_category_profile ON (((temp.date >= seating_category_profile.start_date) AND (temp.date <= seating_category_profile.end_date) AND (temp.seating_category_id = ANY (seating_category_profile.seating_category_ids)))));


ALTER TABLE ticket_sales_by_profile OWNER TO jamie;

--
-- Name: ticket_sales_by_profile_lint; Type: VIEW; Schema: public; Owner: jamie
--

CREATE VIEW ticket_sales_by_profile_lint AS
 SELECT ticket_sales_by_profile.date,
    ticket_sales_by_profile.total_sold,
    ticket_sales_by_profile.seating_category_id,
    seating_categories.name,
    ticket_sales_by_profile.category,
    seating_category_profile.period
   FROM ((ticket_sales_by_profile
     JOIN seating_categories ON ((ticket_sales_by_profile.seating_category_id = seating_categories.id)))
     LEFT JOIN seating_category_profile ON ((seating_category_profile.id = ticket_sales_by_profile.seating_category_profile_id)))
  ORDER BY ticket_sales_by_profile.date;


ALTER TABLE ticket_sales_by_profile_lint OWNER TO jamie;

--
-- Name: ticket_sales_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE ticket_sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ticket_sales_id_seq OWNER TO jamie;

--
-- Name: ticket_sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE ticket_sales_id_seq OWNED BY ticket_sales.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
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
    updated_at timestamp without time zone,
    reset_password_sent_at timestamp without time zone
);


ALTER TABLE users OWNER TO jamie;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO jamie;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: verification_states; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE verification_states (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255)
);


ALTER TABLE verification_states OWNER TO jamie;

--
-- Name: verification_states_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE verification_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE verification_states_id_seq OWNER TO jamie;

--
-- Name: verification_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE verification_states_id_seq OWNED BY verification_states.id;


--
-- Name: weekday_ordering; Type: TABLE; Schema: public; Owner: jamie
--

CREATE TABLE weekday_ordering (
    id integer NOT NULL,
    name character varying(255),
    ordering integer
);


ALTER TABLE weekday_ordering OWNER TO jamie;

--
-- Name: weekday_ordering_id_seq; Type: SEQUENCE; Schema: public; Owner: jamie
--

CREATE SEQUENCE weekday_ordering_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weekday_ordering_id_seq OWNER TO jamie;

--
-- Name: weekday_ordering_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jamie
--

ALTER SEQUENCE weekday_ordering_id_seq OWNED BY weekday_ordering.id;


SET search_path = warehouse, pg_catalog;

--
-- Name: performance_dim; Type: TABLE; Schema: warehouse; Owner: jamie
--

CREATE TABLE performance_dim (
    id integer NOT NULL,
    ouverture boolean,
    cloture boolean,
    free_access boolean,
    firstrun boolean,
    firstrun_perfnum integer,
    reprise boolean,
    reprise_perfnum integer,
    newactor character varying(255),
    actorrole character varying(255),
    debut boolean,
    ex_attendance character varying(255),
    ex_representation character varying(255),
    ex_place character varying(255)
);


ALTER TABLE performance_dim OWNER TO jamie;

--
-- Name: play_dim; Type: TABLE; Schema: warehouse; Owner: jamie
--

CREATE TABLE play_dim (
    id integer NOT NULL,
    author character varying(255),
    title character varying(255),
    genre character varying(255),
    acts integer,
    prose_vers character varying(255),
    prologue boolean,
    musique_danse_machine boolean,
    date_de_creation date
);


ALTER TABLE play_dim OWNER TO jamie;

--
-- Name: sales_facts; Type: TABLE; Schema: warehouse; Owner: jamie
--

CREATE TABLE sales_facts (
    date date,
    ticket_sales_id integer,
    sold integer,
    price double precision,
    ravel_1_seating_category_id integer,
    performance_1_id integer,
    play_1_id integer,
    performance_2_id integer,
    play_2_id integer,
    performance_3_id integer,
    play_3_id integer,
    performance_4_id integer,
    play_4_id integer,
    weighting real
);


ALTER TABLE sales_facts OWNER TO jamie;

--
-- Name: seating_category_dim; Type: TABLE; Schema: warehouse; Owner: jamie
--

CREATE TABLE seating_category_dim (
    id integer NOT NULL,
    period text,
    category text
);


ALTER TABLE seating_category_dim OWNER TO jamie;

--
-- Name: warehouse_hash; Type: TABLE; Schema: warehouse; Owner: jamie
--

CREATE TABLE warehouse_hash (
    md5 text,
    created_at timestamp with time zone
);


ALTER TABLE warehouse_hash OWNER TO jamie;

SET search_path = public, pg_catalog;

--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY assignments ALTER COLUMN id SET DEFAULT nextval('assignments_id_seq'::regclass);


--
-- Name: comment_types id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY comment_types ALTER COLUMN id SET DEFAULT nextval('comment_types_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: delayed_jobs id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: lhp_category_assignments id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY lhp_category_assignments ALTER COLUMN id SET DEFAULT nextval('lhp_category_assignments_id_seq'::regclass);


--
-- Name: page_de_gauches id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY page_de_gauches ALTER COLUMN id SET DEFAULT nextval('page_de_gauches_id_seq'::regclass);


--
-- Name: page_text_templates id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY page_text_templates ALTER COLUMN id SET DEFAULT nextval('page_text_templates_id_seq'::regclass);


--
-- Name: participations id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY participations ALTER COLUMN id SET DEFAULT nextval('participations_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


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
-- Name: plays id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY plays ALTER COLUMN id SET DEFAULT nextval('plays_id_seq'::regclass);


--
-- Name: plays _packed_id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY plays ALTER COLUMN _packed_id SET DEFAULT nextval('plays__packed_id_seq'::regclass);


--
-- Name: register_contributors id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_contributors ALTER COLUMN id SET DEFAULT nextval('register_contributors_id_seq'::regclass);


--
-- Name: register_images id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_images ALTER COLUMN id SET DEFAULT nextval('register_images_id_seq'::regclass);


--
-- Name: register_period_seating_categories id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_period_seating_categories ALTER COLUMN id SET DEFAULT nextval('register_type_seating_categories_id_seq'::regclass);


--
-- Name: register_periods id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_periods ALTER COLUMN id SET DEFAULT nextval('register_periods_id_seq'::regclass);


--
-- Name: register_plays id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_plays ALTER COLUMN id SET DEFAULT nextval('register_plays_id_seq'::regclass);


--
-- Name: register_tasks id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_tasks ALTER COLUMN id SET DEFAULT nextval('register_tasks_id_seq'::regclass);


--
-- Name: registers id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY registers ALTER COLUMN id SET DEFAULT nextval('registers_id_seq'::regclass);


--
-- Name: registers _packed_id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY registers ALTER COLUMN _packed_id SET DEFAULT nextval('registers__packed_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: seating_categories id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY seating_categories ALTER COLUMN id SET DEFAULT nextval('seating_categories_id_seq'::regclass);


--
-- Name: seating_category_profile id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY seating_category_profile ALTER COLUMN id SET DEFAULT nextval('seating_category_profile_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: ticket_sales id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY ticket_sales ALTER COLUMN id SET DEFAULT nextval('ticket_sales_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: verification_states id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY verification_states ALTER COLUMN id SET DEFAULT nextval('verification_states_id_seq'::regclass);


--
-- Name: weekday_ordering id; Type: DEFAULT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY weekday_ordering ALTER COLUMN id SET DEFAULT nextval('weekday_ordering_id_seq'::regclass);


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


ALTER TABLE person_agg OWNER TO jamie;

--
-- Name: person_agg_old; Type: MATERIALIZED VIEW; Schema: public; Owner: jamie
--

CREATE MATERIALIZED VIEW person_agg_old AS
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
   FROM (((person p
     LEFT JOIN person_altlabels alt ON ((p.id = alt.person_id)))
     LEFT JOIN person_depictions depict ON ((p.id = depict.person_id)))
     LEFT JOIN person_same_as psa ON ((p.id = psa.person_id)))
  GROUP BY p.id
  WITH NO DATA;


ALTER TABLE person_agg_old OWNER TO jamie;

--
-- Name: active_admin_comments admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: comment_types comment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY comment_types
    ADD CONSTRAINT comment_types_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


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
-- Name: lhp_category_assignments lhp_category_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY lhp_category_assignments
    ADD CONSTRAINT lhp_category_assignments_pkey PRIMARY KEY (id);


--
-- Name: page_de_gauches page_de_gauches_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY page_de_gauches
    ADD CONSTRAINT page_de_gauches_pkey PRIMARY KEY (id);


--
-- Name: page_text_templates page_text_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY page_text_templates
    ADD CONSTRAINT page_text_templates_pkey PRIMARY KEY (id);


--
-- Name: participations participations_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY participations
    ADD CONSTRAINT participations_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


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


--
-- Name: plays plays_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY plays
    ADD CONSTRAINT plays_pkey PRIMARY KEY (id);


--
-- Name: register_contributors register_contributors_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_contributors
    ADD CONSTRAINT register_contributors_pkey PRIMARY KEY (id);


--
-- Name: register_images register_images_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_images
    ADD CONSTRAINT register_images_pkey PRIMARY KEY (id);


--
-- Name: register_periods register_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_periods
    ADD CONSTRAINT register_periods_pkey PRIMARY KEY (id);


--
-- Name: register_plays register_plays_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_plays
    ADD CONSTRAINT register_plays_pkey PRIMARY KEY (id);


--
-- Name: register_tasks register_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_tasks
    ADD CONSTRAINT register_tasks_pkey PRIMARY KEY (id);


--
-- Name: register_period_seating_categories register_type_seating_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY register_period_seating_categories
    ADD CONSTRAINT register_type_seating_categories_pkey PRIMARY KEY (id);


--
-- Name: registers registers_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY registers
    ADD CONSTRAINT registers_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: seating_categories seating_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY seating_categories
    ADD CONSTRAINT seating_categories_pkey PRIMARY KEY (id);


--
-- Name: seating_category_profile seating_category_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY seating_category_profile
    ADD CONSTRAINT seating_category_profile_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: ticket_sales ticket_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY ticket_sales
    ADD CONSTRAINT ticket_sales_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: verification_states verification_states_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY verification_states
    ADD CONSTRAINT verification_states_pkey PRIMARY KEY (id);


--
-- Name: weekday_ordering weekday_ordering_pkey; Type: CONSTRAINT; Schema: public; Owner: jamie
--

ALTER TABLE ONLY weekday_ordering
    ADD CONSTRAINT weekday_ordering_pkey PRIMARY KEY (id);


SET search_path = warehouse, pg_catalog;

--
-- Name: performance_dim performance_dim_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY performance_dim
    ADD CONSTRAINT performance_dim_pkey PRIMARY KEY (id);


--
-- Name: play_dim play_dim_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY play_dim
    ADD CONSTRAINT play_dim_pkey PRIMARY KEY (id);


--
-- Name: seating_category_dim seating_category_dim_pkey; Type: CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY seating_category_dim
    ADD CONSTRAINT seating_category_dim_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: jamie
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: jamie
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_participations_on_person_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_participations_on_person_id ON participations USING btree (person_id);


--
-- Name: index_participations_on_register_play_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_participations_on_register_play_id ON participations USING btree (register_play_id);


--
-- Name: index_register_period_seating_categories_on_register_period_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_register_period_seating_categories_on_register_period_id ON register_period_seating_categories USING btree (register_period_id);


--
-- Name: index_register_period_seating_categories_on_seating_category_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_register_period_seating_categories_on_seating_category_id ON register_period_seating_categories USING btree (seating_category_id);


--
-- Name: index_registers_on_register_period_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_registers_on_register_period_id ON registers USING btree (register_period_id);


--
-- Name: index_registers_on_verification_state_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_registers_on_verification_state_id ON registers USING btree (verification_state_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_ticket_sales_on_register_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_ticket_sales_on_register_id ON ticket_sales USING btree (register_id);


--
-- Name: index_ticket_sales_on_seating_category_id; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX index_ticket_sales_on_seating_category_id ON ticket_sales USING btree (seating_category_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: jamie
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: jamie
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
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
-- Name: play_id_ix; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX play_id_ix ON register_plays USING btree (play_id);


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
-- Name: register_id_ix; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX register_id_ix ON register_plays USING btree (register_id);


--
-- Name: registers_updated_at_ndx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX registers_updated_at_ndx ON registers USING btree (updated_at);


--
-- Name: registers_visualization_ndx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX registers_visualization_ndx ON registers USING btree (date_part('month'::text, date), date_part('day'::text, date));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: jamie
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: validated_plays_genre_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX validated_plays_genre_idx ON validated_plays USING btree (genre);


--
-- Name: validated_plays_id_idx; Type: INDEX; Schema: public; Owner: jamie
--

CREATE INDEX validated_plays_id_idx ON validated_plays USING btree (id);


SET search_path = warehouse, pg_catalog;

--
-- Name: sales_facts_cfrp_season_idx; Type: INDEX; Schema: warehouse; Owner: jamie
--

CREATE INDEX sales_facts_cfrp_season_idx ON sales_facts USING btree (cfrp_season(date));


SET search_path = public, pg_catalog;

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


SET search_path = warehouse, pg_catalog;

--
-- Name: sales_facts sales_facts_performance_1_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_performance_1_id_fkey FOREIGN KEY (performance_1_id) REFERENCES performance_dim(id);


--
-- Name: sales_facts sales_facts_performance_2_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_performance_2_id_fkey FOREIGN KEY (performance_2_id) REFERENCES performance_dim(id);


--
-- Name: sales_facts sales_facts_performance_3_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_performance_3_id_fkey FOREIGN KEY (performance_3_id) REFERENCES performance_dim(id);


--
-- Name: sales_facts sales_facts_performance_4_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_performance_4_id_fkey FOREIGN KEY (performance_4_id) REFERENCES performance_dim(id);


--
-- Name: sales_facts sales_facts_play_1_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_play_1_id_fkey FOREIGN KEY (play_1_id) REFERENCES play_dim(id);


--
-- Name: sales_facts sales_facts_play_2_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_play_2_id_fkey FOREIGN KEY (play_2_id) REFERENCES play_dim(id);


--
-- Name: sales_facts sales_facts_play_3_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_play_3_id_fkey FOREIGN KEY (play_3_id) REFERENCES play_dim(id);


--
-- Name: sales_facts sales_facts_play_4_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_play_4_id_fkey FOREIGN KEY (play_4_id) REFERENCES play_dim(id);


--
-- Name: sales_facts sales_facts_ravel_1_seating_category_id_fkey; Type: FK CONSTRAINT; Schema: warehouse; Owner: jamie
--

ALTER TABLE ONLY sales_facts
    ADD CONSTRAINT sales_facts_ravel_1_seating_category_id_fkey FOREIGN KEY (ravel_1_seating_category_id) REFERENCES seating_category_dim(id);


--
-- PostgreSQL database dump complete
--

