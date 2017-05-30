CREATE TABLE lagrange_doc_authors (
    doc_id character varying(32),
    aut_id character varying(32)
);

CREATE INDEX lagrange_doc_authors_aut_idx ON lagrange_doc_authors USING btree (aut_id);
CREATE INDEX lagrange_doc_authors_doc_idx ON lagrange_doc_authors USING btree (doc_id);
