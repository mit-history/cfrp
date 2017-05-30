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

CREATE INDEX lagrange_docs_etype_idx ON lagrange_docs USING btree (etype);
