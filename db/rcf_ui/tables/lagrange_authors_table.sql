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

CREATE INDEX lagrange_authors_computedform_idx ON lagrange_authors USING btree (computedform);
CREATE INDEX lagrange_authors_firstname1_idx ON lagrange_authors USING btree (firstname1);
CREATE INDEX lagrange_authors_firstname2_idx ON lagrange_authors USING btree (firstname2);
CREATE INDEX lagrange_authors_firstname_idx ON lagrange_authors USING btree (firstname);
CREATE INDEX lagrange_authors_formcompl_idx ON lagrange_authors USING btree (formcompl);
CREATE INDEX lagrange_authors_lastname_idx ON lagrange_authors USING btree (lastname);
CREATE INDEX lagrange_authors_mainform_idx ON lagrange_authors USING btree (mainform);
CREATE INDEX lagrange_authors_mainrole_idx ON lagrange_authors USING btree (mainrole);
