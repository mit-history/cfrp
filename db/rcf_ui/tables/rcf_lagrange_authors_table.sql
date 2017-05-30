CREATE TABLE rcf_lagrange_authors (
    rcf_id integer,
    lagrange_id character varying(16)
);
CREATE INDEX rcf_lagrange_authors_lagrange_idx ON rcf_lagrange_authors USING btree (lagrange_id);
CREATE INDEX rcf_lagrange_authors_rcf_idx ON rcf_lagrange_authors USING btree (rcf_id);
