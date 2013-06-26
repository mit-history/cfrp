--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: registers; Type: TABLE; Schema: public; Owner: cfrp; Tablespace: 
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
    irregular_receipts_name character varying(255)
);


ALTER TABLE public.registers OWNER TO cfrp;

--
-- Name: registers_id_seq; Type: SEQUENCE; Schema: public; Owner: cfrp
--

CREATE SEQUENCE registers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.registers_id_seq OWNER TO cfrp;

--
-- Name: registers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cfrp
--

ALTER SEQUENCE registers_id_seq OWNED BY registers.id;


--
-- Name: registers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cfrp
--

SELECT pg_catalog.setval('registers_id_seq', 15, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cfrp
--

ALTER TABLE registers ALTER COLUMN id SET DEFAULT nextval('registers_id_seq'::regclass);


--
-- Data for Name: registers; Type: TABLE DATA; Schema: public; Owner: cfrp
--

COPY registers (id, date, weekday, season, register_num, payment_notes, page_text, total_receipts_recorded_l, total_receipts_recorded_s, representation, signatory, misc_notes, for_editor_notes, ouverture, cloture, created_at, updated_at, register_image_id, register_period_id, verification_state_id, irregular_receipts_name) FROM stdin;
83	1778-01-22	Jeudi	1777-1778	279		Arrêté par nous Semainiers la Recette de ce jour 22 janvier mil sept cent soixante - dix huit montant à la somme de huit cent sept livres	807	0	279	DesEssarts			f	f	\N	\N	758	2	2	\N
261	1778-03-15	Dimanche	1777-1778	329		Arrêté par nous Semainiers la Recette de ce jour 15 mars mil sept cent soixante - dix huit montant à la somme de deux mille cent soixante livres.	2160	0	329		No signatory.		f	f	\N	\N	810	2	2	\N
709	1779-12-19	Dimanche	1779-1780	244		Arrêté par nous Semainiers la Recette de ce jour 19 Xbre mil sept cent soixante - 79 montant à la somme de dix sept cent quarante sept livres.	1747	0	244	Préville			f	f	\N	\N	1896	2	2	\N
69	1778-01-08	Jeudi	1777-1778	265		Arrêté par nous Semainiers la Recette de ce jour 8 janvier mil sept cent soixante - dix huit montant à la somme de cinq cent six livres	506	0	265	DesEssarts			f	f	\N	\N	743	2	2	\N
76	1778-01-15	Jeudi	1777-1778	272		Arrêté par nous Semainiers la Recette de ce jour 15 janvier mil sept cent soixante - dix huit montant à la somme de sept cent trois livres	703	0	272	DesEssarts			f	f	\N	\N	751	2	2	\N
146	1780-01-27	Jeudi	1779-1780	280		Arrêté par nous Semainiers la Recette de ce jour 27 janvier mil sept cent 80 montant à la somme de trois cent quatre vingt sept livres. 	387	0	280	Sréville 			f	f	\N	\N	1517	2	2	\N
702	1779-12-12	Dimanche	1779-1780	237		Arrêté par nous Semainiers la Recette de ce jour 12 Xbre mil sept cent soixante - 79 montant à la somme de deux mille trois cent soixante une livres dix sols.	2361	10	237	Préville			f	f	\N	\N	1889	2	2	\N
441	1779-05-03	Lundi	1779-1780	22		Arrêté par nous Semainiers la Recette de ce jour 3 may mil sept cent soixante - 79 montant à la somme de deux mille six cent sept livres dix sols.	2607	10	22	Courville			f	f	\N	\N	1635	2	2	\N
323	1779-12-21	Mardi	1779-1780	246		Arrêté par nous Semainiers la Recette de ce jour 21 Xbre mil sept cent 80 montant à la somme de huit cent vint cinq livres.	825	0	246	Préville			f	f	\N	\N	1898	2	2	\N
131	1780-01-12	Mercredi	1779-1780	265		Arrêté par nous Semainiers la Recette de ce jour 12 janvier mil sept cent 80 montant à la somme de onze cent cinquante huit livres.	1158	0	265	Sréville 			f	f	\N	\N	1502	2	2	\N
139	1780-01-20	Jeudi	1779-1780	273		Arrêté par nous Semainiers la Recette de ce jour 20 janvier mil sept cent 80 montant à la somme de six cent soixante deux livres.	662	0	273	Sréville 			f	f	\N	\N	1510	2	2	\N
524	1779-07-21	Mercredi	1779-1780	97		Arrêté par nous Semainiers la Recette de ce jour 21 Juillet mil sept cent soixante - 79 montant à la somme de onze cent trente sept livres.	1137	0	97	Dorival		Play two could have been many different plays. I guessed this one because it was played in the Palais Royale around the right time.  | Also, check play, was opera and never performed at CF.	f	f	\N	\N	1710	2	2	\N
655	1779-11-26	Vendredi	1779-1780	222		Arrêté par nous Semainiers la Recette de ce jour 26 9bre mil sept cent soixante - 79 montant à la somme de sept cent soixante cinq livres dix sols.	765	10	222	Préville		 | Also, check play, was comic opera and never performed at CF.	f	f	\N	\N	1837	2	2	\N
487	1779-06-18	Vendredi	1779-1780	64		Arrêté par nous Semainiers la Recette de ce jour 18 Juin mil sept cent soixante - 79 montant à la somme de cinq cent cinquante cinq livres.	555	0	64	Dorivas		Check play author name ("Nicolas Boindin; Antoine Houdar / Houdard de La Motte / La Mothe")?	f	f	\N	\N	1678	2	2	\N
377	1780-02-27	Dimanche	1779-1780	310		Arrêté par nous Semainiers la Recette de ce jour 27 fev mil sept cent 80 montant à la somme de deux mille quatre vingt dix livres.	2190	0	310	Cournette			f	f	\N	\N	1575	2	2	\N
488	1779-06-19	Samedi	1779-1780	65		Arrêté par nous Semainiers la Recette de ce jour 19 Juin mil sept cent soixante - 79 montant à la somme de deux mille quatre cent vingt huit livres dix sols.	2428	10	65	Dorivas			f	f	\N	\N	1679	2	2	\N
498	1779-06-26	Samedi	1779-1780	72		Arrêté par nous Semainiers la Recette de ce jour 26 Juin mil sept cent soixante - 79 montant à la somme de deux mille quatre cent quarante six livres quinze sols.	2446	15	72	Dorivas			f	f	\N	\N	1685	2	2	\N
562	1779-08-28	Samedi	1779-1780	134		Arrêté par nous Semainiers la Recette de ce jour 28 aout mil sept cent soixante - 79 montant à la somme de sept cent onze livres.	711	0	134	Bellemont			f	f	\N	\N	1748	2	2	\N
656	1779-11-27	Samedi	1779-1780	223		Arrêté par nous Semainiers la Recette de ce jour 27 9bre mil sept cent soixante - 79 montant à la somme de quatorze cent soixante six livres.	1466	0	223	Préville			f	f	\N	\N	1838	2	2	\N
141	1780-01-22	Samedi	1779-1780	275		Arrêté par nous Semainiers la Recette de ce jour 22 janvier mil sept cent 80 montant à la somme de dix huit cent huit livres.	1808	0	275	Sréville 		 | Also, check play, was never performed at CF.	f	f	\N	\N	1512	2	2	\N
169	1779-01-26	Mardi	1778-1779	266		Arrêté par nous Semainiers la Recette de ce jour 26 janvier mil sept cent soixante - dix neuf montant à la somme de quatre cent cinq livres dix sous.	405	10	266	Bouret			f	f	\N	\N	1156	2	2	\N
170	1779-01-27	Mardi	1778-1779	267		Arrêté par nous Semainiers la Recette de ce jour 27 janvier mil sept cent soixante - dix neuf montant à la somme de deux mille vingt une livres quinze sous.	2021	15	267	Bouret		Is "Phedre" a shortening of the longer play title?	f	f	\N	\N	1157	2	2	\N
442	1779-05-04	Mardi	1779-1780	23		Arrêté par nous Semainiers la Recette de ce jour 4 may mil sept cent soixante -79 montant à la somme de quatre cent quarante huit livres.	448	0	23	Courville			f	f	\N	\N	1636	2	2	\N
196	1779-02-17	Mardi	1778-1779	287		Arrêté par nous Semainiers la Recette de ce jour 17 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille cent quatre vingt six livres.	2186	0	287	De Bellecour	Second play is not listed.		f	f	\N	\N	1177	2	2	\N
339	1778-05-12	Mardi	1778-1779	20		Arrêté par nous Semainiers la Recette de ce jour 12 May mil sept cent soixante - dix huit montant à la somme de quatre cent sept livres.	407	0	20	Brizard			f	f	\N	\N	1234	2	2	\N
595	1779-09-28	Mardi	1779-1780	164		Arrêté par nous Semainiers la Recette de ce jour 28 7bre mil sept cent soixante - 79 montant à la somme de trois cent dix neuf livres.	319	0	164	Florence			f	f	\N	\N	1778	2	2	\N
624	1779-10-26	Mardi	1779-1780	192		Arrêté par nous Semainiers la Recette de ce jour 26 8bre mil sept cent soixante - 79 montant à la somme de quatre cent quarante huit livres.	448	0	192	Vanhove			f	f	\N	\N	1806	2	2	\N
630	1779-11-02	Mardi	1779-1780	198		Arrêté par nous Semainiers la Recette de ce jour 2 9bre mil sept cent soixante - 79 montant à la somme de onze cent quarante sept livres.	1147	0	198	Préville		 | Also, check play, was opera and never performed at CF.	f	f	\N	\N	1812	2	2	\N
136	1780-01-17	Lundi	1779-1780	270		Arrêté par nous Semainiers la Recette de ce jour 17 janvier mil sept cent  montant à la somme de douze cent quatre vingt dix sept livres.	1297	0	270	Sréville 			f	f	\N	\N	1507	2	2	\N
338	1778-05-11	Lundi	1778-1779	19		Arrêté par nous Semainiers la Recette de ce jour 11 May mil sept cent soixante - dix huit montant à la somme de deux mille cinq cent soixante seize livres dix sous.	2576	10	19	Brizard			f	f	\N	\N	1233	2	2	\N
426	1779-04-19	Lundi	1779-1780	8		Arrêté par nous Semainiers la Recette de ce jour 9 avril mil sept cent soixante - dix neuf montant à la somme de dix sept cent onze livres.	1711	0	8	Dazincourt			f	f	\N	\N	1621	2	2	\N
434	1779-04-26	Lundi	1779-1780	15		Arrêté par nous Semainiers la Recette de ce jour 26 avril mil sept cent soixante -dix neuf montant à la somme de deux mille deux cent soixante une livres quinze sols.	2261	15	15	Dazincourt			f	f	\N	\N	1628	2	2	\N
359	1780-02-10	Jeudi	1779-1780	293		Arrêté par nous Semainiers la Recette de ce jour 10 fev mil sept cent 80 montant à la somme de quatre cent quatre vingt dix sept livres.	497	0	293	Cournette			f	f	\N	\N	1555	2	2	\N
374	1780-02-24	Jeudi	1779-1780	307		Arrêté par nous Semainiers la Recette de ce jour 24 fev mil sept cent 80 montant à la somme de huit cent sept livres.	807	0	307	Cournette			f	f	\N	\N	1572	2	2	\N
115	1780-05-01	Mercredi	1779-1780	258		Arrêté par nous Semainiers la Recette de ce jour 5 janvier mil sept cent 80 montant à la somme de seize cent une livres. 	1610	0	258	Sréville		Can't read signatory	f	f	\N	\N	1495	2	2	\N
65	1778-01-04	Dimanche	1777-1778	261		Arrêté par nous Semainiers la Recette de ce jour 4 janvier mil sept cent soixante - dix huit montant à la somme de dix sept cent quatre vignt onze livres	1791	0	261	DesEssarts		Why did the form automatically calculate the wrong tally?	f	f	\N	\N	739	2	2	\N
72	1778-01-11	Dimanche	1777-1778	268		Arrêté par nous Semainiers la Recette de ce jour 11 janvier mil sept cent soixante - dix huit montant à la somme de dix neuf cent onze livres quinze sols	1911	15	268	DesEssarts			f	f	\N	\N	747	2	2	\N
79	1778-01-18	Dimanche	1777-1778	275		Arrêté par nous Semainiers la Recette de ce jour 18 janvier mil sept cent soixante - dix huit montant à la somme de seize cent six livres	1606	0	275	DesEssarts			f	f	\N	\N	754	2	2	\N
86	1778-01-25	Dimanche	1777-1778	282		Arrêté par nous Semainiers la Recette de ce jour 25 janvier mil sept cent soixante - dix huit montant à la somme de deux mille cinq cent soixante neuf livres dix sols	2569	10	282	DesEssarts			f	f	\N	\N	761	2	2	\N
71	1778-01-10	Samedi	1777-1778	267		Arrêté par nous Semainiers la Recette de ce jour 10 janvier mil sept cent soixante - dix huit montant à la somme de deux mille soixante cinq livres dix sols	2065	10	267	DesEssarts			f	f	\N	\N	746	2	2	\N
78	1778-01-17	Samedi	1777-1778	274		Arrêté par nous Semainiers la Recette de ce jour 17 janvier mil sept cent soixante - dix huit montant à la somme de deux mille quatre cent treize livres dix sols	2413	10	274	DesEssarts			f	f	\N	\N	753	2	2	\N
85	1778-01-24	Samedi	1777-1778	281		Arrêté par nous Semainiers la Recette de ce jour 24 janvier mil sept cent soixante - dix huit montant à la somme de deux mille sept cent quarante trois livres dix sols	2743	10	281	DesEssarts			f	f	\N	\N	760	2	2	\N
67	1778-01-06	Mardi	1777-1778	263		Arrêté par nous Semainiers la Recette de ce jour 6 janvier mil sept cent soixante - dix huit montant à la somme de deux mille cent quatre vingt onze livres	2191	0	263	DesEssarts		There was only one play this evening, Le Bourgeois gentilhomme.  But we do not have a way to indicate no second performance, so the default entry for the second play is wrong.	f	f	\N	\N	741	2	2	\N
74	1778-01-13	Mardi	1777-1778	270		Arrêté par nous Semainiers la Recette de ce jour 13 janvier mil sept cent soixante - dix huit montant à la somme de quatre cent quatre vingt seot livres	487	0	270	DesEssarts			f	f	\N	\N	749	2	2	\N
81	1778-01-20	Mardi	1777-1778	277	24 billets de parterre pour la police 24 livres	Arrêté par nous Semainiers la Recette de ce jour 20 janvier mil sept cent soixante - dix huit montant à la somme de six cent huit livres	608	0	277			Second play could be Tuteur dupé de Cailhava - check with Golder?	f	f	\N	\N	756	2	2	\N
66	1778-01-05	Lundi	1777-1778	262		Arrêté par nous Semainiers la Recette de ce jour 5 janvier mil sept cent soixante - dix huit montant à la somme de quinze cent trente six livres dix sols	1536	10	262	DesEssarts			f	f	\N	\N	740	2	2	\N
73	1778-01-12	Lundi	1777-1778	269	P. 4 places de M Preville dues de la veille 8 livres	Arrêté par nous Semainiers la Recette de ce jour 12 janvier mil sept cent soixante - dix huit montant à la somme de dix neuf cent vignt livres et quinze sols	1920	15	269	DesEssarts		Note irregular payment - need to have way to integrate this amount into tally.\r\nNeed to verify transcription - need way to magnify .jpg of register page.	f	f	\N	\N	748	2	2	\N
80	1778-01-19	Lundi	1777-1778	276		Arrêté par nous Semainiers la Recette de ce jour 19 janvier mil sept cent soixante - dix huit montant à la somme de deux mille six cent cinquante un livres dix sols	2651	10	276	DesEssarts			f	f	\N	\N	755	2	2	\N
87	1778-01-26	Lundi	1777-1778	283		Arrêté par nous Semainiers la Recette de ce jour 26 janvier mil sept cent soixante - dix huit montant à la somme de douze cent quatre vingt dix neuf livres	1299	0	283	DesEssarts			f	f	\N	\N	762	2	2	\N
68	1778-01-07	Mercredi	1777-1778	264		Arrêté par nous Semainiers la Recette de ce jour 7 janvier mil sept cent soixante - dix huit montant à la somme de quatorze cent vignt huit livres dix sols	1428	10	264	DesEssarts			f	f	\N	\N	742	2	2	\N
75	1778-01-14	Mercredi	1777-1778	271		Arrêté par nous Semainiers la Recette de ce jour 14 janvier mil sept cent soixante - dix huit montant à la somme de deux mille trois cent quatre livres dix sols	2304	10	271	DesEssarts			f	f	\N	\N	750	2	2	\N
82	1778-01-21	Mercredi	1777-1778	278		Arrêté par nous Semainiers la Recette de ce jour 21 janvier mil sept cent soixante - dix huit montant à la somme de deux mille quatre vingt neuf livres	2089	0	278	DesEssarts			f	f	\N	\N	757	2	2	\N
148	1780-01-29	Samedi	1779-1780	282		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	0	0	282				f	f	\N	\N	1519	2	2	\N
95	1779-01-03	Dimanche	1778-1779	244		Arrêté par nous Semainiers la Recette de ce jour 3 janvier mil sept cent soixante - dix neuf montant à la somme de treize cent quatre vingt cinq livres.	1385	0	244	Bouret	Second play is not listed.		f	f	\N	\N	1133	2	2	\N
102	1779-01-10	Dimanche	1778-1779	251		Arrêté par nous Semainiers la Recette de ce jour 10 janvier mil sept cent soixante - dix neuf montant à la somme de dix neuf cent soixante deux livres.	1962	0	251	Bouret	Second play not listed.		f	f	\N	\N	1140	2	2	\N
110	1780-02-01	Dimanche	1779-1780	255		Arrêté par nous Semainiers la Recette de ce jour 2ère janvier mil sept cent 80 montant à la somme de douze cent quarante sept livres. 	1247	0	255	Seville			f	f	\N	\N	1490	2	2	\N
94	1779-01-02	Samedi	1778-1779	243		Arrêté par nous Semainiers la Recette de ce jour 2 janvier mil sept cent soixante - dix neuf montant à la somme de deux mille cent vingt deux livres dix sous.	2122	10	243	Bouret	First play should be Oedipe Chez Admette, which is not there.  Can't decipher the second play.		f	f	\N	\N	1132	2	2	\N
101	1779-01-09	Samedi	1778-1779	250		Arrêté par nous Semainiers la Recette de ce jour 9 janvier mil sept cent soixante - dix neuf montant à la somme de dix neuf cent soixante huit livres dix sous.	1968	10	250	Bouret	First play should be Oedipe Chez Admette.		f	f	\N	\N	1139	2	2	\N
88	1778-01-27	Mardi	1777-1778	284		Arrêté par nous Semainiers la Recette de ce jour 27 janvier mil sept cent soixante - dix huit montant à la somme de mille trente quatre livres dix sols	1034	10	284	DesEssarts			f	f	\N	\N	763	2	2	\N
97	1779-01-05	Mardi	1778-1779	246		Arrêté par nous Semainiers la Recette de ce jour 5 janvier mil sept cent soixante - dix neuf montant à la somme de trois cent trente sept livres.	337	0	246	Bouret			f	f	\N	\N	1135	2	2	\N
114	1780-04-01	Mardi	1779-1780	257		Arrêté par nous Semainiers la Recette de ce jour 4 janvier mil sept cent 80 montant à la somme de trois cent soixante deux livres dix sols. 	362	10	257	Scésville		Can't read signatory.	f	f	\N	\N	1494	2	2	\N
96	1779-01-04	Lundi	1778-1779	245		Arrêté par nous Semainiers la Recette de ce jour 4 janvier mil sept cent soixante - dix neuf montant à la somme de dix huit cent vingt trois livres quinze sous.	1823	15	245	Bouret	First play is not present, should be Oedipe Chez Admette.		f	f	\N	\N	1134	2	2	\N
103	1779-01-11	Lundi	1778-1779	252		Arrêté par nous Semainiers la Recette de ce jour 11 janvier mil sept cent soixante - dix neuf montant à la somme de dix sept cent soixante douze livres dix sous.	1712	10	252	Bouret			f	f	\N	\N	1141	2	2	\N
107	1779-01-16	Lundi	1778-1779	256		Arrêté par nous Semainiers la Recette de ce jour 16 janvier mil sept cent soixante - dix neuf montant à la somme de deux mille cent dix huit divres dix sous.	2118	10	256	Bouret	First play should be Oedipe Chez Admette.		f	f	\N	\N	1145	2	2	\N
90	1778-01-29	Jeudi	1777-1778	286		Arrêté par nous Semainiers la Recette de ce jour 29 janvier mil sept cent soixante - dix huit montant à la somme de cinq cent soixante quatorze livres	574	0	286	DesEssarts			f	f	\N	\N	765	2	2	\N
105	1779-01-14	Jeudi	1778-1779	254		Arrêté par nous Semainiers la Recette de ce jour 14 janvier mil sept cent soixante - dix neuf montant à la somme de quatre cent trente neuf.	439	0	254	Bouret			f	f	\N	\N	1143	2	2	\N
116	1780-06-01	Jeudi	1779-1780	259		Arrêté par nous Semainiers la Recette de ce jour 6 jan mil sept cent 80 montant à la somme de dix-neuf cent quatre vingt livres quinze sols.	1980	15	259	Scréville		Unsure of signatory name.	f	f	\N	\N	1496	2	2	\N
89	1778-01-28	Mercredi	1777-1778	285		Arrêté par nous Semainiers la Recette de ce jour 28 janvier mil sept cent soixante - dix huit montant à la somme de seize cent quatre vingt dix livres quinze sols	1690	15	285	DesEssarts			f	f	\N	\N	764	2	2	\N
98	1779-01-06	Mercredi	1778-1779	247		Arrêté par nous Semainiers la Recette de ce jour 6 janvier mil sept cent soixante - dix neuf montant à la somme de dix sept cent quatre vingt quatorze livres.	1794	0	247	Bouret			f	f	\N	\N	1136	2	2	\N
104	1779-01-13	Mercredi	1778-1779	253		Arrêté par nous Semainiers la Recette de ce jour 13 janvier mil sept cent soixante - dix neuf montant à la somme de douze cent dix livres.	1210	0	253	Bouret			f	f	\N	\N	1142	2	2	\N
119	1780-01-09	Dimanche	1779-1780	262		Arrêté par nous Semainiers la Recette de ce jour 9 janvier mil sept cent 80 montant à la somme de treize cent soixante soixante sept livres.	1367	0	262	Sréville 		Can't read singnatory.	f	f	\N	\N	1499	2	2	\N
142	1780-01-23	Dimanche	1779-1780	276		Arrêté par nous Semainiers la Recette de ce jour 23 janvier mil sept cent 80 montant à la somme de quatorze cent quatre vingt treize livres. 	1493	0	276	Sréville 		Can't read first title	f	f	\N	\N	1513	2	2	\N
150	1780-01-30	Dimanche	1779-1780	283		Arrêté par nous Semainiers la Recette de ce jour 30 janvier mil sept cent 80 montant à la somme de seize cent soixante neuf livres cinq sols. 	1669	5	283	Sréville 		Can't read first play title	f	f	\N	\N	1520	2	2	\N
134	1780-01-15	Samedi	1779-1780	268		Arrêté par nous Semainiers la Recette de ce jour 15 janvier mil sept cent 80 montant à la somme de dix-sept cent une livres.	1701	0	268	Sréville 			f	f	\N	\N	1505	2	2	\N
130	1780-01-11	Mardi	1779-1780	264		Arrêté par nous Semainiers la Recette de ce jour 11 janvier mil sept cent 80 montant à la somme de quatre cent six livres.	406	0	264	Sréville 			f	f	\N	\N	1501	2	2	\N
137	1780-01-18	Mardi	1779-1780	271		Arrêté par nous Semainiers la Recette de ce jour 18 janvier mil sept cent 80 montant à la somme de cinq cent vingt quatre.	0	0	271	Sréville 			f	f	\N	\N	1508	2	2	\N
144	1780-01-25	Mardi	1779-1780	278		Arrêté par nous Semainiers la Recette de ce jour 25 janvier mil sept cent 80 montant à la somme de trois cent trente six livres.	336	0	278	Sréville 			f	f	\N	\N	1515	2	2	\N
132	1780-01-13	Jeudi	1779-1780	266		Arrêté par nous Semainiers la Recette de ce jour 13 janvier mil sept cent 80 montant à la somme de six cent cinquante-six livres.	656	0	266	Sréville 			f	f	\N	\N	1503	2	2	\N
138	1780-01-19	Mercredi	1779-1780	272		Arrêté par nous Semainiers la Recette de ce jour 19 janvier mil sept cent 80 montant à la somme de neuf cent quatre vingt dix sept livres.	977	0	272	Sréville 		For second play it just says "Le Tuteur" but that isn't an option. 	f	f	\N	\N	1509	2	2	\N
145	1780-01-26	Mercredi	1779-1780	279		Arrêté par nous Semainiers la Recette de ce jour 26 janvier mil sept cent 80 montant à la somme de onze cent trente quatre livres.	1134	0	279	Sréville 			f	f	\N	\N	1516	2	2	\N
159	1780-02-06	Dimanche	1779-1780	289		Arrêté par nous Semainiers la Recette de ce jour 6 février mil sept cent 80 montant à la somme de seize cent onze livres dix sous.	1611	10	289	Courette	Wrong things recorded secondes loges and totes don't match up............	Can't read first title  or second title	f	f	\N	\N	1527	2	2	\N
158	1779-01-17	Dimanche	1778-1779	257		Arrêté par nous Semainiers la Recette de ce jour 17 janvier mil sept cent soixante - dix neuf montant à la somme de dix sept cent soixante onze livres.	1771	0	257	Bouret	Only one play was performed.		f	f	\N	\N	1146	2	2	\N
174	1779-01-31	Dimanche	1778-1779	271		Arrêté par nous Semainiers la Recette de ce jour 31 janvier mil sept cent soixante - dix neuf montant à la somme de quatorze cent quarante trois livres.	1443	0	271	Bouret			f	f	\N	\N	1161	2	2	\N
157	1780-02-05	Samedi	1779-1780	288		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	0	0	288			Can't find second play title.	f	f	\N	\N	1526	2	2	\N
173	1779-01-30	Samedi	1778-1779	270		Arrêté par nous Semainiers la Recette de ce jour 30 janvier mil sept cent soixante - dix neuf montant à la somme de deux mille deux cent quatre livres dix sous.	2204	10	270	Bouret	First play is Oedipe chez Amette.		f	f	\N	\N	1160	2	2	\N
152	1780-02-01	Mardi	1779-1780	285		Arrêté par nous Semainiers la Recette de ce jour 1 février mil sept cent 80 montant à la somme de seize cent trente quatre livres quinze sols.	1634	15	285	Courette		Not sure of signatory name	f	f	\N	\N	1522	2	2	\N
162	1779-01-19	Mardi	1778-1779	259		Arrêté par nous Semainiers la Recette de ce jour 19 janvier mil sept cent soixante - dix neuf montant à la somme de quatre cent vingt huit livres.	428	0	259	Bouret			f	f	\N	\N	1148	2	2	\N
160	1779-01-18	Lundi	1778-1779	258		Arrêté par nous Semainiers la Recette de ce jour 18 janvier mil sept cent soixante - dix neuf montant à la somme de dix sept cent trente huit livres quinze sous.	1738	15	258	Bouret	First play should be Oedipe Chez Admette.		f	f	\N	\N	1147	2	2	\N
161	1780-02-07	Lundi	1779-1780	290		Arrêté par nous Semainiers la Recette de ce jour 7 février mil sept cent 80 montant à la somme de deux mille quatre cent six livres. 	2406	0	290	Courette			f	f	\N	\N	1528	2	2	\N
165	1779-01-22	Lundi	1778-1779	262		Arrêté par nous Semainiers la Recette de ce jour 22 janvier mil sept cent soixante - dix neuf montant à la somme de dix sept cent vingt deux livres.	1722	0	262	Bouret	Only one play performed.		f	f	\N	\N	1152	2	2	\N
167	1779-01-24	Lundi	1778-1779	264	Incorrect addition.	Arrêté par nous Semainiers la Recette de ce jour 24 janvier mil sept cent soixante - dix huit montant à la somme de dix sept cent seize livres.	1716	0	264	Bouret			f	f	\N	\N	1154	2	2	\N
168	1779-01-25	Lundi	1778-1779	265		Arrêté par nous Semainiers la Recette de ce jour 25 janvier mil sept cent soixante - dix huit montant à la somme de dix sept cent vingt neuf livres quinze sous.	1729	15	265	Bouret	First play is Oedipe Chez Admette.  Second is not listed.		f	f	\N	\N	1155	2	2	\N
154	1780-02-03	Jeudi	1779-1780	286		Arrêté par nous Semainiers la Recette de ce jour 3 fev mil sept cent 80 montant à la somme de onze cent trente cinq livres.	1135	0	286	Courette		can't read title on second play	f	f	\N	\N	1524	2	2	\N
164	1779-01-21	Jeudi	1778-1779	261		Arrêté par nous Semainiers la Recette de ce jour 21 janvier mil sept cent soixante - dix huit montant à la somme de quatre cent six livres.	406	0	261	Bouret			f	f	\N	\N	1151	2	2	\N
171	1779-01-28	Jeudi	1778-1779	268		Arrêté par nous Semainiers la Recette de ce jour 28 janvier mil sept cent soixante - dix neuf montant à la somme de cinq cent quatre vingt cinq livres.	585	0	268	Bouret			f	f	\N	\N	1158	2	2	\N
177	1779-02-04	Jeudi	1778-1779	274		Arrêté par nous Semainiers la Recette de ce jour 4 fevrier mil sept cent soixante - dix neuf montant à la somme de sept cent soixante trois livres.	763	0	274	De Bellesour			f	f	\N	\N	1164	2	2	\N
155	1780-02-09	Mercredi	1779-1780	292		Arrêté par nous Semainiers la Recette de ce jour 9 fev mil sept cent 80 montant à la somme de dix neuf cent cinquante et un livres.	1951	0	292	Courenette?		unsure of first play title\r\nUnsure of signatory name	f	f	\N	\N	1531	2	2	\N
163	1779-01-20	Mercredi	1778-1779	260		Arrêté par nous Semainiers la Recette de ce jour 20 janvier mil sept cent soixante - dix neuf montant à la somme de cent quatre vingt dix huit livres.	2198	0	260	Bouret	First play is not listed.		f	f	\N	\N	1150	2	2	\N
180	1779-02-07	Dimanche	1778-1779	277	Number is written wrong in the page text.	Arrêté par nous Semainiers la Recette de ce jour 7 fevrier mil sept cent soixante - dix neuf montant à la somme de dix sept cent trente huit livres.	1741	15	277	De Bellesour	Second play is not listed.		f	f	\N	\N	1167	2	2	\N
187	1778-02-01	Dimanche	1777-1778	289		Arrêté par nous Semainiers la Recette de ce jour 1er février mil sept cent soixante - dix huit montant à la somme de deux mille trois cent soixante quatorze livres dix sols	2374	10	289	DesEssarts		No second play this evening.	f	f	\N	\N	769	2	2	\N
192	1779-02-14	Dimanche	1778-1779	284		Arrêté par nous Semainiers la Recette de ce jour 14 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille cinq cent cinquante sept livres dix sous.	2557	10	284	De Bellecour	Second play is not listed.		f	f	\N	\N	1174	2	2	\N
212	1778-02-08	Dimanche	1777-1778	295		Arrêté par nous Semainiers la Recette de ce jour 8 février mil sept cent soixante - dix huit montant à la somme de dix huit cent soixante quinze livres	1875	0	295	Des Essarts			f	f	\N	\N	775	2	2	\N
200	1779-02-21	Dimanche	1778-1779	291		Arrêté par nous Semainiers la Recette de ce jour 21 fevrier mil sept cent soixante - dix neuf montant à la somme de dix neuf cent vingt neuf livres.	1929	0	291	De Bellecour	Only one play.		f	f	\N	\N	1182	2	2	\N
250	1778-03-04	Mercredi	1777-1778	318		Arrêté par nous Semainiers la Recette de ce jour 4 mars mil sept cent soixante - dix huit montant à la somme de deux mille huit cent soixante douze livres dix sols	2872	10	318		No signatory this day.		f	f	\N	\N	799	2	2	\N
179	1779-02-06	Samedi	1778-1779	276		Arrêté par nous Semainiers la Recette de ce jour 6 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille sept cent cinquante huit livres dix sous.	2758	10	276	De Bellesour	First play is Oedipe Chez Admette.  Second is something that is not listed.		f	f	\N	\N	1166	2	2	\N
186	1778-01-31	Samedi	1777-1778	288		Arrêté par nous Semainiers la Recette de ce jour 31 janvier mil sept cent soixante - dix huit montant à la somme de deux mille deux cent quatre vingt sept livres dix sols	2287	10	288	DesEssarts			f	f	\N	\N	768	2	2	\N
182	1779-02-09	Mardi	1778-1779	279	Addition problem.	Arrêté par nous Semainiers la Recette de ce jour 9 fevrier mil sept cent soixante - dix neuf montant à la somme de quatre cent trent quatre livres.	434	0	279	De Bellecour	Second play is not listed.		f	f	\N	\N	1169	2	2	\N
188	1778-02-03	Mardi	1777-1778	290		Arrêté par nous Semainiers la Recette de ce jour 3 février mil sept cent soixante - dix huit montant à la somme de huit cent quatre vingt dix neuf livres dix sols	899	10	290	DesEssarts			f	f	\N	\N	770	2	2	\N
190	1780-02-08	Mardi	1779-1780	291		Arrêté par nous Semainiers la Recette de ce jour 8 février mil sept cent 80 montant à la somme de deux mille cinq cent cinquante sept livres dix sols.	2557	10	291	Courrette		no option to indicate "No second play"\r\n\r\nsignatory name?	f	f	\N	\N	1529	2	2	\N
195	1779-02-16	Mardi	1778-1779	286		Arrêté par nous Semainiers la Recette de ce jour 16 fevrier mil sept cent soixante - dix neuf montant à la somme de duex mille quatre vingt dix livres dix sous.	2090	10	286	De Bellecour	Only one play.		f	f	\N	\N	1176	2	2	\N
181	1779-02-08	Lundi	1778-1779	278		Arrêté par nous Semainiers la Recette de ce jour 8 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille sept cent trente trois livres dix sous.	2733	10	278	De Bellecour	Only play is Les Muses Rivales		f	f	\N	\N	1168	2	2	\N
194	1779-02-15	Lundi	1778-1779	285		Arrêté par nous Semainiers la Recette de ce jour 15 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille cinq cent dix livres dix sous.	2510	10	285	De Bellecour	First play is Muses Rivales.  Second is not listed.		f	f	\N	\N	1175	2	2	\N
184	1779-02-11	Jeudi	1778-1779	281	Addition problem.	Arrêté par nous Semainiers la Recette de ce jour 1 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille cent douze livres quinze sous.	2112	15	281	De Bellecour	Only one play.		f	f	\N	\N	1171	2	2	\N
193	1778-02-05	Jeudi	1777-1778	292		Arrêté par nous Semainiers la Recette de ce jour 5 février mil sept cent soixante - dix huit montant à la somme de cinq cent vingt quatre livres	524	0	292	Des Essarts			f	f	\N	\N	772	2	2	\N
197	1779-02-18	Jeudi	1778-1779	288		Arrêté par nous Semainiers la Recette de ce jour 18 fevrier mil sept cent soixante - dix neuf montant à la somme de sept cent soixante dix huit livres.	778	0	288	De Bellecour			f	f	\N	\N	1178	2	2	\N
183	1779-02-10	Mercredi	1778-1779	280		Arrêté par nous Semainiers la Recette de ce jour 10 fevrier mil sept cent soixante - dix neuf montant à la somme de deux miille cinq cent deux livres dix sous.	2502	10	280	De Bellecour	Muses Rivales		f	f	\N	\N	1170	2	2	\N
189	1778-02-04	Mercredi	1777-1778	291		Arrêté par nous Semainiers la Recette de ce jour 4 février mil sept cent soixante - dix-huit montant à la somme de dix sept cent dix sept livres	1717	0	291	DesEssarts			f	f	\N	\N	771	2	2	\N
203	1779-02-24	Mercredi	1778-1779	294		Arrêté par nous Semainiers la Recette de ce jour 24 fevrier mil sept cent soixante - dix neuf montant à la somme de quinze cent quinze livres quinze sous.	1515	15	294	De Bellecour			f	f	\N	\N	1185	2	2	\N
210	1779-02-28	Dimanche	1778-1779	298		Arrêté par nous Semainiers la Recette de ce jour 28 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille deux cent trente neuf livres dix sous.	2239	10	298	De Bellecour	New actor/actress, can't read.		f	f	\N	\N	1189	2	2	\N
226	1779-03-07	Dimanche	1778-1779	305		Arrêté par nous Semainiers la Recette de ce jour 7 Mars mil sept cent soixante - dix neuf montant à la somme de deux mille quatre vingt huit livres.	2088	0	305			Cannot read actor name, role or signatory.	f	f	\N	\N	1196	2	2	\N
207	1779-02-27	Samedi	1778-1779	297		Arrêté par nous Semainiers la Recette de ce jour 27 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille quatre cent soixante onze livres dix sous.	2471	10	297	De Bellecour	Muses Rivales is first play.  New actress/actor (can't read).		f	f	\N	\N	1188	2	2	\N
211	1778-02-07	Samedi	1777-1778	294		Arrêté par nous Semainiers la Recette de ce jour 7 février mil sept cent soixante - dix huit montant à la somme de dix neuf cent soixante sept livres	1967	0	294	Des Essarts			f	f	\N	\N	774	2	2	\N
218	1778-02-14	Samedi	1777-1778	300		Arrêté par nous Semainiers la Recette de ce jour 14 février mil sept cent soixante - dix huit montant à la somme de dix sept cent soixante dix sept livres dix sols	1777	10	300	Des Essarts			f	f	\N	\N	781	2	2	\N
221	1779-03-02	Mardi	1778-1779	300		Arrêté par nous Semainiers la Recette de ce jour 2 Mars mil sept cent soixante - dix neuf montant à la somme de cinq cent quatre vingt une livres.	581	0	300			Cannot make out signatory.	f	f	\N	\N	1191	2	2	\N
228	1779-03-09	Mardi	1778-1779	307		Arrêté par nous Semainiers la Recette de ce jour 9 mars mil sept cent soixante - dix neuf montant à la somme de six cent trent trois livres.	633	0	307			Cannot make out actor names, roles, or signatory.	f	f	\N	\N	1198	2	2	\N
213	1778-02-09	Lundi	1777-1778	296		Arrêté par nous Semainiers la Recette de ce jour 9 février mil sept cent soixante - dix huit montant à la somme de seize cent quatorze livres quinze sols	1614	15	296	Des Essarts			f	f	\N	\N	776	2	2	\N
257	1778-03-11	Mercredi	1777-1778	325		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	776	0	325		No bottom entry, no signatory.		f	f	\N	\N	806	2	2	\N
204	1779-02-25	Jeudi	1778-1779	295		Arrêté par nous Semainiers la Recette de ce jour 25 fevrier mil sept cent soixante - dix neuf montant à la somme de six cent vingt sept livres.	627	0	295	De Bellecour			f	f	\N	\N	1186	2	2	\N
215	1778-02-12	Jeudi	1777-1778	298	105 billets de parterre de la Police  105 livres	Arrêté par nous Semainiers la Recette de ce jour 12 février mil sept cent soixante - dix huit montant à la somme de cinq cent quatrevingt trois livres	583	0	298	Des Essarts		Mistake in parterre receipt figure, in addition to extra sale of parterre tix	f	f	\N	\N	778	2	2	\N
223	1779-03-04	Jeudi	1778-1779	302		Arrêté par nous Semainiers la Recette de ce jour 4 Mars mil sept cent soixante - dix neuf montant à la somme de cinq cent vingt neuf livres.	529	0	302			Cannot make out signatory.	f	f	\N	\N	1193	2	2	\N
237	1778-02-19	Jeudi	1777-1778	305		Arrêté par nous Semainiers la Recette de ce jour 19 février mil sept cent soixante - dix huit montant à la somme de seot cent vingt neuf livres	729	0	305	DesEssarts			f	f	\N	\N	786	2	2	\N
214	1778-02-11	Mercredi	1777-1778	297		Arrêté par nous Semainiers la Recette de ce jour 11 février mil sept cent soixante - dix huit montant à la somme de deux mille neuf livres	2009	0	297	Des Essarts			f	f	\N	\N	777	2	2	\N
233	1778-02-15	Dimanche	1777-1778	301		Arrêté par nous Semainiers la Recette de ce jour 15 février mil sept cent soixante - dix huit montant à la somme de deux mille cent trente cinq livres dix sols	2135	10	301	DesEssarts			f	f	\N	\N	782	2	2	\N
240	1778-02-22	Dimanche	1777-1778	308		Arrêté par nous Semainiers la Recette de ce jour 22 février mil sept cent soixante - dix huit montant à la somme de deux mille cent soixante cinq livres dix sols	2165	10	308	DesEssarts			f	f	\N	\N	789	2	2	\N
247	1778-03-01	Dimanche	1777-1778	315		Arrêté par nous Semainiers la Recette de ce jour 1er mars mil sept cent soixante - dix huit montant à la somme de deux mille huit cent soixante trois livres dix sols	2863	10	315		No signatory this day.		f	f	\N	\N	796	2	2	\N
254	1778-03-08	Dimanche	1777-1778	322		Arrêté par nous Semainiers la Recette de ce jour 8 mars mil sept cent soixante - dix huit montant à la somme de deux mille cent soizante huit livres	2168	0	322		No signatory.		f	f	\N	\N	803	2	2	\N
232	1779-03-13	Samedi	1778-1779	311		Arrêté par nous Semainiers la Recette de ce jour 13 mars mil sept cent soixante - dix neuf montant à la somme de deux mille six cent soixante sept livres dix sous.	2667	10	311	Courville		cannot make out signatory and actor name/role.	f	f	\N	\N	1202	2	2	\N
239	1778-02-21	Samedi	1777-1778	307		Arrêté par nous Semainiers la Recette de ce jour 21 février mil sept cent soixante - dix huit montant à la somme de deux mille sept cent cinquante six livres	2756	0	307	DesEssarts			f	f	\N	\N	788	2	2	\N
246	1778-02-28	Samedi	1777-1778	314		Arrêté par nous Semainiers la Recette de ce jour 28 février mil sept cent soixante - dix huit montant à la somme de deux mille cent dix huit livres quinze sols	2118	15	314	DesEssarts			f	f	\N	\N	795	2	2	\N
253	1778-03-07	Samedi	1777-1778	321		Arrêté par nous Semainiers la Recette de ce jour 7 mars mil sept cent soixante - dix huit montant à la somme de douze cent quarante sept livres quinze sols	1247	15	321		No signatory this day.		f	f	\N	\N	802	2	2	\N
235	1778-02-17	Mardi	1777-1778	303		Arrêté par nous Semainiers la Recette de ce jour 17 février mil sept cent soixante - dix huit montant à la somme de quatre cent cinquante deux livres dix sols	452	10	303	DesEssarts			f	f	\N	\N	784	2	2	\N
242	1778-02-24	Mardi	1777-1778	310		Arrêté par nous Semainiers la Recette de ce jour 24 février mil sept cent soixante - dix huit montant à la somme de cinq cent vingt trois livres dix sols	523	10	310	DesEssarts			f	f	\N	\N	791	2	2	\N
249	1778-03-03	Mardi	1777-1778	317		Arrêté par nous Semainiers la Recette de ce jour 3 mars mil sept cent soixante - dix huit montant à la somme de deux mille quatre cent quatre vingt quatre livres dix sols	2484	10	317		No signatory this day.		f	f	\N	\N	798	2	2	\N
256	1778-03-10	Mardi	1777-1778	324		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	805	10	324		No entry at bottom of page, no signatory.		f	f	\N	\N	805	2	2	\N
220	1779-03-01	Lundi	1778-1779	299		Arrêté par nous Semainiers la Recette de ce jour 1er Mars mil sept cent soixante - dix neuf montant à la somme de deux mille sept cent quinze livres dix sous.	2715	10	299	Courville			f	f	\N	\N	1190	2	2	\N
234	1778-02-16	Lundi	1777-1778	302	No ticket sales listed on page.  All profits to nephew of the Corneille brothers, but no box office take listed.	Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	0	0	302		Représentation au proffit du petit neveu de Pierre et Thomas Corneille		f	f	\N	\N	783	2	2	\N
241	1778-02-23	Lundi	1777-1778	309		Arrêté par nous Semainiers la Recette de ce jour 23 février mil sept cent soixante - dix huit montant à la somme de dix sept cent soixante quatre livres	1764	0	309	DesEssarts			f	f	\N	\N	790	2	2	\N
248	1778-03-02	Lundi	1777-1778	316		Arrêté par nous Semainiers la Recette de ce jour 2 mars mil sept cent soixante - dix huit montant à la somme de deux mille trois cent soixante une livres dix sols	2361	10	316		No signatory this day.		f	f	\N	\N	797	2	2	\N
244	1778-02-26	Jeudi	1777-1778	312		Arrêté par nous Semainiers la Recette de ce jour 26 février mil sept cent soixante - dix huit montant à la somme de treize cent quarante trois livres	1343	0	312	DesEssarts			f	f	\N	\N	793	2	2	\N
251	1778-03-05	Jeudi	1777-1778	319		Arrêté par nous Semainiers la Recette de ce jour 5 mars mil sept cent soixante - dix huit montant à la somme de sept cent quarante trois livres	743	0	319		No signatory this day.		f	f	\N	\N	800	2	2	\N
258	1778-03-12	Jeudi	1777-1778	326	18 billets de parterre pour la police -- 18 livres	Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	1071	0	326		No bottom entry, no signatory.  18 livre discrepancy due to parterre tickets sold to police.		f	f	\N	\N	807	2	2	\N
236	1778-02-18	Mercredi	1777-1778	304		Arrêté par nous Semainiers la Recette de ce jour 18 février mil sept cent soixante - dix huit montant à la somme de dix huit cent une livres dix sols	1801	10	304	DesEssarts			f	f	\N	\N	785	2	2	\N
243	1778-02-25	Mercredi	1777-1778	311		Arrêté par nous Semainiers la Recette de ce jour 25 février mil sept cent soixante - dix huit montant à la somme de dix sept cent quatre vingt dix sept livres	1797	0	311	DesEssarts			f	f	\N	\N	792	2	2	\N
273	1778-03-29	Dimanche	1777-1778	341	24 billets de parterre pour la police - 24 livres.\r\n	Arrêté par nous Semainiers la Recette de ce jour 29 mars mil sept cent soixante - dix huit montant à la somme de deux mille quatre cent quarante sept livres dix sols	2447	10	341		No signatory.		f	f	\N	\N	822	2	2	\N
267	1778-03-22	Dimanche	1777-1778	335		Arrêté par nous Semainiers la Recette de ce jour 22 mars mil sept cent soixante - dix huit montant à la somme de deux mille deux cent trente neuf livres dix sols	2339	10	335		No signatory	Pere de famille is a drame, not a comedie.	f	f	\N	\N	816	2	2	\N
260	1778-03-14	Samedi	1777-1778	328		Arrêté par nous Semainiers la Recette de ce jour 14 mars mil sept cent soixante - dix huit montant à la somme de dix neuf cent dix huit livres	1918	0	328		No signatory.		f	f	\N	\N	809	2	2	\N
266	1778-03-21	Samedi	1777-1778	334		Arrêté par nous Semainiers la Recette de ce jour 21 mars mil sept cent soixante - dix huit montant à la somme de deux mille huit cent quatre vingt onze livres dix sols	2891	10	334		No signatory		f	f	\N	\N	815	2	2	\N
269	1778-03-24	Mardi	1777-1778	337		Arrêté par nous Semainiers la Recette de ce jour 24 mars mil sept cent soixante - dix huit montant à la somme de huit cent quatre vingt dix livres dix sols	890	10	337		No signatory.		f	f	\N	\N	818	2	2	\N
275	1778-03-31	Mardi	1777-1778	343		Arrêté par nous Semainiers la Recette de ce jour 31 mars mil sept cent soixante - dix huit montant à la somme de neuf cent trente cinq livres	935	0	343		No signatory.		f	f	\N	\N	824	2	2	\N
262	1778-03-16	Lundi	1777-1778	330		Arrêté par nous Semainiers la Recette de ce jour 16 mars mil sept cent soixante - dix huit montant à la somme de trois mille sept cent quatre vingt seize livres	3796	0	330		"La Reine, Monsieur, Madame, et Mgr le Comte d'Artois ont honoré le spectacle de leur présence."		f	f	\N	\N	811	2	2	\N
268	1778-03-23	Lundi	1777-1778	336	Error in total received for premieres places: should 1224, but semainier has written 1204.	Arrêté par nous Semainiers la Recette de ce jour 23 mars mil sept cent soixante - dix huit montant à la somme de deux mille six cent trente cinq livres dix sols	2635	10	336		No signatory.		f	f	\N	\N	817	2	2	\N
271	1778-03-27	Lundi	1777-1778	339		Arrêté par nous Semainiers la Recette de ce jour 27 mars mil sept cent soixante - dix huit montant à la somme de onze cent quatre vingt dix huit livres	1198	0	339		No Signatory		f	f	\N	\N	820	2	2	\N
264	1778-03-19	Jeudi	1777-1778	332	"24 billets de parterre pour la police - 24 livres"	Arrêté par nous Semainiers la Recette de ce jour 19 mars mil sept cent soixante - dix hiut montant à la somme de six cent soixante livres	660	0	332		Receipt discrepancy due to police parterre ticket sales.\r\n\r\nNo signatory		f	f	\N	\N	813	2	2	\N
270	1778-03-26	Jeudi	1777-1778	338		Arrêté par nous Semainiers la Recette de ce jour 26 mars mil sept cent soixante - dix huit montant à la somme de mille cinquante huit livres	1058	0	338		No signatory.		f	f	\N	\N	819	2	2	\N
279	1779-03-18	Jeudi	1778-1779	315		Arrêté par nous Semainiers la Recette de ce jour 18 mars mil sept cent soixante - dix neuf montant à la somme de sept cent vingt deux livres.	722	0	315	Courville			f	f	\N	\N	1206	2	2	\N
284	1778-04-02	Jeudi	1778-1779	2		Arrêté par nous Semainiers la Recette de ce jour 2 avril mil sept cent soixante - dix huit montant à la somme de six cent douze livres.	612	0	2	Brizard			f	f	\N	\N	1216	2	2	\N
263	1778-03-18	Mercredi	1777-1778	331		Arrêté par nous Semainiers la Recette de ce jour 18 mars mil sept cent soixante - dix huit montant à la somme de deux mille huit cent quatre vingt deux livres	2882	0	331		No signatory		f	f	\N	\N	812	2	2	\N
281	1779-03-20	Samedi	1778-1779	317		Arrêté par nous Semainiers la Recette de ce jour 20 mars mil sept cent soixante - dix neuf montant à la somme de deux mille sept cent quarante trois livres dix fois.	2743	10	317	Courville	La cloture		f	f	\N	\N	1208	2	2	\N
291	1778-04-28	Mardi	1778-1779	6		Arrêté par nous Semainiers la Recette de ce jour 28 avril mil sept cent soixante - dix huit montant à la somme de cinq cent quatre vingt dix sept livres.	597	0	6	Brizard			f	f	\N	\N	1220	2	2	\N
276	1779-03-14	Lundi	1778-1779	312		Arrêté par nous Semainiers la Recette de ce jour 14 Mars mil sept cent soixante - dix neuf montant à la somme de seize cent dix neuf livres.	1619	0	312	Courville			f	f	\N	\N	1203	2	2	\N
290	1778-04-27	Lundi	1778-1779	5	Addition mistake.	Arrêté par nous Semainiers la Recette de ce jour 27 avril mil sept cent soixante - dix huit montant à la somme de deux mille six cent quatre vingt seize livres dix sous.	2696	10	5	Brizard	l'ouverture		f	f	\N	\N	1219	2	2	\N
299	1780-02-14	Lundi	1779-1780	297		Arrêté par nous Semainiers la Recette de ce jour 14 fev mil sept cent 80 montant à la somme de deux milles deux cent trente deux livres.	2232	0	297			Can't read signatory.	f	f	\N	\N	1536	2	2	\N
293	1778-04-30	Jeudi	1778-1779	8		Arrêté par nous Semainiers la Recette de ce jour 30 avril mil sept cent soixante - dix huit montant à la somme de cinq cent soixante une livres.	561	0	8	Brizard			f	f	\N	\N	1222	2	2	\N
295	1780-02-10	Jeudi	1779-1780	293		Arrêté par nous Semainiers la Recette de ce jour 10 fev mil sept cent 80 montant à la somme de quatre cent quatre-vingt dix-sept livres. 	497	0	293			Cannot read signatory.	f	f	\N	\N	1532	2	2	\N
292	1778-04-29	Mercredi	1778-1779	7	Addition mistake.	Arrêté par nous Semainiers la Recette de ce jour 29 avril mil sept cent soixante - dix huit montant à la somme de seize cent quarante neuf livres. 	1649	0	7	Brizard			f	f	\N	\N	1221	2	2	\N
282	1778-04-01	Mercredi	1778-1779	1		Arrêté par nous Semainiers la Recette de ce jour 1er avril mil sept cent soixante - dix huit montant à la somme de seize cent soixante onze livres.	1671	0	1	Brizard			f	f	\N	\N	1209	2	2	\N
294	1780-02-09	Mercredi	1779-1780	292		Arrêté par nous Semainiers la Recette de ce jour 9 fev mil sept cent 80 montant à la somme de dix neuf cent cinquante et un livres.	1951	0	292			Cannot read signatory	f	f	\N	\N	1530	2	2	\N
320	1779-12-26	Dimanche	1779-1780	249		Arrêté par nous Semainiers la Recette de ce jour 26 Xbre mil sept cent 80 montant à la somme de deux mille cinquante sept livres.	2057	0	249	Préville			f	f	\N	\N	1901	2	2	\N
337	1778-05-10	Dimanche	1778-1779	18		Arrêté par nous Semainiers la Recette de ce jour 10 May mil sept cent soixante - dix huit montant à la somme de sept cent neuf livres. 	709	0	18	Brizard			f	f	\N	\N	1232	2	2	\N
329	1778-05-02	Samedi	1778-1779	10		Arrêté par nous Semainiers la Recette de ce jour 2 May mil sept cent soixante - dix huit montant à la somme de deux mille deux cent vingt livres quinze livres.	2220	15	10	Brizard			f	f	\N	\N	1224	2	2	\N
336	1778-05-09	Samedi	1778-1779	17		Arrêté par nous Semainiers la Recette de ce jour 9 May mil sept cent soixante - dix huit montant à la somme de deux mille cinq cent soixante onze livres dix sous.	2571	10	17	Brizard			f	f	\N	\N	1231	2	2	\N
343	1778-05-16	Samedi	1778-1779	24		Arrêté par nous Semainiers la Recette de ce jour 16 May mil sept cent soixante - dix huit montant à la somme de deux mille deux cent vingt neuf livres dix sous.	2229	10	24	Brizard			f	f	\N	\N	1238	2	2	\N
326	1780-02-15	Mardi	1779-1780	298		Arrêté par nous Semainiers la Recette de ce jour 15 fev mil sept cent 80 montant à la somme de quatre cent six livres.	446	0	298			Can't read signatory.	f	f	\N	\N	1563	2	2	\N
332	1778-05-05	Mardi	1778-1779	13		Arrêté par nous Semainiers la Recette de ce jour 5 May mil sept cent soixante - dix huit montant à la somme de cinq cent quarante six livres dix sous.	546	10	13	Brizard			f	f	\N	\N	1227	2	2	\N
319	1779-12-27	Lundi	1779-1780	250		Arrêté par nous Semainiers la Recette de ce jour 27 Xbre mil sept cent 80 montant à la somme de quinze cent vingt livres.	1523	0	250	Préville		Préville made an error with his total (1520, instead of 1523), but he corrected it.  However, he transcribed the former total "quinze cent vingt livres".  	f	f	\N	\N	1902	2	2	\N
324	1779-12-20	Lundi	1779-1780	245		Arrêté par nous Semainiers la Recette de ce jour 20 Xbre mil sept cent 79 montant à la somme de quinze cent quatre vingt onze livres.	1591	0	245	Préville			f	f	\N	\N	1897	2	2	\N
325	1780-02-14	Lundi	1779-1780	297		Arrêté par nous Semainiers la Recette de ce jour 14 fev mil sept cent 80 montant à la somme de deux mille deux cent trente deux livres.	2232	0	297			Can't read signatory.	f	f	\N	\N	1562	2	2	\N
318	1779-12-30	Jeudi	1779-1780	252		Arrêté par nous Semainiers la Recette de ce jour 30 Xbre mil sept cent 79 montant à la somme de huit cent soixante treize livres. 	873	0	252	Créssville			f	f	\N	\N	1904	2	2	\N
322	1779-12-27	Jeudi	1779-1780	248		Arrêté par nous Semainiers la Recette de ce jour 23 Xbre mil sept cent 80 montant à la somme de quatre cent trente une livres.	431	0	248	Préville			f	f	\N	\N	1900	2	2	\N
334	1778-05-07	Jeudi	1778-1779	15	Adding mistake.	Arrêté par nous Semainiers la Recette de ce jour 7 May mil sept cent soixante - dix huit montant à la somme de neuf cent quatre vingt trois livres quinze sous.	983	15	15	Brizard			f	f	\N	\N	1229	2	2	\N
341	1778-05-14	Jeudi	1778-1779	22		Arrêté par nous Semainiers la Recette de ce jour 14 May mil sept cent soixante  dix huit montant à la somme de quatre cent quatre vingt onze livres.	491	0	22	Brizard			f	f	\N	\N	1236	2	2	\N
321	1779-12-22	Mercredi	1779-1780	247		Arrêté par nous Semainiers la Recette de ce jour 22 Xbre mil sept cent 80 montant à la somme de deux mille trois cent quarante quatre livres.	2344	0	247	Préville			f	f	\N	\N	1899	2	2	\N
333	1778-05-06	Mercredi	1778-1779	14		Arrêté par nous Semainiers la Recette de ce jour 6 May mil sept cent soixante - dix huit montant à la somme de douze cent soixante seize livres.	1276	0	14	Brizard			f	f	\N	\N	1228	2	2	\N
340	1778-05-13	Mercredi	1778-1779	21		Arrêté par nous Semainiers la Recette de ce jour 13 May mil sept cent soixante - dix huit montant à la somme de deux mille cent soixante cinq livres.	2165	0	21	Brizard			f	f	\N	\N	1235	2	2	\N
344	1778-05-17	Dimanche	1778-1779	25		Arrêté par nous Semainiers la Recette de ce jour 17 May mil sept cent soixante - dix huit montant à la somme de quatorze cent quatre vingt une livres.	1481	0	25	Brizard			f	f	\N	\N	1239	2	2	\N
354	1779-12-05	Dimanche	1779-1780	231		Arrêté par nous Semainiers la Recette de ce jour 5 xbre mil sept cent soixante -79 montant à la somme de dix sept cent trente vingt neuf livres.	1789	0	231	Préville			f	f	\N	\N	1881	2	2	\N
365	1780-02-13	Dimanche	1779-1780	296		Arrêté par nous Semainiers la Recette de ce jour 13 fev mil sept cent 80 montant à la somme de dix huit cent vingt six livres.	1826	0	296	Cournette			f	f	\N	\N	1561	2	2	\N
370	1780-02-20	Dimanche	1779-1780	303		Arrêté par nous Semainiers la Recette de ce jour 20 fev mil sept cent 80 montant à la somme de dix huit cent soixante quatorze livres.	1874	0	303	Cournette			f	f	\N	\N	1568	2	2	\N
355	1779-12-04	Samedi	1779-1780	230	[something I can't read -- 6 livres]	Arrêté par nous Semainiers la Recette de ce jour 4 xbre mil sept cent soixante -79 montant à la somme de quinze cent trente deux livres.	1532	0	230	Préville			f	f	\N	\N	1880	2	2	\N
364	1780-02-12	Samedi	1779-1780	295		Arrêté par nous Semainiers la Recette de ce jour 12 fev mil sept cent 80 montant à la somme de deux mille deux cent dix neuf livres dix sols.	2219	10	295	Cournette			f	f	\N	\N	1560	2	2	\N
369	1780-02-19	Samedi	1779-1780	302		Arrêté par nous Semainiers la Recette de ce jour 19 fev mil sept cent 80 montant à la somme de treize cent quatre vingt dix sept livres.	1397	0	302	Cournette			f	f	\N	\N	1567	2	2	\N
372	1780-02-22	Mardi	1779-1780	305		Arrêté par nous Semainiers la Recette de ce jour 22 fev mil sept cent 80 montant à la somme de mille six livres.	1006	0	305	Cournette			f	f	\N	\N	1570	2	2	\N
353	1779-12-06	Lundi	1779-1780	232	[something I can't read] M Doval aux 3er --- 4	Arrêté par nous Semainiers la Recette de ce jour 6 xbre mil sept cent soixante - 79 montant à la somme de quinze cent soixante quinze livres.	1575	0	232	Préville			f	f	\N	\N	1882	2	2	\N
371	1780-02-21	Lundi	1779-1780	304		Arrêté par nous Semainiers la Recette de ce jour 21 fev mil sept cent 80 montant à la somme de douze cent quatre vingt six livres.	1286	0	304	Cournette			f	f	\N	\N	1569	2	2	\N
350	1779-12-09	Jeudi	1779-1780	234		Arrêté par nous Semainiers la Recette de ce jour 9 xbre mil sept cent soixante -79 montant à la somme de sept cent dix neuf livres.	719	0	234	Préville			f	f	\N	\N	1885	2	2	\N
357	1780-02-17	Jeudi	1779-1780	300		Arrêté par nous Semainiers la Recette de ce jour 17 fev mil sept cent 80 montant à la somme de cinq cent cinquante trois livres.	553	0	300	Cournette?		Not sure about name of signatory.\r\n\r\n	f	f	\N	\N	1539	2	2	\N
347	1779-12-29	Mercredi	1779-1780	251		Arrêté par nous Semainiers la Recette de ce jour 29 xbre mil sept cent soixante -79 montant à la somme de deux mille trois cent soixante dix sept livres. 	2379	0	251	Préville			f	f	\N	\N	1903	2	2	\N
366	1780-02-16	Mercredi	1779-1780	299		Arrêté par nous Semainiers la Recette de ce jour 16 fev mil sept cent 80 montant à la somme de seize cent une livres quinze sols.	1601	15	299	Cournette			f	f	\N	\N	1564	2	2	\N
373	1780-02-23	Mercredi	1779-1780	306		Arrêté par nous Semainiers la Recette de ce jour 23 fev mil sept cent 80 montant à la somme de deux mille trente six livres dix sols.	2036	10	306	Cournette			f	f	\N	\N	1571	2	2	\N
403	1780-03-05	Dimanche	1779-1780	317		Arrêté par nous Semainiers la Recette de ce jour 5 mars mil sept cent 80 montant à la somme de dix sept cent vingt sept livres.	1727	0	317	Courville			f	f	\N	\N	1601	2	2	\N
376	1780-02-26	Samedi	1779-1780	309		Arrêté par nous Semainiers la Recette de ce jour 26 fev mil sept cent 80 montant à la somme de deux mille trois cent soixante huit livres dix sols.	2368	0	309	Cournette			f	f	\N	\N	1574	2	2	\N
390	1780-03-11	Samedi	1779-1780	323		Arrêté par nous Semainiers la Recette de ce jour 11 mars mil sept cent 80 montant à la somme de deux mille quatre cent livres dix sols.	2400	10	323	Cournette			f	f	\N	\N	1588	2	2	\N
379	1780-02-29	Mardi	1779-1780	312		Arrêté par nous Semainiers la Recette de ce jour 29 fev mil sept cent 80 montant à la somme de cinq cent soixante une livres dix sols.	561	10	312	Cournette			f	f	\N	\N	1577	2	2	\N
386	1780-03-07	Mardi	1779-1780	319		Arrêté par nous Semainiers la Recette de ce jour 7 mars mil sept cent 80 montant à la somme de six cent soixante quatorze livres.	674	0	319	Cournette			f	f	\N	\N	1584	2	2	\N
378	1780-02-28	Lundi	1779-1780	311		Arrêté par nous Semainiers la Recette de ce jour 28 fev mil sept cent 80 montant à la somme de dix huit cent dix huit livres.	1818	0	311	Cournette			f	f	\N	\N	1576	2	2	\N
385	1780-03-06	Lundi	1779-1780	318		Arrêté par nous Semainiers la Recette de ce jour 6 mars mil sept cent 80 montant à la somme de dix huit cent vingt huit livres quinze sols.	1828	15	318	Cournette			f	f	\N	\N	1583	2	2	\N
400	1780-03-02	Jeudi	1779-1780	314		Arrêté par nous Semainiers la Recette de ce jour 2 mars mil sept cent 80 montant à la somme de six cent quarante une livres.	641	0	314	Courville			f	f	\N	\N	1598	2	2	\N
393	1780-03-01	Mercredi	1779-1780	313		Arrêté par nous Semainiers la Recette de ce jour 1 mars mil sept cent 80 montant à la somme de deux mille cent trente quatre livres	2134	0	313	Cournette			f	f	\N	\N	1597	2	2	\N
424	1779-04-18	Dimanche	1779-1780	7		Arrêté par nous Semainiers la Recette de ce jour 18 avril mil sept cent soixante - dix neuf montant à la somme de cinq cent vingt trois livres.	523	0	7	Dazincourt			f	f	\N	\N	1620	2	2	\N
433	1779-04-25	Dimanche	1779-1780	14		Arrêté par nous Semainiers la Recette de ce jour 25 avril mil sept cent soixante - dix neuf montant à la somme de deux mille quatre vingt huit livres.	2088	0	14	Dazincourt			f	f	\N	\N	1627	2	2	\N
440	1779-05-02	Dimanche	1779-1780	21		Arrêté par nous Semainiers la Recette de ce jour 2 may mil sept cent soixante - 79 montant à la somme de quatorze cent soixante treize livres.	1473	0	21	Courville			f	f	\N	\N	1634	2	2	\N
432	1779-04-24	Samedi	1779-1780	13		Arrêté par nous Semainiers la Recette de ce jour 24 avril mil sept cent soixante -dix neuf montant à la somme de deux mille quatre cent vingt cinq livres quinze sols.	2425	15	13	Dazincourt			f	f	\N	\N	1626	2	2	\N
439	1779-05-01	Samedi	1779-1780	20		Arrêté par nous Semainiers la Recette de ce jour 1ère may mil sept cent soixante - dix neuf montant à la somme de deux mille cinq cent soixante quinze livres dix sols.	2575	10	20	Courville			f	f	\N	\N	1633	2	2	\N
428	1779-04-20	Mardi	1779-1780	9		Arrêté par nous Semainiers la Recette de ce jour 20 avril mil sept cent soixante -dix neuf montant à la somme de trois cent quatre vingt dix livres.	390	0	9	Dazincourt			f	f	\N	\N	1622	2	2	\N
435	1779-04-27	Mardi	1779-1780	16		Arrêté par nous Semainiers la Recette de ce jour 27 avril mil sept cent soixante - dix neuf montant à la somme de cinq cent trente quatre livres.	534	0	16	Dazincourt			f	f	\N	\N	1629	2	2	\N
410	1779-04-12	Lundi	1779-1780	1		Arrêté par nous Semainiers la Recette de ce jour 12 avril mil sept cent soixante - dix neuf montant à la somme de deux mille trois cent cinquante trois livres dix sols.	2353	10	1	Dazincourt			f	f	\N	\N	1608	2	2	\N
408	1780-03-09	Jeudi	1779-1780	321		Arrêté par nous Semainiers la Recette de ce jour 9 mars mil sept cent 80 montant à la somme de six cent quatre vingt une livres.	681	0	321	Courville			f	f	\N	\N	1605	2	2	\N
419	1779-04-15	Jeudi	1779-1780	4		Arrêté par nous Semainiers la Recette de ce jour 15 avril mil sept cent soixante - dix neuf montant à la somme de quatre cent soixante neuf livres.	469	0	4	Dazincourt			f	f	\N	\N	1617	2	2	\N
430	1779-04-22	Jeudi	1779-1780	11		Arrêté par nous Semainiers la Recette de ce jour 22 avril mil sept cent soixante -dix neuf montant à la somme de quatre cent soixante deux livres.	462	0	11	Dazincourt			f	f	\N	\N	1624	2	2	\N
437	1779-04-29	Jeudi	1779-1780	18		Arrêté par nous Semainiers la Recette de ce jour 29 avril mil sept cent soixante - dix neuf montant à la somme de deux mille cinquante quatre livres.	2054	0	18	Dazincourt			f	f	\N	\N	1631	2	2	\N
407	1780-03-08	Mercredi	1779-1780	320		Arrêté par nous Semainiers la Recette de ce jour 8 mars mil sept cent 80 montant à la somme de deux mille deux cent vingt une livres dix sols.	2221	10	320	Courville			f	f	\N	\N	1604	2	2	\N
429	1779-04-21	Mercredi	1779-1780	10		Arrêté par nous Semainiers la Recette de ce jour 21 avril mil sept cent soixante -dix neuf montant à la somme de dix neuf cent soixante trois livres.	1963	0	10	Dazincourt			f	f	\N	\N	1623	2	2	\N
436	1779-04-28	Mercredi	1779-1780	17		Arrêté par nous Semainiers la Recette de ce jour 28 avril mil sept cent soixante - dix neuf montant à la somme de deux mille trois cent onze livres quinze sols.	2311	15	17	Dazincourt			f	f	\N	\N	1630	2	2	\N
447	1779-05-09	Dimanche	1779-1780	28		Arrêté par nous Semainiers la Recette de ce jour 9 may mil sept cent soixante - 79 montant à la somme de dix neuf cent soixante dix sept livres.	1977	0	28	Courville			f	f	\N	\N	1641	2	2	\N
452	1779-05-16	Dimanche	1779-1780	33		Arrêté par nous Semainiers la Recette de ce jour 16 may mil sept cent soixante -79 montant à la somme de onze cent trente trois livres.	1133	0	33	Courville			f	f	\N	\N	1646	2	2	\N
468	1779-05-30	Dimanche	1779-1780	46		Arrêté par nous Semainiers la Recette de ce jour 30 may mil sept cent soixante -79 montant à la somme de sept cent vingt cinq livres.	725	0	46	Courville			f	f	\N	\N	1659	2	2	\N
446	1779-05-08	Samedi	1779-1780	27		Arrêté par nous Semainiers la Recette de ce jour 8 may mil sept cent soixante - 79 montant à la somme de deux mille quatre cent vingt huit livres.	2428	0	27	Courville			f	f	\N	\N	1640	2	2	\N
459	1779-05-22	Samedi	1779-1780	39		Arrêté par nous Semainiers la Recette de ce jour 22 may mil sept cent soixante -79 montant à la somme de deux mille trois cent douze livres dix sols.	2312	10	39	Courville			f	f	\N	\N	1652	2	2	\N
467	1779-05-29	Samedi	1779-1780	45		Arrêté par nous Semainiers la Recette de ce jour 29 may mil sept cent soixante -79 montant à la somme de dix neuf cent trente neuf livres quinze sols.	1939	15	45	Courville			f	f	\N	\N	1658	2	2	\N
449	1779-05-11	Mardi	1779-1780	30		Arrêté par nous Semainiers la Recette de ce jour 11 may mil sept cent soixante -79 montant à la somme de six cent quarante cinq livres.	645	0	30	Courville			f	f	\N	\N	1643	2	2	\N
454	1779-05-18	Mardi	1779-1780	35		Arrêté par nous Semainiers la Recette de ce jour 18 may mil sept cent soixante -79 montant à la somme de cinq cent treize livres	513	0	35	Courville		difference of 10 livres between the written total and the real total.	f	f	\N	\N	1648	2	2	\N
461	1779-05-25	Mardi	1779-1780	41		Arrêté par nous Semainiers la Recette de ce jour 25 may mil sept cent soixante - 79 montant à la somme de six cent quarante huit livres.	648	0	41	Courville			f	f	\N	\N	1654	2	2	\N
470	1779-06-01	Mardi	1779-1780	48		Arrêté par nous Semainiers la Recette de ce jour 1 Juin mil sept cent soixante -79 montant à la somme de dix cent dix huit livres dix sols.	618	10	48	Dorival ?		Not sure of signatory.	f	f	\N	\N	1661	2	2	\N
448	1779-05-10	Lundi	1779-1780	29		Arrêté par nous Semainiers la Recette de ce jour 10 may mil sept cent soixante -79 montant à la somme de deux mille quatre cent soixante quatre livres.	2464	0	29	Courville			f	f	\N	\N	1642	2	2	\N
453	1779-05-17	Lundi	1779-1780	34		Arrêté par nous Semainiers la Recette de ce jour 17 may mil sept cent soixante -79 montant à la somme de dix neuf cent quatre livres.	1904	15	34	Courville			f	f	\N	\N	1647	2	2	\N
460	1779-05-24	Lundi	1779-1780	40		Arrêté par nous Semainiers la Recette de ce jour 24 may mil sept cent soixante -79 montant à la somme de treize cent soixante neuf livres.	1369	0	40	Courville			f	f	\N	\N	1653	2	2	\N
469	1779-05-31	Lundi	1779-1780	47		Arrêté par nous Semainiers la Recette de ce jour 31 may mil sept cent soixante -79 montant à la somme de deux mille trois cent quatre vingt neuf livres.	2389	0	47	Courville			f	f	\N	\N	1660	2	2	\N
444	1779-05-06	Jeudi	1779-1780	25		Arrêté par nous Semainiers la Recette de ce jour 6 may mil sept cent soixante -79 montant à la somme de six cent cinquante huit livres.	658	0	25	Courville			f	f	\N	\N	1638	2	2	\N
456	1779-05-20	Jeudi	1779-1780	37		Arrêté par nous Semainiers la Recette de ce jour 29 may mil sept cent soixante -79 montant à la somme de sept cent six livres.	706	0	37	Courville			f	f	\N	\N	1650	2	2	\N
463	1779-05-27	Jeudi	1779-1780	43		Arrêté par nous Semainiers la Recette de ce jour 27 may mil sept cent soixante -79 montant à la somme de trois cent vingt cinq livres.	325	0	43	Courville			f	f	\N	\N	1656	2	2	\N
443	1779-05-05	Mercredi	1779-1780	24		Arrêté par nous Semainiers la Recette de ce jour 5 may mil sept cent soixante -79 montant à la somme de dix sept cent vingt quatre livres.	1724	0	24	Courville			f	f	\N	\N	1637	2	2	\N
450	1779-05-12	Mercredi	1779-1780	31		Arrêté par nous Semainiers la Recette de ce jour 12 may mil sept cent soixante - 79 montant à la somme de deux mille soixante trois livres dix sols.	2063	10	31	Courville			f	f	\N	\N	1644	2	2	\N
455	1779-05-19	Mercredi	1779-1780	36		Arrêté par nous Semainiers la Recette de ce jour 19 may mil sept cent soixante - 79 montant à la somme de dix huit cent cinquante trois livres.	1853	0	36	Courville			f	f	\N	\N	1649	2	2	\N
462	1779-05-26	Mercredi	1779-1780	42		Arrêté par nous Semainiers la Recette de ce jour 26 may mil sept cent soixante -79 montant à la somme de sept cent quatre vingt quatorze livres.	794	0	42	Courville			f	f	\N	\N	1655	2	2	\N
474	1779-06-06	Dimanche	1779-1780	52		Arrêté par nous Semainiers la Recette de ce jour 6 Juin mil sept cent soixante -79 montant à la somme de six cent trois livres.	603	0	52	Dorivas			f	f	\N	\N	1665	2	2	\N
481	1779-06-13	Dimanche	1779-1780	59		Arrêté par nous Semainiers la Recette de ce jour 13 Juin mil sept cent soixante -79 montant à la somme de onze cent quatre vingt quinze livres.	1195	0	59	Dorivas			f	f	\N	\N	1672	2	2	\N
493	1779-06-20	Dimanche	1779-1780	66		Arrêté par nous Semainiers la Recette de ce jour 20 Juin mil sept cent soixante - 79 montant à la somme de six cent soixante dix neuf livres.	679	0	66	Dorivas			f	f	\N	\N	1680	2	2	\N
499	1779-06-27	Dimanche	1779-1780	73		Arrêté par nous Semainiers la Recette de ce jour 27 Juin mil sept cent soixante - 79 montant à la somme de quatorze cent quatre vingt trois livres.	1483	0	73	Dorivas			f	f	\N	\N	1686	2	2	\N
473	1779-06-05	Samedi	1779-1780	51		Arrêté par nous Semainiers la Recette de ce jour 5 Juin mil sept cent soixante -79 montant à la somme de treize cent douze livres quinze sols.	1312	15	51	Dorivas			f	f	\N	\N	1664	2	2	\N
480	1779-06-12	Samedi	1779-1780	58		Arrêté par nous Semainiers la Recette de ce jour 12 Juin mil sept cent soixante -79 montant à la somme de dix huit cent deux livres.	1802	0	58	Dorivas			f	f	\N	\N	1671	2	2	\N
476	1779-06-08	Mardi	1779-1780	54		Arrêté par nous Semainiers la Recette de ce jour 8 Juin mil sept cent soixante -79 montant à la somme de cinq cent quarante neuf livres dix sols.	549	10	54	Dorivas			f	f	\N	\N	1667	2	2	\N
483	1779-06-15	Mardi	1779-1780	61		Arrêté par nous Semainiers la Recette de ce jour 15 Juin mil sept cent soixante - 79 montant à la somme de trois cent quatre vingt sept livres.	387	0	61	Dorivas			f	f	\N	\N	1674	2	2	\N
495	1779-06-22	Mardi	1779-1780	68		Arrêté par nous Semainiers la Recette de ce jour 22 Juin mil sept cent soixante - 79 montant à la somme de quatre cent soixante quinze livres.	475	0	68	Dorivas			f	f	\N	\N	1682	2	2	\N
501	1779-06-29	Mardi	1779-1780	75		Arrêté par nous Semainiers la Recette de ce jour 29 Juin mil sept cent soixante - 79 montant à la somme de six cent trente neuf livres.	639	0	75	Dorivas			f	f	\N	\N	1688	2	2	\N
475	1779-06-07	Lundi	1779-1780	53		Arrêté par nous Semainiers la Recette de ce jour 7 juin mil sept cent soixante - 79 montant à la somme de mille cinquante trois livres.	1053	0	53	Dorivas			f	f	\N	\N	1666	2	2	\N
482	1779-06-14	Lundi	1779-1780	60		Arrêté par nous Semainiers la Recette de ce jour 14 Juin mil sept cent soixante - 79 montant à la somme de dix huit cent soixante deux livres.	1862	0	60	Dorivas			f	f	\N	\N	1673	2	2	\N
494	1779-06-21	Lundi	1779-1780	67		Arrêté par nous Semainiers la Recette de ce jour 21 Juin mil sept cent soixante -79 montant à la somme de dix sept cent cinquante sept livres.	1757	0	67	Dorivas			f	f	\N	\N	1681	2	2	\N
478	1779-06-10	Jeudi	1779-1780	56		Arrêté par nous Semainiers la Recette de ce jour 10 Juin mil sept cent soixante - 79 montant à la somme de douze cent quatorze douze livres.	1292	0	56	Dorivas			f	f	\N	\N	1669	2	2	\N
486	1779-06-17	Jeudi	1779-1780	63		Arrêté par nous Semainiers la Recette de ce jour 17 Juin mil sept cent soixante -79 montant à la somme de quatre cent quinze livres.	415	0	63	Dorivas			f	f	\N	\N	1677	2	2	\N
497	1779-06-24	Jeudi	1779-1780	70		Arrêté par nous Semainiers la Recette de ce jour 24 Juin mil sept cent soixante -79 montant à la somme de douze cent soixante onze livres.	1271	0	70	Dorivas			f	f	\N	\N	1684	2	2	\N
503	1779-07-01	Jeudi	1779-1780	77		Arrêté par nous Semainiers la Recette de ce jour 1 juillet mil sept cent soixante -79 montant à la somme de deux cent quatre vingt onze livres.	291	0	77	Dorivas			f	f	\N	\N	1690	2	2	\N
471	1779-06-02	Mercredi	1779-1780	49		Arrêté par nous Semainiers la Recette de ce jour 2 juin mil sept cent soixante -79 montant à la somme de quatorze cent douze livres.	1412	0	49	Dorivas			f	f	\N	\N	1662	2	2	\N
485	1779-06-16	Mercredi	1779-1780	62		Arrêté par nous Semainiers la Recette de ce jour 16 Juin mil sept cent soixante - 79 montant à la somme de quinze cent quatre vingt dix livres.	1590	0	62	Dorivas			f	f	\N	\N	1676	2	2	\N
496	1779-06-23	Mercredi	1779-1780	69		Arrêté par nous Semainiers la Recette de ce jour 23 Juin mil sept cent soixante - 79 montant à la somme de dix sept cent dix neuf livres quinze sols.	1719	15	69	Dorivas			f	f	\N	\N	1683	2	2	\N
502	1779-06-30	Mercredi	1779-1780	76		Arrêté par nous Semainiers la Recette de ce jour 30 Juin mil sept cent soixante - 79 montant à la somme de douze cent trente deux livres.	1232	0	76	Dorivas			f	f	\N	\N	1689	2	2	\N
507	1779-07-04	Dimanche	1779-1780	80		Arrêté par nous Semainiers la Recette de ce jour 4 Juillet mil sept cent soixante - 79 montant à la somme de quinze cent quarante huit livres.	1548	0	80	Dorival			f	f	\N	\N	1693	2	2	\N
521	1779-07-18	Dimanche	1779-1780	94		Arrêté par nous Semainiers la Recette de ce jour 18 Juillet mil sept cent soixante - 79 montant à la somme de sept cent quarante cinq livres.	0	0	94	Dorival			f	f	\N	\N	1707	2	2	\N
528	1779-07-25	Dimanche	1779-1780	101		Arrêté par nous Semainiers la Recette de ce jour 25 Juin mil sept cent soixante - 79 montant à la somme de sept cent trente et une livres.	731	0	101	Dorival			f	f	\N	\N	1714	2	2	\N
514	1779-07-11	Dimanche	1779-1780	87		Arrêté par nous Semainiers la Recette de ce jour 11 Juillet mil sept cent soixante - 79 montant à la somme de sept cent soixante livres.	760	0	87	Dorival		 | Check play, "Zélémide" is wrong title?	f	f	\N	\N	1700	2	2	\N
506	1779-07-03	Samedi	1779-1780	79		Arrêté par nous Semainiers la Recette de ce jour 3 Juillet mil sept cent soixante - 79 montant à la somme de deux mille cent quatorze livres.	2114	0	79	Dorival			f	f	\N	\N	1692	2	2	\N
513	1779-07-10	Samedi	1779-1780	86		Arrêté par nous Semainiers la Recette de ce jour 10 Juillet mil sept cent soixante - 79 montant à la somme de quatorze cent cinquante livres.	1450	0	86	Dorival			f	f	\N	\N	1699	2	2	\N
520	1779-07-17	Samedi	1779-1780	93		Arrêté par nous Semainiers la Recette de ce jour 17 Juillet mil sept cent soixante - 79 montant à la somme de neuf cent trente neuf livres.	939	0	93	Dorival			f	f	\N	\N	1706	2	2	\N
527	1779-07-24	Samedi	1779-1780	100		Arrêté par nous Semainiers la Recette de ce jour 24 Juillet mil sept cent soixante - 79 montant à la somme de dix huit cent quarante sept livres.	1847	0	100	Dorival			f	f	\N	\N	1713	2	2	\N
509	1779-07-06	Mardi	1779-1780	82		Arrêté par nous Semainiers la Recette de ce jour 8 Juillet mil sept cent soixante -79 montant à la somme de quatre cent soixante quinze livres dix sols.	475	10	82	Dorival			f	f	\N	\N	1695	2	2	\N
516	1779-07-13	Mardi	1779-1780	89		Arrêté par nous Semainiers la Recette de ce jour 13 Juillet mil sept cent soixante - 79 montant à la somme de trois cent seize livres dix sols.	316	10	89	Dorival			f	f	\N	\N	1702	2	2	\N
523	1779-07-20	Mardi	1779-1780	96		Arrêté par nous Semainiers la Recette de ce jour 20 Juillet mil sept cent soixante - 79 montant à la somme de deux cent vingt sept livres.	227	0	96	Dorival			f	f	\N	\N	1709	2	2	\N
530	1779-07-27	Mardi	1779-1780	103		Arrêté par nous Semainiers la Recette de ce jour 27 Juillet mil sept cent soixante - 79 montant à la somme de deux cent vingt une livres dix sols.	221	10	103	Dorival			f	f	\N	\N	1716	2	2	\N
508	1779-07-05	Lundi	1779-1780	81		Arrêté par nous Semainiers la Recette de ce jour 5 Juillet mil sept cent soixante - 79 montant à la somme de deux mille cent vingt neuf livres.	2129	0	81	Dorival			f	f	\N	\N	1694	2	2	\N
515	1779-07-12	Lundi	1779-1780	88		Arrêté par nous Semainiers la Recette de ce jour 12 Juillet mil sept cent soixante - 79 montant à la somme de quinze cent cinquante cinq livres.	1555	0	88	Dorival			f	f	\N	\N	1701	2	2	\N
522	1779-07-19	Lundi	1779-1780	95		Arrêté par nous Semainiers la Recette de ce jour 19 Juillet mil sept cent soixante -79 montant à la somme de cinq cent quarante deux livres.	542	0	95	Dorival			f	f	\N	\N	1708	2	2	\N
529	1779-07-26	Lundi	1779-1780	102		Arrêté par nous Semainiers la Recette de ce jour 26 Juillet mil sept cent soixante - 79 montant à la somme de dix neuf cent soixante quinze livres.	1975	0	102	Dorival			f	f	\N	\N	1715	2	2	\N
511	1779-07-08	Jeudi	1779-1780	84		Arrêté par nous Semainiers la Recette de ce jour 8 Juillet mil sept cent soixante -79 montant à la somme de quatre cent quatorze livres.	414	0	84	Dorival			f	f	\N	\N	1697	2	2	\N
518	1779-07-15	Jeudi	1779-1780	91		Arrêté par nous Semainiers la Recette de ce jour 15 Juillet mil sept cent soixante -79 montant à la somme de deux cent cinquante une livres.	251	0	91	Dorival			f	f	\N	\N	1704	2	2	\N
525	1779-07-22	Jeudi	1779-1780	98		Arrêté par nous Semainiers la Recette de ce jour 22 Juillet mil sept cent soixante - 79 montant à la somme de mille quatre livres.	1004	0	98	Dorival			f	f	\N	\N	1711	2	2	\N
532	1779-07-29	Jeudi	1779-1780	105		Arrêté par nous Semainiers la Recette de ce jour 29 Juillet mil sept cent soixante -79 montant à la somme de quatre cent quatre vingt cinq livres.	485	0	105	Dorival			f	f	\N	\N	1718	2	2	\N
477	1779-06-09	Mercredi	1779-1780	55		Arrêté par nous Semainiers la Recette de ce jour 9 Juin mil sept cent soixante -79 montant à la somme de onze cent sept livres.	1107	0	55	Dorivas		 | Check play, "Zélémide" is wrong title?	f	f	\N	\N	1668	2	2	\N
510	1779-07-07	Mercredi	1779-1780	83		Arrêté par nous Semainiers la Recette de ce jour 7 Juillet mil sept cent soixante -79 montant à la somme de dix sept cent cinquante cinq livres.	1755	0	83	Dorival			f	f	\N	\N	1696	2	2	\N
517	1779-07-14	Mercredi	1779-1780	90		Arrêté par nous Semainiers la Recette de ce jour 14 Juillet mil sept cent soixante -79 montant à la somme de huit cent soixante seize livres.	876	0	90	Dorival			f	f	\N	\N	1703	2	2	\N
531	1779-07-28	Mercredi	1779-1780	104		Arrêté par nous Semainiers la Recette de ce jour 28 Juillet mil sept cent soixante - 79 montant à la somme de treize cent trente deux livres.	1332	0	104	Dorival			f	f	\N	\N	1717	2	2	\N
535	1779-08-01	Dimanche	1779-1780	108		Arrêté par nous Semainiers la Recette de ce jour 1 aout mil sept cent soixante - 79 montant à la somme de huit cent quatre vingt trois livres.	883	0	108	Bellemont			f	f	\N	\N	1721	2	2	\N
572	1779-09-05	Dimanche	1779-1780	142		Arrêté par nous Semainiers la Recette de ce jour 5 7bre mil sept cent soixante - 79 montant à la somme de seize cent cinquante six livres.	1656	0	142	Florence			f	f	\N	\N	1756	2	2	\N
542	1779-08-08	Dimanche	1779-1780	115		Arrêté par nous Semainiers la Recette de ce jour 8 aout mil sept cent soixante - 79 montant à la somme de quatorze cent vingt quatre livres.	1424	0	115	Bellemont			f	f	\N	\N	1728	2	2	\N
556	1779-08-22	Dimanche	1779-1780	128		Arrêté par nous Semainiers la Recette de ce jour 22 aout mil sept cent soixante - 79 montant à la somme de sept cent quatre vingt dix neuf livres.	799	0	128	Bellemont			f	f	\N	\N	1742	2	2	\N
563	1779-08-29	Dimanche	1779-1780	135		Arrêté par nous Semainiers la Recette de ce jour 29 aout mil sept cent soixante - 79 montant à la somme de cinq cent quatre vingt treize livres.	593	0	135	Bellemont			f	f	\N	\N	1749	2	2	\N
534	1779-07-31	Samedi	1779-1780	106		Arrêté par nous Semainiers la Recette de ce jour 31 Juillet mil sept cent soixante - 79 montant à la somme de treize cent soixante livres.	1360	0	106	Dorival			f	f	\N	\N	1720	2	2	\N
541	1779-08-07	Samedi	1779-1780	114		Arrêté par nous Semainiers la Recette de ce jour 7 Aout mil sept cent soixante - 79 montant à la somme de quinze cent sept livres.	1507	0	114	Bellemont			f	f	\N	\N	1727	2	2	\N
548	1779-08-14	Samedi	1779-1780	121		Arrêté par nous Semainiers la Recette de ce jour 14 aout mil sept cent soixante - 79 montant à la somme de quatorze cent trente trois livres. 	1433	0	121	Bellemont			f	f	\N	\N	1735	2	2	\N
555	1779-08-01	Samedi	1779-1780	127		Arrêté par nous Semainiers la Recette de ce jour 21 aout mil sept cent soixante - 79 montant à la somme de quinze cent trente neuf livres.	1539	0	127	Bellemont			f	f	\N	\N	1741	2	2	\N
537	1779-08-03	Mardi	1779-1780	110		Arrêté par nous Semainiers la Recette de ce jour 3 Aout mil sept cent soixante - 79 montant à la somme de trois cent quatre vingt six livres.	386	0	110	Bellemont			f	f	\N	\N	1723	2	2	\N
544	1779-08-10	Mardi	1779-1780	117		Arrêté par nous Semainiers la Recette de ce jour 10 aout mil sept cent soixante - 79 montant à la somme de trois cent quatre vingt dix neuf livres.	399	0	117	Bellemont			f	f	\N	\N	1730	2	2	\N
551	1779-08-17	Mardi	1779-1780	123		Arrêté par nous Semainiers la Recette de ce jour 17 aout mil sept cent soixante - 79 montant à la somme de deux cent trente livres.	230	0	123	Bellemont			f	f	\N	\N	1737	2	2	\N
558	1779-08-24	Mardi	1779-1780	130		Arrêté par nous Semainiers la Recette de ce jour 24 aout mil sept cent soixante - 79 montant à la somme de trois cent vingt une livres dix sols.	321	10	130	Bellemont			f	f	\N	\N	1744	2	2	\N
536	1779-08-02	Lundi	1779-1780	109		Arrêté par nous Semainiers la Recette de ce jour 2 Aout mil sept cent soixante - 79 montant à la somme de douze cent quarante une livres dix sols.	1241	10	109	Bellemont			f	f	\N	\N	1722	2	2	\N
543	1779-08-09	Lundi	1779-1780	116		Arrêté par nous Semainiers la Recette de ce jour 9 Aout mil sept cent soixante - 79 montant à la somme de onze cent neuf livres.	1109	0	116	Bellemont			f	f	\N	\N	1729	2	2	\N
550	1779-08-16	Lundi	1779-1780	122		Arrêté par nous Semainiers la Recette de ce jour 16 aout mil sept cent soixante - 79 montant à la somme de six cent quarante six livres.	646	0	122	Bellemont			f	f	\N	\N	1736	2	2	\N
557	1779-08-23	Lundi	1779-1780	129		Arrêté par nous Semainiers la Recette de ce jour 23 aout mil sept cent soixante - 79 montant à la somme de quinze cent dix livres quinze sols.	1510	15	129	Bellemont			f	f	\N	\N	1743	2	2	\N
539	1779-08-05	Jeudi	1779-1780	112		Arrêté par nous Semainiers la Recette de ce jour 5 Aout mil sept cent soixante - 79 montant à la somme de mille quarante une livres.	1041	0	112	Bellemont			f	f	\N	\N	1725	2	2	\N
546	1779-08-12	Jeudi	1779-1780	119		Arrêté par nous Semainiers la Recette de ce jour 12 aout mil sept cent soixante - 79 montant à la somme de onze cent soixante huit livres.	1168	0	119	Bellemont			f	f	\N	\N	1732	2	2	\N
553	1779-08-19	Jeudi	1779-1780	125		Arrêté par nous Semainiers la Recette de ce jour 19 aout mil sept cent soixante - 79 montant à la somme de quatre cent soixante livres.	460	0	125	Bellemont			f	f	\N	\N	1739	2	2	\N
560	1779-08-26	Jeudi	1779-1780	132		Arrêté par nous Semainiers la Recette de ce jour 26 aout mil sept cent soixante - 79 montant à la somme de trois cent cinquante trois livres.	353	0	132	Bellemont			f	f	\N	\N	1746	2	2	\N
538	1779-08-04	Mercredi	1779-1780	111		Arrêté par nous Semainiers la Recette de ce jour 4 Aout mil sept cent soixante - 79 montant à la somme de sept cent quatre livres.	704	0	111	Bellemont			f	f	\N	\N	1724	2	2	\N
545	1779-08-11	Mercredi	1779-1780	118		Arrêté par nous Semainiers la Recette de ce jour 11 aout mil sept cent soixante - 79 montant à la somme de huit cent trente sept livres.	837	0	118	Bellemont			f	f	\N	\N	1731	2	2	\N
552	1779-08-18	Mercredi	1779-1780	124		Arrêté par nous Semainiers la Recette de ce jour 18 aout mil sept cent soixante - 79 montant à la somme de trois cent cinquante deux livres.	352	0	124	Bellemont			f	f	\N	\N	1738	2	2	\N
559	1779-08-25	Mercredi	1779-1780	131		Arrêté par nous Semainiers la Recette de ce jour 25 aout mil sept cent soixante - 79 montant à la somme de quinze cent soixante seize livres.	1576	0	131	Bellemont			f	f	\N	\N	1745	2	2	\N
579	1779-09-12	Dimanche	1779-1780	148		Arrêté par nous Semainiers la Recette de ce jour 12 7bre mil sept cent soixante - 79 montant à la somme de neuf cent soixante trois livres.	963	0	148	Florence			f	f	\N	\N	1762	2	2	\N
586	1779-09-19	Dimanche	1779-1780	155		Arrêté par nous Semainiers la Recette de ce jour 19 7bre mil sept cent soixante - 79 montant à la somme de quinze cent quarante trois livres quinze sols.	1543	15	155	Florence			f	f	\N	\N	1769	2	2	\N
593	1779-09-26	Dimanche	1779-1780	162		Arrêté par nous Semainiers la Recette de ce jour 26 7bre mil sept cent soixante - 79 montant à la somme de neuf cent dix livres.	910	0	162	Florence			f	f	\N	\N	1776	2	2	\N
571	1779-09-04	Samedi	1779-1780	141		Arrêté par nous Semainiers la Recette de ce jour 4 7bre mil sept cent soixante - 79 montant à la somme de quinze cent quatre vingt cinq livres.	1585	0	141	Florence			f	f	\N	\N	1755	2	2	\N
578	1779-09-11	Samedi	1779-1780	147		Arrêté par nous Semainiers la Recette de ce jour 11 7bre mil sept cent soixante - 79 montant à la somme de deux mille huit cent neuf livres dix sols.	2809	10	147	Florence			f	f	\N	\N	1761	2	2	\N
585	1779-09-18	Samedi	1779-1780	154		Arrêté par nous Semainiers la Recette de ce jour 18 7bre mil sept cent soixante - 79 montant à la somme de dix huit quatre vingt quatre livres.	1884	0	154	Florence			f	f	\N	\N	1768	2	2	\N
592	1779-09-25	Samedi	1779-1780	161		Arrêté par nous Semainiers la Recette de ce jour 25 7bre mil sept cent soixante - 79 montant à la somme de deux mille vingt livres.	2020	0	161	Florence			f	f	\N	\N	1775	2	2	\N
566	1779-08-31	Mardi	1779-1780	137		Arrêté par nous Semainiers la Recette de ce jour 31 aout mil sept cent soixante - 79 montant à la somme de trois cent dix huit livres dix sols.	318	10	137	Bellemont			f	f	\N	\N	1751	2	2	\N
568	1777-12-30	Mardi	1777-1778	256		Arrêté par nous Semainiers la Recette de ce jour 30 décembre mil sept cent soixante - dix sept montant à la somme de quatre cent vingt quatre livres dix sols	424	10	256	DesEssarts			f	f	\N	\N	1118	2	2	\N
574	1779-09-07	Mardi	1779-1780	144		Arrêté par nous Semainiers la Recette de ce jour 7 7bre mil sept cent soixante - 79 montant à la somme de huit cent soixante quatre livres.	864	0	144	Florence			f	f	\N	\N	1758	2	2	\N
581	1779-09-14	Mardi	1779-1780	150		Arrêté par nous Semainiers la Recette de ce jour 14 7bre mil sept cent soixante - 79 montant à la somme de quatre cent vingt six livres dix sols.	426	10	150				f	f	\N	\N	1764	2	2	\N
588	1779-09-21	Mardi	1779-1780	157		Arrêté par nous Semainiers la Recette de ce jour 21 7bre mil sept cent soixante - 79 montant à la somme de huit cent sept livres.	807	10	157	Florence			f	f	\N	\N	1771	2	2	\N
573	1779-09-06	Lundi	1779-1780	143		Arrêté par nous Semainiers la Recette de ce jour 6 7bre mil sept cent soixante - 79 montant à la somme de neuf cent trente quatre livres.	934	0	143	Florence			f	f	\N	\N	1757	2	2	\N
580	1779-09-13	Lundi	1779-1780	149		Arrêté par nous Semainiers la Recette de ce jour 13 7bre mil sept cent soixante - 79 montant à la somme de deux mille deux cent vingt une livres dix sols.	2221	10	149				f	f	\N	\N	1763	2	2	\N
587	1779-09-20	Lundi	1779-1780	156		Arrêté par nous Semainiers la Recette de ce jour 20 7bre mil sept cent soixante - 79 montant à la somme de deux mille vingt sept livres dix sols.	2027	10	156	Florence			f	f	\N	\N	1770	2	2	\N
594	1779-09-27	Lundi	1779-1780	163		Arrêté par nous Semainiers la Recette de ce jour 27 7bre mil sept cent soixante - 79 montant à la somme de quatorze cent trente neuf livres.	1439	0	163	Florence			f	f	\N	\N	1777	2	2	\N
569	1779-09-02	Jeudi	1779-1780	139		Arrêté par nous Semainiers la Recette de ce jour 2 7bre mil sept cent soixante - 79 montant à la somme de trois cent quarante sept livres.	347	0	139	A?		Can't read signatory	f	f	\N	\N	1753	2	2	\N
575	1779-09-09	Jeudi	1779-1780	145		Arrêté par nous Semainiers la Recette de ce jour 9 7bre mil sept cent soixante - 79 montant à la somme de dix sept cent quatorze livres.	1714	0	145	%			f	f	\N	\N	1759	2	2	\N
583	1779-09-16	Jeudi	1779-1780	152		Arrêté par nous Semainiers la Recette de ce jour 16 7bre mil sept cent soixante - 79 montant à la somme de quatre cent soixante livres.	460	0	152				f	f	\N	\N	1766	2	2	\N
590	1779-09-23	Jeudi	1779-1780	159		Arrêté par nous Semainiers la Recette de ce jour 23 7bre mil sept cent soixante - 79 montant à la somme de sept cent dix sept livres.	717	0	159	Florence			f	f	\N	\N	1773	2	2	\N
565	1777-12-31	Mercredi	1777-1778	257		Arrêté par nous Semainiers la Recette de ce jour 31 decembre mil sept cent soixante - dix sept montant à la somme de treize cent soixante six livres dix sols	1366	10	257	DesEssarts			f	f	\N	\N	1121	2	2	\N
567	1779-09-01	Mercredi	1779-1780	138		Arrêté par nous Semainiers la Recette de ce jour 1 7bre mil sept cent soixante - 79 montant à la somme de dix nuit cent quatre livres.	1804	0	138	Bellemont			f	f	\N	\N	1752	2	2	\N
582	1779-09-15	Mercredi	1779-1780	151		Arrêté par nous Semainiers la Recette de ce jour 15 7bre mil sept cent soixante - 79 montant à la somme de deux mille trente trois livres dix sols.	2033	10	151	Florence			f	f	\N	\N	1765	2	2	\N
589	1779-09-22	Mercredi	1779-1780	158		Arrêté par nous Semainiers la Recette de ce jour 22 7bre mil sept cent soixante - 79 montant à la somme de deux mille trois cent dix huit livres quinze sols.	2318	15	158	Florence			f	f	\N	\N	1772	2	2	\N
600	1779-10-03	Dimanche	1779-1780	169		Arrêté par nous Semainiers la Recette de ce jour 3 8bre mil sept cent soixante - 79 montant à la somme de deux mille quarante livres.	2040	0	169	Vanhove			f	f	\N	\N	1783	2	2	\N
607	1779-10-10	Dimanche	1779-1780	176		Arrêté par nous Semainiers la Recette de ce jour 10 8bre mil sept cent soixante - 79 montant à la somme de dix huit cent quatre vingt quinze livres.	1895	0	176	Vanhove			f	f	\N	\N	1790	2	2	\N
614	1779-10-17	Dimanche	1779-1780	183		Arrêté par nous Semainiers la Recette de ce jour 17 8bre mil sept cent soixante - 79 montant à la somme de deux mille trente livres.	2030	0	183	Vanhove			f	f	\N	\N	1797	2	2	\N
622	1779-10-24	Dimanche	1779-1780	190		Arrêté par nous Semainiers la Recette de ce jour 24 8bre mil sept cent soixante - 79 montant à la somme de seize cent trente cinq livres.	1653	0	190	Vanhove			f	f	\N	\N	1804	2	2	\N
599	1779-10-28	Samedi	1779-1780	168	un balance d'auteur à Louhertre - 6 livres 	Arrêté par nous Semainiers la Recette de ce jour 2 8bre_ mil sept cent soixante - 79 montant à la somme de dix huit cent quatre vingt dix neuf livres.	1899	0	168	Vanhove		Not entirely sure I have correctly transcribed the irregular payment notes correctly.	f	f	\N	\N	1782	2	2	\N
606	1779-10-09	Samedi	1779-1780	175		Arrêté par nous Semainiers la Recette de ce jour 9 8bre mil sept cent soixante - 79 montant à la somme de quinze cent soixante dix sept livres.	1577	0	175	Vanhove			f	f	\N	\N	1789	2	2	\N
613	1779-10-16	Samedi	1779-1780	182	Un billet d'auteur de de personnes aux 3ème - 4 livres.	Arrêté par nous Semainiers la Recette de ce jour 16 8bre mil sept cent soixante - 79 montant à la somme de mille vingt huit livres.	1028	0	182	Vanhove			f	f	\N	\N	1796	2	2	\N
621	1779-10-23	Samedi	1779-1780	189		Arrêté par nous Semainiers la Recette de ce jour 23 8bre mil sept cent soixante - 79 montant à la somme de seize cent soixante sept livres.	1667	0	189	Vanhove			f	f	\N	\N	1803	2	2	\N
602	1779-10-05	Mardi	1779-1780	171		Arrêté par nous Semainiers la Recette de ce jour 5 8bre mil sept cent soixante - 79 montant à la somme de trois cent soixante onze livres.	371	0	171	Vanhove			f	f	\N	\N	1785	2	2	\N
609	1779-10-12	Mardi	1779-1780	178		Arrêté par nous Semainiers la Recette de ce jour 12 8bre mil sept cent soixante - 79 montant à la somme de cinq cent quatre vingt une livres.	581	0	178	Vanhove			f	f	\N	\N	1792	2	2	\N
617	1779-10-19	Mardi	1779-1780	185		Arrêté par nous Semainiers la Recette de ce jour 19 8bre mil sept cent soixante - 79 montant à la somme de quatre cent soixante quatre livres dix sols.	464	10	185	Vanhove			f	f	\N	\N	1799	2	2	\N
618	1779-10-20	Mardi	1779-1780	186		Arrêté par nous Semainiers la Recette de ce jour 20 8bre mil sept cent soixante -79 montant à la somme de douze cent cinquante livres.	1250	0	186	Vanhove			f	f	\N	\N	1800	2	2	\N
601	1779-10-04	Lundi	1779-1780	170	une bille de 2 personnes aux 3ème pour Lauteno? - 4 livres	Arrêté par nous Semainiers la Recette de ce jour 4 8bre mil sept cent soixante - 79 montant à la somme de neuf cent vingt neuf livres.	929	0	170	Vanhove		Not sure if I correctly transcribed the irregular payment notes.	f	f	\N	\N	1784	2	2	\N
608	1779-10-11	Lundi	1779-1780	177		Arrêté par nous Semainiers la Recette de ce jour 11 8bre mil sept cent soixante - 79 montant à la somme de mille quarante cinq livres.	1045	0	177	Vanhove			f	f	\N	\N	1791	2	2	\N
615	1779-10-18	Lundi	1779-1780	184		Arrêté par nous Semainiers la Recette de ce jour 18 8bre mil sept cent soixante - 79 montant à la somme de seize cent quarante trois livres.	1643	0	184	Vanhove			f	f	\N	\N	1798	2	2	\N
623	1779-10-25	Lundi	1779-1780	191		Arrêté par nous Semainiers la Recette de ce jour 25 8bre mil sept cent soixante - 79 montant à la somme de deux mille cent soixante neuf livres.	2169	0	191	Vanhove			f	f	\N	\N	1805	2	2	\N
597	1779-09-30	Jeudi	1779-1780	166		Arrêté par nous Semainiers la Recette de ce jour 30 7bre mil sept cent soixante - 79 montant à la somme de trois cent quatre vingt sept livres.	387	0	166	Florence			f	f	\N	\N	1780	2	2	\N
604	1779-10-07	Jeudi	1779-1780	173		Arrêté par nous Semainiers la Recette de ce jour 7 8bre mil sept cent soixante - 79 montant à la somme de huit cent quarante neuf livres.	849	0	173	Vanhove			f	f	\N	\N	1787	2	2	\N
611	1779-10-14	Jeudi	1779-1780	180		Arrêté par nous Semainiers la Recette de ce jour 17 8bre mil sept cent soixante - 79 montant à la somme de huit cent soixante livres.	860	0	180	Vanhove			f	f	\N	\N	1794	2	2	\N
619	1779-10-21	Jeudi	1779-1780	187		Arrêté par nous Semainiers la Recette de ce jour 21 8bre mil sept cent soixante - 79 montant à la somme de cinq cent quarante trois livres.	543	0	187	Vanhove			f	f	\N	\N	1801	2	2	\N
596	1779-09-29	Mercredi	1779-1780	165		Arrêté par nous Semainiers la Recette de ce jour 29 7bre mil sept cent soixante - 79 montant à la somme de dix huit cent quarante huit livres.	1848	0	165	Florence			f	f	\N	\N	1779	2	2	\N
603	1779-10-06	Mercredi	1779-1780	172	un billet de 2 personnes au 3eme L?	Arrêté par nous Semainiers la Recette de ce jour 6 8bre mil sept cent soixante - 79 montant à la somme de treize cent quarante trois livres.	1343	0	172	Vanhove		Can't make out all of the irregular payment notes.	f	f	\N	\N	1786	2	2	\N
610	1779-10-13	Mercredi	1779-1780	179		Arrêté par nous Semainiers la Recette de ce jour 13 8bre mil sept cent soixante - 79 montant à la somme de onze cent quatre vingt seize livres.	1196	0	179	Vanhove			f	f	\N	\N	1793	2	2	\N
629	1779-10-31	Dimanche	1779-1780	197		Arrêté par nous Semainiers la Recette de ce jour 31 8bre mil sept cent soixante - soixante dix neuf montant à la somme de quinze cent quatre vingt dix huit livres.	1598	0	197	Vanhove			f	f	\N	\N	1811	2	2	\N
635	1779-11-07	Dimanche	1779-1780	203		Arrêté par nous Semainiers la Recette de ce jour 7 9bre mil sept cent soixante - 79 montant à la somme de deux mille trois cent cinquante trois livres quinzes sols.	2353	15	203	Préville			f	f	\N	\N	1817	2	2	\N
642	1779-11-14	Dimanche	1779-1780	210		Arrêté par nous Semainiers la Recette de ce jour 14 9bre mil sept cent soixante - 79 montant à la somme de deux mille quatre cent quarante deux livres dix sols.	2442	10	210	Préville			f	f	\N	\N	1824	2	2	\N
650	1779-11-21	Dimanche	1779-1780	217		Arrêté par nous Semainiers la Recette de ce jour 21 9bre mil sept cent soixante - 79 montant à la somme de douze cent quarante cinq livres.	1245	0	217	Préville			f	f	\N	\N	1832	2	2	\N
657	1779-11-28	Dimanche	1779-1780	224		Arrêté par nous Semainiers la Recette de ce jour 28 9bre mil sept cent soixante - 79 montant à la somme de quatorze cent vingt deux livres.	1422	0	224	Préville			f	f	\N	\N	1839	2	2	\N
628	1779-10-30	Samedi	1779-1780	196		Arrêté par nous Semainiers la Recette de ce jour trente octobre mil sept cent soixante - soixante dix neuf montant à la somme de dix neuf cent quatre vingt une livres.	1981	0	196	Vanhove			f	f	\N	\N	1810	2	2	\N
634	1779-11-06	Samedi	1779-1780	202		Arrêté par nous Semainiers la Recette de ce jour 6 9bre mil sept cent soixante - 79 montant à la somme de seize cent quatre vingt sept livres.	1687	0	202	Préville			f	f	\N	\N	1816	2	2	\N
641	1779-11-13	Samedi	1779-1780	209		Arrêté par nous Semainiers la Recette de ce jour 13 9bre mil sept cent soixante - 79 montant à la somme de douze cent soixante huit livres.	1268	0	209	Préville			f	f	\N	\N	1823	2	2	\N
649	1779-11-20	Samedi	1779-1780	216		Arrêté par nous Semainiers la Recette de ce jour 20 9bre mil sept cent soixante - 79 montant à la somme de dix deux cent cinquante cinq livres.	1955	0	216	Préville			f	f	\N	\N	1831	2	2	\N
637	1779-11-09	Mardi	1779-1780	205		Arrêté par nous Semainiers la Recette de ce jour 9 9bre mil sept cent soixante - 79 montant à la somme de trois cent cinquante sept livres dix sols.	357	10	205	Préville			f	f	\N	\N	1819	2	2	\N
644	1779-11-16	Mardi	1779-1780	212		Arrêté par nous Semainiers la Recette de ce jour 16 9bre mil sept cent soixante - 79 montant à la somme de trois cent quarante une livres dix sols.	341	10	212	Préville			f	f	\N	\N	1826	2	2	\N
652	1779-11-23	Mardi	1779-1780	219		Arrêté par nous Semainiers la Recette de ce jour 23 9bre mil sept cent soixante - 79 montant à la somme de deux cent cinquante trois livres dix sols.	253	10	219	Préville			f	f	\N	\N	1834	2	2	\N
636	1779-11-08	Lundi	1779-1780	204		Arrêté par nous Semainiers la Recette de ce jour 8 9bre mil sept cent soixante - 79 montant à la somme de quatorze cent cinquante trois livres.	1453	0	204	Préville			f	f	\N	\N	1818	2	2	\N
643	1779-11-15	Lundi	1779-1780	211		Arrêté par nous Semainiers la Recette de ce jour 25 9bre mil sept cent soixante - 79 montant à la somme de onze cent soixante douze livres.	1172	0	211	Préville			f	f	\N	\N	1825	2	2	\N
651	1779-11-22	Lundi	1779-1780	218		Arrêté par nous Semainiers la Recette de ce jour 22 9bre mil sept cent soixante - 79 montant à la somme de mille soixante quinze livres.	1075	0	218	Préville			f	f	\N	\N	1833	2	2	\N
626	1779-10-28	Jeudi	1779-1780	194		Arrêté par nous Semainiers la Recette de ce jour 28 8bre mil sept cent soixante - 79 montant à la somme de six cent quarante huit livres.	648	0	194	Vanhove			f	f	\N	\N	1808	2	2	\N
632	1779-11-04	Jeudi	1779-1780	200		Arrêté par nous Semainiers la Recette de ce jour 4 9bre mil sept cent soixante - 79 montant à la somme de cinq cent cinq livres.	505	0	200	Préville			f	f	\N	\N	1814	2	2	\N
639	1779-11-11	Jeudi	1779-1780	207		Arrêté par nous Semainiers la Recette de ce jour 11 9bre mil sept cent soixante - 79 montant à la somme de on´cent soixante seize livres.	1176	0	207	Préville			f	f	\N	\N	1821	2	2	\N
646	1779-11-18	Jeudi	1779-1780	214		Arrêté par nous Semainiers la Recette de ce jour 18 9bre mil sept cent soixante - 79 montant à la somme de quatre cent quatre vingt neuf livres.	489	0	214	Préville			f	f	\N	\N	1828	2	2	\N
654	1779-11-25	Jeudi	1779-1780	221		Arrêté par nous Semainiers la Recette de ce jour 25 9bre mil sept cent soixante - 79 montant à la somme de cinq cent soixante quatre livres.	564	0	221	Préville			f	f	\N	\N	1836	2	2	\N
625	1779-10-27	Mercredi	1779-1780	193		Arrêté par nous Semainiers la Recette de ce jour 27 8bre mil sept cent soixante - 79 montant à la somme de dix huit cent deux livres.	1822	0	193	Vanhove			f	f	\N	\N	1807	2	2	\N
631	1779-11-03	Mercredi	1779-1780	199		Arrêté par nous Semainiers la Recette de ce jour 3 9bre mil sept cent soixante - 79 montant à la somme de quinze cent vingt six livres.	1526	0	199	Préville			f	f	\N	\N	1813	2	2	\N
638	1779-11-10	Mercredi	1779-1780	206		Arrêté par nous Semainiers la Recette de ce jour 10 9bre mil sept cent soixante - 79 montant à la somme de seize cent soixante une livres.	1661	0	206	Préville			f	f	\N	\N	1820	2	2	\N
645	1779-11-17	Mercredi	1779-1780	213		Arrêté par nous Semainiers la Recette de ce jour 17 9bre mil sept cent soixante - 79 montant à la somme de quinze cent quatre vingt dix huit livres.	1598	0	213	Préville			f	f	\N	\N	1827	2	2	\N
653	1779-11-24	Mercredi	1779-1780	220		Arrêté par nous Semainiers la Recette de ce jour 24 9bre mil sept cent soixante - 79 montant à la somme de mille soixante neuf livres.	1069	0	220	Préville			f	f	\N	\N	1835	2	2	\N
682	1778-12-20	Dimanche	1778-1779	233		Arrêté par nous Semainiers la Recette de ce jour 20 Xbre mil sept cent soixante - dix huit montant à la somme de deux mille cent soixante onze livres quinze sols.	2171	15	233	Dazincourt			f	f	\N	\N	1864	2	2	\N
687	1778-12-27	Dimanche	1778-1779	238		Arrêté par nous Semainiers la Recette de ce jour 27 Xbre mil sept cent soixante - dix huit montant à la somme de deux mille deux cent dix neuf livres quinze sols.	2219	15	238	Dazincourt			f	f	\N	\N	1869	2	2	\N
659	1779-11-30	Mardi	1779-1780	226		Arrêté par nous Semainiers la Recette de ce jour 30 9bre mil sept cent soixante - 79 montant à la somme de quatre cent sept livres dix sols.	407	10	226	Préville			f	f	\N	\N	1841	2	2	\N
658	1779-11-29	Lundi	1779-1780	225		Arrêté par nous Semainiers la Recette de ce jour 29 9bre mil sept cent soixante - 79 montant à la somme de douze cent deux livres.	1202	0	225	Préville			f	f	\N	\N	1840	2	2	\N
680	1778-12-17	Jeudi	1778-1779	230		Arrêté par nous Semainiers la Recette de ce jour 17 Xbre mil sept cent soixante - dix huit montant à la somme de quatre cent soixante huit livres.	468	0	230	Dazincourt			f	f	\N	\N	1862	2	2	\N
700	1779-12-10	Vendredi	1779-1780	235		Arrêté par nous Semainiers la Recette de ce jour 10 Xbre mil sept cent soixante - 79 montant à la somme de six cent vingt trois livres.	623	0	235	Préville			f	f	\N	\N	1887	2	2	\N
707	1779-12-17	Vendredi	1779-1780	242		Arrêté par nous Semainiers la Recette de ce jour 17 Xbre mil sept cent soixante - 79 montant à la somme de sept cent cinquante livres dix sols.	750	10	242	Préville			f	f	\N	\N	1894	2	2	\N
701	1779-12-11	Samedi	1779-1780	236		Arrêté par nous Semainiers la Recette de ce jour 11 Xbre mil sept cent soixante - 79 montant à la somme de treize cent quatre vingt quatre livres.	1384	0	236	Préville			f	f	\N	\N	1888	2	2	\N
708	1779-12-18	Samedi	1779-1780	243		Arrêté par nous Semainiers la Recette de ce jour 18 Xbre mil sept cent soixante - 79 montant à la somme de deux mille dix sept livres.	2017	0	243	Préville			f	f	\N	\N	1895	2	2	\N
694	1779-11-30	Mardi	1779-1780	226		Arrêté par nous Semainiers la Recette de ce jour 30 9bre mil sept cent soixante - 79 montant à la somme de quatre cent sept livres dix sols.	407	10	226	Préville			f	f	\N	\N	1876	2	2	\N
697	1779-12-07	Mardi	1779-1780	233		Arrêté par nous Semainiers la Recette de ce jour 7 Xbre mil sept cent soixante - 79 montant à la somme de trois cent quarante sept livres.	347	0	233	Préville			f	f	\N	\N	1883	2	2	\N
696	1779-12-02	Jeudi	1779-1780	228		Arrêté par nous Semainiers la Recette de ce jour 2 Xbre mil sept cent soixante - 79 montant à la somme de quatre cent soixante livres.	460	0	228	Préville			f	f	\N	\N	1878	2	2	\N
706	1779-12-16	Jeudi	1779-1780	241		Arrêté par nous Semainiers la Recette de ce jour 16 Xbre mil sept cent soixante - 79 montant à la somme de quatre cent quatre vingt livres.	480	0	241	Préville			f	f	\N	\N	1893	2	2	\N
691	1779-12-01	Mercredi	1779-1780	227	un billet de M. Dorat à l'orchestre - 6 livres.	Arrêté par nous Semainiers la Recette de ce jour 1 Xbre mil sept cent soixante - 79 montant à la somme de deux mille six cent soixante douze livres.	2672	0	227	Préville			f	f	\N	\N	1873	2	2	\N
705	1779-12-15	Mercredi	1779-1780	240	2 Billets de 2 personnes chacun de l'auteur aux trois? (Can't quite make out the last word)	Arrêté par nous Semainiers la Recette de ce jour 15 Xbre mil sept cent soixante - 79 montant à la somme de onze cent vingt neuf livres.	1129	0	240	Préville		can't make out the last work in the irregular payments section.	f	f	\N	\N	1892	2	2	\N
331	1778-05-04	Lundi	1778-1779	12		Arrêté par nous Semainiers la Recette de ce jour 4 May mil sept cent soixante - dix huit montant à la somme de dix huit cent dix huit livres.	1818	0	12	Brizard			f	f	\N	\N	1226	2	2	\N
335	1778-05-08	Lundi	1778-1779	16	Addition mistake.	Arrêté par nous Semainiers la Recette de ce jour 8 May mil sept cent soixante - dix huit montant à la somme de huit cent cinquante quatre livres dix sous.	854	10	16	Brizard			f	f	\N	\N	1230	2	2	\N
302	1780-02-18	Vendredi	1779-1780	301		Arrêté par nous Semainiers la Recette de ce jour 18 fev mil sept cent 80 montant à la somme de mille soixante deux livres et dix sols. 	1062	10	301			Can't read signatory.	f	f	\N	\N	1540	2	2	\N
61	1778-01-02	Vendredi	1777-1778	259	Discrepancy between calculated and recorded totals.	Arrêté par nous Semainiers la Recette de ce jour 2 Janvier mil sept cent soixante - dix huit montant à la somme de cinq cent quarante trois livres.	543	0	259	DesEssarts			f	f	\N	\N	737	2	2	\N
70	1778-01-09	Vendredi	1777-1778	266		Arrêté par nous Semainiers la Recette de ce jour 9 janvier mil sept cent soixante - dix huit montant à la somme de cinq cent soixante quatre livres	564	0	266	DesEssarts			f	f	\N	\N	744	2	2	\N
77	1778-01-16	Vendredi	1777-1778	273		Arrêté par nous Semainiers la Recette de ce jour 16 janvier mil sept cent soixante - dix huit montant à la somme de neuf cent cinquante six livres	956	0	273	DesEssarts			f	f	\N	\N	752	2	2	\N
84	1778-01-23	Vendredi	1777-1778	280		Arrêté par nous Semainiers la Recette de ce jour 23 janvier mil sept cent soixante - dix huit montant à la somme de sept cent seize livres dix sols	716	10	280	DesEssarts			f	f	\N	\N	759	2	2	\N
91	1778-01-30	Vendredi	1777-1778	287		Arrêté par nous Semainiers la Recette de ce jour 30 janvier mil sept cent soixante - dix huit montant à la somme de six cent quarante une livres	641	0	287	DesEssarts			f	f	\N	\N	766	2	2	\N
93	1779-01-01	Vendredi	1778-1779	242	There is what seems to be a miscalculation in the final tally, and 1991 was corrected to the correct value of 1691.  However, this was not accounted for in the page text, which still reads for 1991.	Arrêté par nous Semainiers la Recette de ce jour 1er janvier mil sept cent soixante - dix neuf montant à la somme de dix neuf cent quatre vingt onze livres.	1691	0	242	Bouret	Play title is not in the database.		f	f	\N	\N	1131	2	2	\N
106	1779-01-15	Vendredi	1778-1779	255		Arrêté par nous Semainiers la Recette de ce jour 15 janvier mil sept cent soixante - dix neuf montant à la somme de six cent cinquante sept livres dix sous.	657	10	255	Bouret			f	f	\N	\N	1144	2	2	\N
117	1780-01-07	Vendredi	1779-1780	260		Arrêté par nous Semainiers la Recette de ce jour 7 janvier mil sept cent 80 montant à la somme de mille quatre vingt quatre livres.	1084	0	260	Sréville		Unsure of signatory name.	f	f	\N	\N	1497	2	2	\N
133	1780-01-14	Vendredi	1779-1780	267		Arrêté par nous Semainiers la Recette de ce jour 14 janvier mil sept cent 80 montant à la somme de cinq cent quatre-vingt livres.	580	0	267	Sréville 		First play "Orphelin anglais " is not in drop down	f	f	\N	\N	1504	2	2	\N
140	1780-01-21	Vendredi	1779-1780	274		Arrêté par nous Semainiers la Recette de ce jour 21 janvier mil sept cent 80 montant à la somme de neuf cent quatre vingt dix livres.	990	0	274	Sréville 		Jodelet ou le Maître valet  - first play - is not on the drop down menu	f	f	\N	\N	1511	2	2	\N
147	1780-01-28	Vendredi	1779-1780	281		Arrêté par nous Semainiers la Recette de ce jour 28 janvier mil sept cent 80 montant à la somme de cinq cent soixante six livres dix sols.	566	10	281	Sréville 		Can't read title of first play	f	f	\N	\N	1518	2	2	\N
156	1780-02-04	Vendredi	1779-1780	287		Arrêté par nous Semainiers la Recette de ce jour 4 février mil sept cent 80 montant à la somme de mille quatre vingt dix huit livres. 	1098	0	287	Courette		Can't read first play title\r\ncan't read second play title	f	f	\N	\N	1525	2	2	\N
172	1779-01-29	Vendredi	1778-1779	269		Arrêté par nous Semainiers la Recette de ce jour 29 janvier mil sept cent soixante - dix neuf montant à la somme de six cent soixante sept livres.	667	0	269	Bouret			f	f	\N	\N	1159	2	2	\N
178	1779-02-05	Vendredi	1778-1779	275		Arrêté par nous Semainiers la Recette de ce jour 5 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille soixante quatre vingt livres dix sous.	2680	10	275	De Bellesour	Only play performed was Les Muses Rivales.  Something going on with a new actor/actress?		f	f	\N	\N	1165	2	2	\N
185	1779-02-12	Vendredi	1778-1779	282		Arrêté par nous Semainiers la Recette de ce jour 12 fevrier mil sept cent soixante - dix neuf montant à la somme de douze cent vingt six livres dix sous.	1226	10	282	De Bellecour	Second play not listed.		f	f	\N	\N	1172	2	2	\N
206	1779-02-26	Vendredi	1778-1779	296		Arrêté par nous Semainiers la Recette de ce jour 26 fevrier mil sept cent soixante - dix neuf montant à la somme de huit cent trente livres.	830	0	296	De Bellecour		First actor/actress (can't read)	f	f	\N	\N	1187	2	2	\N
209	1778-02-06	Vendredi	1777-1778	293		Arrêté par nous Semainiers la Recette de ce jour 6 février mil sept cent soixante - dix huit montant à la somme de onze mille cent quatre vingt trois livres	1183	0	293	Des Essarts		Addition incorrect.	f	f	\N	\N	773	2	2	\N
216	1778-02-13	Vendredi	1777-1778	299		Arrêté par nous Semainiers la Recette de ce jour 13 févriermil sept cent soixante - dix huit montant à la somme de neuf cent vingt sept livres	927	0	299	Des Essarts			f	f	\N	\N	779	2	2	\N
219	1779-02-19	Vendredi	1778-1779	289		Arrêté par nous Semainiers la Recette de ce jour 19 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille quatre cent vingt une livres.	2421	0	289	De Bellecour			f	f	\N	\N	1180	2	2	\N
231	1779-03-12	Vendredi	1778-1779	310		Arrêté par nous Semainiers la Recette de ce jour 12 mars mil sept cent soixante - dix neuf montant à la somme de huit cent quarante six livres dix sous.	846	10	310			Cannot make out signatory and some actor/role notes.	f	f	\N	\N	1201	2	2	\N
238	1778-02-20	Vendredi	1777-1778	306		Arrêté par nous Semainiers la Recette de ce jour 20 février mil sept cent soixante - dix huit montant à la somme de onze cent quatre vingt dix livres dix sols	1190	10	306	DesEssarts			f	f	\N	\N	787	2	2	\N
245	1778-02-27	Vendredi	1777-1778	313		Arrêté par nous Semainiers la Recette de ce jour 27 février mil sept cent soixante - dix huit montant à la somme de onze cent vingt trois livres	1123	0	313	DesEssarts			f	f	\N	\N	794	2	2	\N
252	1778-03-06	Vendredi	1777-1778	320		Arrêté par nous Semainiers la Recette de ce jour 6 mars mil sept cent soixante - dix huit montant à la somme de douze cent trente cinq livres	1235	0	320		No signatory this day		f	f	\N	\N	801	2	2	\N
259	1778-03-13	Vendredi	1777-1778	327		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	920	0	327		No bottom entry, no signatory.		f	f	\N	\N	808	2	2	\N
265	1778-03-20	Vendredi	1777-1778	333		Arrêté par nous Semainiers la Recette de ce jour 20 mars mil sept cent soixante - dix huit montant à la somme de douze cent vingt huit livres	1228	0	333		No signatory		f	f	\N	\N	814	2	2	\N
296	1780-02-11	Vendredi	1779-1780	294		Arrêté par nous Semainiers la Recette de ce jour 11 fev  mil sept cent 80 montant à la somme de six cent quarante huit livres dix sols.	648	10	294			Cannot read signatory.	f	f	\N	\N	1533	2	2	\N
317	1779-12-31	Vendredi	1779-1780	253		Arrêté par nous Semainiers la Recette de ce jour 31 Xbre mil sept cent 80 montant à la somme de quatre cent trente et une livres dix sols.	431	10	253	Créssville			f	f	\N	\N	1906	2	2	\N
328	1778-05-01	Vendredi	1778-1779	9		Arrêté par nous Semainiers la Recette de ce jour 1er May mil sept cent soixante - dix huit montant à la somme de mille quarante six livres.	1046	0	9	Brizard			f	f	\N	\N	1223	2	2	\N
342	1778-05-15	Vendredi	1778-1779	23		Arrêté par nous Semainiers la Recette de ce jour 15 May mil sept cent soixante - dix huit montant à la somme de neuf cent livres dix sous.	900	10	23	Brizard			f	f	\N	\N	1237	2	2	\N
356	1779-12-03	Vendredi	1779-1780	229		Arrêté par nous Semainiers la Recette de ce jour 3 xbre mil sept cent soixante -79 montant à la somme de six cent vingt huit livres.	628	0	229	Préville			f	f	\N	\N	1879	2	2	\N
363	1780-02-11	Vendredi	1779-1780	294		Arrêté par nous Semainiers la Recette de ce jour 11 fev mil sept cent 80 montant à la somme de six cent quarante huit livres dix sols.	648	10	294	Cournette			f	f	\N	\N	1559	2	2	\N
375	1780-02-25	Vendredi	1779-1780	308		Arrêté par nous Semainiers la Recette de ce jour 25 fev mil sept cent 80 montant à la somme de quatre cent quatre vingt quinze livres.	495	0	308	Cournette			f	f	\N	\N	1573	2	2	\N
382	1780-03-03	Vendredi	1779-1780	315		Arrêté par nous Semainiers la Recette de ce jour 3 mars mil sept cent 80 montant à la somme de cinq cent soixante dix huit livres.	578	0	315	Cournette			f	f	\N	\N	1580	2	2	\N
420	1779-04-16	Vendredi	1779-1780	5		Arrêté par nous Semainiers la Recette de ce jour 16 avril mil sept cent soixante -dix neuf montant à la somme de huit cent trente neuf livres.	839	0	5	Dazincourt			f	f	\N	\N	1618	2	2	\N
431	1779-04-23	Vendredi	1779-1780	12		Arrêté par nous Semainiers la Recette de ce jour 23 avril mil sept cent soixante -dix  neuf montant à la somme de huit cent trente livres dix sols.	830	10	12	Dazincourt			f	f	\N	\N	1625	2	2	\N
438	1779-04-30	Vendredi	1779-1780	19		Arrêté par nous Semainiers la Recette de ce jour 30 avril mil sept cent soixante - dix neuf montant à la somme de huit cent cinq livres dix sols.	805	10	19	Dazincourt			f	f	\N	\N	1632	2	2	\N
445	1779-05-07	Vendredi	1779-1780	26		Arrêté par nous Semainiers la Recette de ce jour 7 may mil sept cent soixante -79 montant à la somme de neuf cent sept livres dix sols.	907	10	26	Courville			f	f	\N	\N	1639	2	2	\N
451	1779-05-14	Vendredi	1779-1780	32		Arrêté par nous Semainiers la Recette de ce jour 14 may mil sept cent soixante -79 montant à la somme de onze cent quatre vingt sept livres.	1187	0	32	Courville			f	f	\N	\N	1645	2	2	\N
457	1779-05-21	Vendredi	1779-1780	38		Arrêté par nous Semainiers la Recette de ce jour 21 may mil sept cent soixante - 79 montant à la somme de quatre cent quatre vingt huit livres dix sols.	488	10	38	Courville			f	f	\N	\N	1651	2	2	\N
464	1779-05-28	Vendredi	1779-1780	44	The secondes places have been incorrectly calculated. 29*3 = 87	Arrêté par nous Semainiers la Recette de ce jour 28 may mil sept cent soixante - 79 montant à la somme de quatre cent onze livres.	411	0	44	Courville			f	f	\N	\N	1657	2	2	\N
472	1779-06-04	Vendredi	1779-1780	50		Arrêté par nous Semainiers la Recette de ce jour 4 juin mil sept cent soixante -79 montant à la somme de six cent seize livres.	616	0	50	Dorivas			f	f	\N	\N	1663	2	2	\N
479	1779-06-11	Vendredi	1779-1780	57		Arrêté par nous Semainiers la Recette de ce jour 11 Juin mil sept cent soixante -79 montant à la somme de mille trente sept livres dix sols.	1037	10	57	Dorivas			f	f	\N	\N	1670	2	2	\N
504	1779-07-02	Vendredi	1779-1780	78		Arrêté par nous Semainiers la Recette de ce jour 2 Juillet mil sept cent soixante -79 montant à la somme de quatre cent dix livres.	410	0	78	Dorivas			f	f	\N	\N	1691	2	2	\N
512	1779-07-09	Vendredi	1779-1780	85		Arrêté par nous Semainiers la Recette de ce jour 9 Juillet mil sept cent soixante - 79 montant à la somme de dix huit cent vingt livres.	1920	0	85	Dorival			f	f	\N	\N	1698	2	2	\N
519	1779-07-16	Vendredi	1779-1780	92		Arrêté par nous Semainiers la Recette de ce jour 16 Juillet mil sept cent soixante - 79 montant à la somme de deux cent soixante dix sept livres.	277	0	92	Dorival		Not entirely sure if first play is correct - there are many  "Amants Brouillés" and none of them seem to be played during this year according to CESAR. I picked the one which looked the most promising.\r\n\r\n	f	f	\N	\N	1705	2	2	\N
526	1779-07-23	Vendredi	1779-1780	99		Arrêté par nous Semainiers la Recette de ce jour 22 Juillet mil sept cent soixante - 79 montant à la somme de six cent trois livres.	603	0	99	Dorival		First play does not specify what "La Coquette" is being played.	f	f	\N	\N	1712	2	2	\N
533	1779-07-30	Vendredi	1779-1780	106		Arrêté par nous Semainiers la Recette de ce jour 30 Juillet mil sept cent soixante - 79 montant à la somme de quatre cent une livres dix sols.	401	10	106	Dorival			f	f	\N	\N	1719	2	2	\N
540	1779-08-06	Vendredi	1779-1780	113		Arrêté par nous Semainiers la Recette de ce jour 6 Aout mil sept cent soixante - 79 montant à la somme de huit cent quatre vingt dix huit livres dix sols.	898	10	113	Bellemont			f	f	\N	\N	1726	2	2	\N
547	1779-08-13	Vendredi	1779-1780	120		Arrêté par nous Semainiers la Recette de ce jour 13 Aout mil sept cent soixante - 79 montant à la somme de sept cent vingt livres.	720	0	120	Bellemont			f	f	\N	\N	1733	2	2	\N
554	1779-08-20	Vendredi	1779-1780	126		Arrêté par nous Semainiers la Recette de ce jour 20 aout mil sept cent soixante -79 montant à la somme de cinq cent quatre vingt trois livres.	583	0	126	Bellemont			f	f	\N	\N	1740	2	2	\N
561	1779-08-27	Vendredi	1779-1780	133		Arrêté par nous Semainiers la Recette de ce jour 27 aout mil sept cent soixante - 79 montant à la somme de trois cent vingt quatre livres.	324	0	133	Bellemont			f	f	\N	\N	1747	2	2	\N
570	1779-09-03	Vendredi	1779-1780	140		Arrêté par nous Semainiers la Recette de ce jour 3 7bre mil sept cent soixante - 79 montant à la somme de six cent vingt sept livres	627	0	140	Florence			f	f	\N	\N	1754	2	2	\N
576	1779-09-10	Vendredi	1779-1780	146		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	0	0	146			Spelling of the character played?	f	f	\N	\N	1760	2	2	\N
584	1779-09-17	Vendredi	1779-1780	153		Arrêté par nous Semainiers la Recette de ce jour 17 7bre mil sept cent soixante - 79 montant à la somme de trois cent trente livres.	330	0	153	Florence			f	f	\N	\N	1767	2	2	\N
591	1779-09-24	Vendredi	1779-1780	160		Arrêté par nous Semainiers la Recette de ce jour 24 7bre mil sept cent soixante - 79 montant à la somme de sept cent soixante douze livres dix sols.	772	10	160	Florence			f	f	\N	\N	1774	2	2	\N
598	1779-10-01	Vendredi	1779-1780	167		Arrêté par nous Semainiers la Recette de ce jour 1 8bre mil sept cent soixante - 79 montant à la somme de treize cent treize livres dix sols.	1313	10	167	Vanhove			f	f	\N	\N	1781	2	2	\N
605	1779-10-08	Vendredi	1779-1780	174		Arrêté par nous Semainiers la Recette de ce jour 8 8bre mil sept cent soixante - 79 montant à la somme de cinq cent soixante douze livres dix sols.	572	10	174	Vanhove			f	f	\N	\N	1788	2	2	\N
612	1779-10-15	Vendredi	1779-1780	181		Arrêté par nous Semainiers la Recette de ce jour 15 8bre mil sept cent soixante - 79 montant à la somme de deux mille deux cent trois livres dix sols.	2203	10	181	Vanhove			f	f	\N	\N	1795	2	2	\N
620	1779-10-22	Vendredi	1779-1780	188		Arrêté par nous Semainiers la Recette de ce jour 22 8bre mil sept cent soixante - 79 montant à la somme de six cent cinquante huit livres.	658	0	188	Vanhove			f	f	\N	\N	1802	2	2	\N
627	1779-10-29	Vendredi	1779-1780	195		Arrêté par nous Semainiers la Recette de ce jour 29 8bre mil sept cent soixante - 79 montant à la somme de cinq cent trente cinq livres dix sols.	535	10	195	Vanhove			f	f	\N	\N	1809	2	2	\N
633	1779-11-05	Vendredi	1779-1780	201		Arrêté par nous Semainiers la Recette de ce jour 5 9bre mil sept cent soixante - 79 montant à la somme de quarante cent trente huit livres.	438	0	201	Préville			f	f	\N	\N	1815	2	2	\N
640	1779-11-12	Vendredi	1779-1780	208		Arrêté par nous Semainiers la Recette de ce jour 12 9bre mil sept cent soixante - 79 montant à la somme de quatre cent trente neuf livres.	439	0	208	Préville			f	f	\N	\N	1822	2	2	\N
647	1779-11-19	Vendredi	1779-1780	215		Arrêté par nous Semainiers la Recette de ce jour 19 9bre mil sept cent soixante - 79 montant à la somme de cinq cent trente neuf livres dix sols.	539	10	215	Préville			f	f	\N	\N	1829	2	2	\N
704	1779-12-14	Mardi	1779-1780	239		Arrêté par nous Semainiers la Recette de ce jour 14 Xbre mil sept cent soixante - 79 montant à la somme de trois cent soixante cinq livres.	365	0	239	Préville			f	f	\N	\N	1891	2	2	\N
109	1780-01-01	Samedi	1779-1780	254		Arrêté par nous Semainiers la Recette de ce jour 1ère janvier mil sept cent 80 montant à la somme de deux mille quatre cent vingt livres.	2420	0	254	Créssville		Can't read second play title\r\n\r\nCan't read signatory name.	f	f	\N	\N	1489	2	2	\N
199	1779-02-20	Samedi	1778-1779	290		Arrêté par nous Semainiers la Recette de ce jour 20 fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille sept cent trente deux livres.	2732	0	290	De Bellecour			f	f	\N	\N	1181	2	2	\N
272	1778-03-28	Samedi	1777-1778	340		Arrêté par nous Semainiers la Recette de ce jour 28 mars mil sept cent soixante - dix huit montant à la somme de deux mille neuf cent quarante sept livres dix sols	2947	10	340		No signatory.		f	f	\N	\N	821	2	2	\N
287	1778-04-04	Samedi	1778-1779	4		Arrêté par nous Semainiers la Recette de ce jour 4 avril mil sept cent soixante - dix huit montant à la somme de deux mille huit cent quatre vingt sept livres dix sous.	2887	10	4	Brizard	Cloture		f	f	\N	\N	1218	2	2	\N
297	1780-02-12	Samedi	1779-1780	295		Arrêté par nous Semainiers la Recette de ce jour 12 fev mil sept cent 80 montant à la somme de deux mille deux cent dix-neuf livres dix sols. 	2219	10	295			Can't read signatory.	f	f	\N	\N	1534	2	2	\N
402	1780-03-04	Samedi	1779-1780	316		Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __	0	0	316			The second play: "Les Funerailles de Crispin" is not in CESAR.  Perhaps it is something else, but it certainly looks like that.	f	f	\N	\N	1600	2	2	\N
143	1780-01-24	Lundi	1779-1780	277		Arrêté par nous Semainiers la Recette de ce jour 24 janvier mil sept cent 80 montant à la somme de treize cent soixante dix sept livres.	1377	0	277	Sréville 		Could not read first or second play title.	f	f	\N	\N	1514	2	2	\N
151	1780-01-31	Lundi	1779-1780	284		Arrêté par nous Semainiers la Recette de ce jour 31 janvier mil sept cent 80 montant à la somme de onze cent cinquante six livres. 	1156	0	284	Sréville 		 | Check play, "Zélémide" is wrong title?	f	f	\N	\N	1521	2	2	\N
175	1779-02-01	Lundi	1778-1779	272		Arrêté par nous Semainiers la Recette de ce jour 1er fevrier mil sept cent soixante - dix neuf montant à la somme de deux mille trois cent trente neuf livres	2339	0	272	DeBellesour	Only play performed is Les Muses Rivales.		f	f	\N	\N	1162	2	2	\N
227	1779-03-08	Lundi	1778-1779	306		Arrêté par nous Semainiers la Recette de ce jour 8 Mars mil sept cent soixante - dix neuf montant à la somme de dix neuf cent quatre vingt quinze livres dix sous.	1995	10	306			Cannot make out signatory.	f	f	\N	\N	1197	2	2	\N
274	1778-03-30	Lundi	1777-1778	342		Arrêté par nous Semainiers la Recette de ce jour 30 mars mil sept cent soixante - dix huit montant à la somme de deux mille neuf cent soixante cinq livres dix sols	2965	10	342		No signatory		f	f	\N	\N	823	2	2	\N
564	1779-08-30	Lundi	1779-1780	136		Arrêté par nous Semainiers la Recette de ce jour 30 aout mil sept cent soixante - 79 montant à la somme de quinze cent livres.	1500	0	136	Bellemont			f	f	\N	\N	1750	2	2	\N
3345	1770-05-15	Mardi	1770-1771	15		\N	236	0	23				f	f	2012-09-17 07:24:22.86733	2013-01-05 12:52:51.466128	\N	2	5	Irregular Receipts
3346	1770-05-16	Mercredi	1770-1771	16		\N	944	0	24			Unsure which version of Médée	f	f	2012-09-17 07:24:22.892329	2013-01-05 12:55:46.265741	\N	2	5	Irregular Receipts
3350	1770-05-20	Dimanche	1770-1771	20		\N	882	0	28				f	f	2012-09-17 07:24:23.00909	2013-01-05 13:08:37.056859	\N	2	5	Irregular Receipts
3353	1770-05-23	Mercredi	1770-1771	23		\N	607	0	31				f	f	2012-09-17 07:24:23.084201	2013-01-05 13:15:00.317567	\N	2	5	Irregular Receipts
3354	1770-05-25	Vendredi	1770-1771	24		\N	840	0	32				f	f	2012-09-17 07:24:23.109139	2013-01-05 13:16:24.900213	\N	2	5	Irregular Receipts
3356	1770-05-27	Dimanche	1770-1771	26		\N	583	0	34				f	f	2012-09-17 07:24:23.159195	2013-01-05 13:22:10.42405	\N	2	5	Irregular Receipts
3357	1770-05-28	Lundi	1770-1771	27		\N	1324	0	35				f	f	2012-09-17 07:24:23.184146	2013-01-05 13:23:59.765147	\N	2	5	Irregular Receipts
3359	1770-05-30	Mercredi	1770-1771	29		\N	750	0	37			Check second play.	f	f	2012-09-17 07:24:23.234153	2013-01-05 13:26:36.368869	\N	2	5	Irregular Receipts
3362	1770-06-02	Samedi	1770-1771	2		\N	2221	0	40			First play not in database.	f	f	2012-09-17 07:24:23.309268	2013-01-06 11:16:45.264998	\N	2	5	Irregular Receipts
3363	1770-06-04	Lundi	1770-1771	3		\N	1912	0	41				f	f	2012-09-17 07:24:23.334262	2013-01-06 11:18:19.030733	\N	2	5	Irregular Receipts
3366	1770-06-07	Jeudi	1770-1771	6		\N	459	0	44				f	f	2012-09-17 07:24:23.409246	2013-01-06 11:27:07.05861	\N	2	5	Irregular Receipts
3367	1770-06-08	Vendredi	1770-1771	7		\N	454	10	45				f	f	2012-09-17 07:24:23.434254	2013-01-06 11:28:49.727842	\N	2	5	Irregular Receipts
3934	1772-04-28	Mardi	1772-1773	5		\N	547	0	5	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.761146	2013-01-05 18:45:19.756492	\N	2	5	Irregular Receipts
3935	1772-04-29	Mercredi	1772-1773	6		\N	1028	0	6	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.786131	2013-01-05 18:47:18.345676	\N	2	5	Irregular Receipts
3936	1772-04-30	Jeudi	1772-1773	7		\N	521	0	7	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.81121	2013-01-05 18:48:48.471937	\N	2	5	Irregular Receipts
3939	1772-05-03	Dimanche	1772-1773	10		\N	1719	10	3	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:38.886188	2013-01-05 18:53:56.085343	\N	2	5	Irregular Receipts
3942	1772-05-06	Mercredi	1772-1773	13		\N	2699	0	6	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.961182	2013-01-05 18:59:47.859976	\N	2	5	Irregular Receipts
3943	1772-05-07	Jeudi	1772-1773	14		\N	407	0	7	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.986165	2013-01-05 19:01:35.542406	\N	2	5	Irregular Receipts
3945	1772-05-09	Samedi	1772-1773	16		\N	1205	0	9	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.036173	2013-01-05 19:04:17.45657	\N	2	5	Irregular Receipts
3948	1772-05-12	Mardi	1772-1773	19		\N	289	10	12	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.111274	2013-01-05 19:07:22.788996	\N	2	5	Irregular Receipts
3950	1772-05-14	Jeudi	1772-1773	21		\N	922	0	14	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.161251	2013-01-05 19:10:26.308494	\N	2	5	Irregular Receipts
3952	1772-05-16	Samedi	1772-1773	23		\N	1559	0	16	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.211249	2013-01-05 19:12:39.198925	\N	2	5	Irregular Receipts
3954	1772-05-18	Lundi	1772-1773	25		\N	1188	0	18	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.261243	2013-01-05 19:16:20.929287	\N	2	5	Irregular Receipts
3956	1772-05-21	Jeudi	1772-1773	27		\N	769	0	20	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.311275	2013-01-05 19:22:10.167137	\N	2	5	Irregular Receipts
3958	1772-05-23	Samedi	1772-1773	29		\N	2288	5	22	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.361253	2013-01-05 19:25:05.278336	\N	2	5	Irregular Receipts
3960	1772-05-25	Lundi	1772-1773	31		\N	1058	0	24	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.411338	2013-01-05 19:27:06.56061	\N	2	5	Irregular Receipts
3963	1772-05-29	Vendredi	1772-1773	34		\N	273	0	27	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.486304	2013-01-05 19:30:37.092348	\N	2	5	Irregular Receipts
3965	1772-05-31	Dimanche	1772-1773	36		\N	589	0	29	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.536316	2013-01-05 19:34:46.665433	\N	2	5	Irregular Receipts
3967	1772-06-03	Mercredi	1772-1773	38		\N	2897	10	2	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:39.586311	2013-01-05 19:37:52.800313	\N	2	5	Irregular Receipts
3969	1772-06-05	Vendredi	1772-1773	40		\N	164	0	4	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.636298	2013-01-05 19:43:00.252974	\N	2	5	Irregular Receipts
3972	1772-06-09	Mardi	1772-1773	43		\N	422	0	7	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.711333	2013-01-05 20:40:54.14603	\N	2	5	Irregular Receipts
3974	1772-06-11	Jeudi	1772-1773	45		\N	485	0	9	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.761338	2013-01-05 20:45:20.916675	\N	2	5	Irregular Receipts
3976	1772-06-13	Samedi	1772-1773	47		\N	1420	15	11	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.811316	2013-01-05 20:47:30.205443	\N	2	5	Irregular Receipts
3978	1772-06-15	Lundi	1772-1773	49		\N	475	0	13	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.861332	2013-01-05 20:49:56.306381	\N	2	5	Irregular Receipts
3980	1772-06-17	Mercredi	1772-1773	51		\N	642	0	15	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.911304	2013-01-05 20:52:49.424016	\N	2	5	Irregular Receipts
3983	1772-06-21	Dimanche	1772-1773	54		\N	637	0	18	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.003137	2013-01-05 20:57:11.149399	\N	2	5	Irregular Receipts
3985	1772-06-24	Mercredi	1772-1773	56		\N	2357	0	20	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:40.05313	2013-01-05 21:03:54.027789	\N	2	5	Irregular Receipts
3987	1772-06-26	Vendredi	1772-1773	58		\N	92	10	22	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.103105	2013-01-05 21:07:54.784704	\N	2	5	Irregular Receipts
3989	1772-06-28	Dimanche	1772-1773	60		\N	253	0	24	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.153093	2013-01-05 21:10:39.492345	\N	2	5	Irregular Receipts
3993	1772-07-03	Vendredi	1772-1773	64		\N	155	10	3	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.253061	2013-01-06 04:08:50.565952	\N	2	5	Irregular Receipts
3995	1772-07-05	Dimanche	1772-1773	66		\N	321	0	5	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.303293	2013-01-06 04:10:33.026283	\N	2	5	Irregular Receipts
3997	1772-07-08	Mercredi	1772-1773	68		\N	861	0	7	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.353183	2013-01-06 04:12:43.911548	\N	2	5	Irregular Receipts
4000	1772-07-10	Samedi	1772-1773	71		\N	1270	0	10	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.42827	2013-01-06 04:15:48.43466	\N	2	5	Irregular Receipts
4002	1772-07-13	Lundi	1772-1773	73		\N	947	0	12	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.478163	2013-01-06 04:18:09.721828	\N	2	5	Irregular Receipts
4004	1772-07-16	Jeudi	1772-1773	75		\N	385	0	14	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.528177	2013-01-06 04:19:51.996585	\N	2	5	Irregular Receipts
4006	1772-07-18	Samedi	1772-1773	77		\N	677	0	16	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.578223	2013-01-06 04:22:23.484726	\N	2	5	Irregular Receipts
4008	1772-07-20	Lundi	1772-1773	79		\N	490	0	18	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.628275	2013-01-06 04:25:03.598996	\N	2	5	Irregular Receipts
4010	1772-07-23	Jeudi	1772-1773	81		\N	227	0	20	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.67832	2013-01-06 04:27:48.92874	\N	2	5	Irregular Receipts
4012	1772-07-25	Samedi	1772-1773	83		\N	1270	0	22	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.728188	2013-01-06 04:35:28.822395	\N	2	5	Irregular Receipts
4015	1772-07-29	Mercredi	1772-1773	86		\N	2090	15	25	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.803278	2013-01-06 04:40:08.19869	\N	2	5	Irregular Receipts
4017	1772-07-31	Vendredi	1772-1773	88		\N	125	0	27	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.853242	2013-01-06 04:41:53.057671	\N	2	5	Irregular Receipts
4019	1772-08-02	Dimanche	1772-1773	90		\N	704	0	2	Dauberval, Dalainval (?)	La Sérénade avec un divertisement		f	f	2012-09-17 07:24:40.903342	2013-01-06 04:44:12.331963	\N	2	5	Irregular Receipts
4022	1772-08-06	Jeudi	1772-1773	93		\N	258	0	5	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.978347	2013-01-06 04:50:08.364264	\N	2	5	Irregular Receipts
4024	1772-08-08	Samedi	1772-1773	95		\N	1816	10	7	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.028213	2013-01-06 04:52:50.672989	\N	2	5	Irregular Receipts
4026	1772-08-10	Lundi	1772-1773	97		\N	1828	0	9	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.0783	2013-01-06 04:54:46.753796	\N	2	5	Irregular Receipts
4028	1772-08-13	Jeudi	1772-1773	99		\N	358	0	11	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.128211	2013-01-06 04:56:53.252453	\N	2	5	Irregular Receipts
4030	1772-08-16	Dimanche	1772-1773	101		\N	716	0	13	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.178307	2013-01-06 17:15:19.24608	\N	2	5	Irregular Receipts
4032	1772-01-19	Mercredi	1772-1773	103		\N	1413	0	15	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.228293	2013-01-06 17:18:40.956461	\N	2	5	Irregular Receipts
4034	1772-08-21	Vendredi	1772-1773	105		\N	101	0	17	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.278414	2013-01-06 19:56:32.681941	\N	2	5	Irregular Receipts
4037	1772-08-24	Lundi	1772-1773	108		\N	2047	0	20	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.386589	2013-01-06 20:00:42.07388	\N	2	5	Irregular Receipts
4039	1772-08-26	Mercredi	1772-1773	110		\N	1548	0	22	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.436673	2013-01-06 20:02:53.528574	\N	2	5	Irregular Receipts
4041	1772-08-28	Vendredi	1772-1773	112		\N	196	0	24	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.486626	2013-01-06 20:04:46.403616	\N	2	5	Irregular Receipts
4043	1772-08-30	Dimanche	1772-1773	114		\N	590	0	26	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:41.53661	2013-01-06 20:07:18.889741	\N	2	5	Irregular Receipts
389	1780-03-10	Vendredi	1779-1780	322		Arrêté par nous Semainiers la Recette de ce jour 10 mars mil sept cent 80 montant à la somme de deux mille deux cent livres.	2200	0	322	Cournette			f	f	\N	\N	1587	2	2	\N
118	1780-01-08	Samedi	1779-1780	261		Arrêté par nous Semainiers la Recette de ce jour 8 janvier mil sept cent 80 montant à la somme de quatorze cent neuf livres. 	0	0	261	Sréville 			f	f	\N	\N	1498	2	2	\N
9200	1782-05-21	Mardi		41			3507	0	41	\N		Second play is not in database. Math is wrong for troisième loges à 6 places.	\N	\N	2013-01-05 10:48:09.89133	2013-01-05 10:48:09.89133	\N	6	2	\N
3996	1772-07-06	Lundi	1772-1773	67		\N	508	0	6	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.328276	2013-01-06 04:11:41.672177	\N	2	5	Irregular Receipts
3342	1770-05-12	Samedi	1770-1771	12		\N	2158	0	20			Check first play.  Unsure which version of Le Grondeur.	f	f	2012-09-17 07:24:22.792336	2013-01-05 12:46:10.336606	\N	2	5	Irregular Receipts
3343	1770-05-13	Dimanche	1770-1771	13		\N	307	0	21				f	f	2012-09-17 07:24:22.817357	2013-01-05 12:48:09.163668	\N	2	5	Irregular Receipts
3344	1770-05-14	Lundi	1770-1771	14		\N	1900	0	22			Unsure what the irregular entry refers to - entry of a specific person?	f	f	2012-09-17 07:24:22.842348	2013-01-05 12:51:21.174168	\N	2	5	Irregular Receipts
3347	1770-05-17	Jeudi	1770-1771	17		\N	801	0	25				f	f	2012-09-17 07:24:22.917331	2013-01-05 12:59:36.823137	\N	2	5	Irregular Receipts
3348	1770-05-18	Vendredi	1770-1771	18		\N	363	0	26				f	f	2012-09-17 07:24:22.959057	2013-01-05 13:01:10.772552	\N	2	5	Irregular Receipts
3349	1770-05-19	Samedi	1770-1771	19		\N	1025	0	27				f	f	2012-09-17 07:24:22.984226	2013-01-05 13:06:47.567683	\N	2	5	Irregular Receipts
3351	1770-05-21	Lundi	1770-1771	21		\N	795	0	29				f	f	2012-09-17 07:24:23.03417	2013-01-05 13:10:52.633043	\N	2	5	Irregular Receipts
3352	1770-05-22	Mardi	1770-1771	22		\N	847	10	30			Pricing information for Premieres-Troisiemes Places is incorrect: should be 4 livres, 2 livres, 1 livre 10 sous (respectively).	f	f	2012-09-17 07:24:23.059183	2013-01-05 13:13:35.796599	\N	2	5	Irregular Receipts
3355	1770-05-26	Samedi	1770-1771	25		\N	2537	0	33			Check second play - looks like "Le Legre"	f	f	2012-09-17 07:24:23.134228	2013-01-05 13:20:26.772753	\N	2	5	Irregular Receipts
3358	1770-05-29	Mardi	1770-1771	28		\N	558	10	36				f	f	2012-09-17 07:24:23.209135	2013-01-05 13:25:11.671919	\N	2	5	Irregular Receipts
3360	1770-05-31	Jeudi	1770-1771	30		\N	639	0	38				f	f	2012-09-17 07:24:23.259259	2013-01-05 13:28:50.071402	\N	2	5	Irregular Receipts
3931	1772-04-02	Jeudi	1772-1773	2		\N	808	0	2	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.68615	2013-01-05 18:37:21.981292	\N	2	5	Irregular Receipts
3930	1772-04-01	Mercredi	1772-1773	1		\N	2572	0	1	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.661161	2013-01-05 18:38:05.797523	\N	2	5	Irregular Receipts
3932	1772-04-04	Samedi	1772-1773	3		\N	3152	0	3	Dauberval, Dalainval (?)		There is a note saying something like "Pour la cloture"	f	f	2012-09-17 07:24:38.711166	2013-01-05 18:40:22.882424	\N	2	5	Irregular Receipts
3933	1772-04-27	Lundi	1772-1773	4		\N	2935	15	4	Dauberval, Dalainval (?)		There is a note on the register saying something like "Pour la Rentrée(sp?)"	f	f	2012-09-17 07:24:38.736154	2013-01-05 18:43:18.392561	\N	2	5	Irregular Receipts
3937	1772-05-01	Vendredi	1772-1773	8		\N	1351	10	1	Dauberval, Dalainval (?)	L'Ecole des maris avec un divertisement		f	f	2012-09-17 07:24:38.836197	2013-01-05 18:50:36.748152	\N	2	5	Irregular Receipts
3938	1772-05-02	Samedi	1772-1773	9		\N	2004	10	2	Dauberval, Dalainval (?)		Le Florentin avec un divertisement	f	f	2012-09-17 07:24:38.8612	2013-01-05 18:52:35.410623	\N	2	5	Irregular Receipts
3940	1772-05-04	Lundi	1772-1773	11		\N	1173	0	11	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.911189	2013-01-05 18:55:05.684744	\N	2	5	Irregular Receipts
3941	1772-05-05	Mardi	1772-1773	12		\N	207	0	5	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:38.936187	2013-01-05 18:58:07.783749	\N	2	5	Irregular Receipts
3944	1772-05-08	Vendredi	1772-1773	15		\N	310	10	8	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.011179	2013-01-05 19:02:39.984766	\N	2	5	Irregular Receipts
3946	1772-05-10	Dimanche	1772-1773	17		\N	972	0	10	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.061166	2013-01-05 19:05:22.899826	\N	2	5	Irregular Receipts
3947	1772-05-11	Lundi	1772-1773	18		\N	753	0	11	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.086157	2013-01-05 19:06:26.549662	\N	2	5	Irregular Receipts
3949	1772-05-13	Mercredi	1772-1773	20		\N	397	0	13	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.13627	2013-01-05 19:08:22.024319	\N	2	5	Irregular Receipts
3951	1772-05-15	Vendredi	1772-1773	22		\N	309	0	15	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.186255	2013-01-05 19:11:23.94665	\N	2	5	Irregular Receipts
3953	1772-05-17	Dimanche	1772-1773	24		\N	413	0	17	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.23625	2013-01-05 19:14:53.269393	\N	2	5	Irregular Receipts
3955	1772-05-20	Mercredi	1772-1773	26		\N	3620	10	19	Dauberval, Dalainval (?)		The total is incorrectly calculated	f	f	2012-09-17 07:24:39.286309	2013-01-05 19:21:08.910983	\N	2	5	Irregular Receipts
3957	1772-05-22	Vendredi	1772-1773	28		\N	415	10	21	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.33625	2013-01-05 19:23:35.816558	\N	2	5	Irregular Receipts
3959	1772-05-24	Dimanche	1772-1773	30		\N	1090	0	23	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.386313	2013-01-05 19:26:04.562022	\N	2	5	Irregular Receipts
3961	1772-05-26	Mardi	1772-1773	32		\N	348	10	25	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.436322	2013-01-05 19:27:57.986456	\N	2	5	Irregular Receipts
3962	1772-05-27	Mercredi	1772-1773	33		\N	1972	0	26	Dauberval, Dalainval (?)		The total for premiers places is incorrectly listed as 918 it should be 912	f	f	2012-09-17 07:24:39.461312	2013-01-05 19:29:47.072186	\N	2	5	Irregular Receipts
3964	1772-01-01	Lundi	1772-1773	35		\N	2370	10	28			New actor info to be transcribed, The number of tickets sold at secondes loges 3 is incorrectly listed as 6 it should be 8	f	f	2012-09-17 07:24:39.511303	2013-01-05 19:33:16.791136	\N	2	5	Irregular Receipts
3966	1772-06-01	Lundi	1772-1773	37		\N	2668	0	1	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.561289	2013-01-05 19:36:02.121696	\N	2	5	Irregular Receipts
3968	1772-06-04	Jeudi	1772-1773	39		\N	516	0	3	Dauberval, Dalainval (?)		L'Amour diable avec un divertisement	f	f	2012-09-17 07:24:39.611276	2013-01-05 19:39:36.056153	\N	2	5	Irregular Receipts
3970	1772-06-06	Samedi	1772-1773	41		\N	3425	10	5	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.661284	2013-01-05 19:44:33.249113	\N	2	5	Irregular Receipts
3971	1772-06-08	Lundi	1772-1773	42		\N	780	0	6	Dauberval, Dalainval (?)	Les Folies amoureuses avec un divertisement 		f	f	2012-09-17 07:24:39.686329	2013-01-05 20:39:54.09746	\N	2	5	Irregular Receipts
3973	1772-06-10	Mercredi	1772-1773	44		\N	2857	10	8	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:39.73633	2013-01-05 20:43:22.255521	\N	2	5	Irregular Receipts
3975	1772-06-12	Vendredi	1772-1773	46		\N	192	10	10	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.78632	2013-01-05 20:46:15.958875	\N	2	5	Irregular Receipts
3977	1772-06-14	Dimanche	1772-1773	48		\N	242	0	12	Dauberval, Dalainval (?)	L'Eté des coquettes avec un divertisement		f	f	2012-09-17 07:24:39.836324	2013-01-05 20:48:53.867318	\N	2	5	Irregular Receipts
3979	1772-06-16	Mardi	1772-1773	50		\N	110	0	14	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.886324	2013-01-05 20:51:34.579847	\N	2	5	Irregular Receipts
3981	1772-06-19	Vendredi	1772-1773	52		\N	247	10	16	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:39.9531	2013-01-05 20:54:00.471027	\N	2	5	Irregular Receipts
3982	1772-06-20	Samedi	1772-1773	53		\N	2897	10	17	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:39.978036	2013-01-05 20:55:42.918685	\N	2	5	Irregular Receipts
3984	1772-06-22	Lundi	1772-1773	55		\N	1795	0	19	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:40.028199	2013-01-05 21:01:40.529689	\N	2	5	Irregular Receipts
3986	1772-06-25	Jeudi	1772-1773	57		\N	354	0	21	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.078088	2013-01-05 21:05:50.104661	\N	2	5	Irregular Receipts
3988	1772-06-27	Samedi	1772-1773	59		\N	856	0	23	Dauberval, Dalainval (?)	Le Galant coureur avec un divertisement		f	f	2012-09-17 07:24:40.128196	2013-01-05 21:09:45.254657	\N	2	5	Irregular Receipts
3990	1772-06-29	Lundi	1772-1773	61		\N	1070	0	25	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.178069	2013-01-06 04:05:43.053882	\N	2	5	Irregular Receipts
3991	1772-07-01	Mercredi	1772-1773	62		\N	1501	0	1	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.203183	2013-01-06 04:06:51.088978	\N	2	5	Irregular Receipts
3992	1772-07-02	Jeudi	1772-1773	63		\N	444	0	2	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.228156	2013-01-06 04:07:56.724441	\N	2	5	Irregular Receipts
3994	1772-07-04	Samedi	1772-1773	65		\N	1622	0	4	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.278247	2013-01-06 04:09:49.000711	\N	2	5	Irregular Receipts
3998	1772-07-09	Jeudi	1772-1773	69		\N	137	0	8	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.378168	2013-01-06 04:14:01.356313	\N	2	5	Irregular Receipts
3999	1772-07-10	Vendredi	1772-1773	70		\N	229	10	9	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.403289	2013-01-06 04:14:52.193927	\N	2	5	Irregular Receipts
4001	1772-07-12	Dimanche	1772-1773	72		\N	376	0	11	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.45316	2013-01-06 04:17:08.886846	\N	2	5	Irregular Receipts
4003	1772-07-15	Mercredi	1772-1773	74		\N	765	0	13	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.503252	2013-01-06 04:18:58.345408	\N	2	5	Irregular Receipts
4005	1772-07-17	Vendredi	1772-1773	76		\N	167	0	15	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.553174	2013-01-06 04:21:09.232026	\N	2	5	Irregular Receipts
4007	1772-07-19	Dimanche	1772-1773	78		\N	497	0	17	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.60332	2013-01-06 04:24:05.555436	\N	2	5	Irregular Receipts
4009	1772-07-22	Mercredi	1772-1773	80		\N	927	0	19	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.65322	2013-01-06 04:26:07.064885	\N	2	5	Irregular Receipts
4011	1772-07-24	Vendredi	1772-1773	82		\N	110	0	21	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.70331	2013-01-06 04:30:57.241449	\N	2	5	Irregular Receipts
4013	1772-07-26	Dimanche	1772-1773	84		\N	1005	0	23	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.753199	2013-01-06 04:36:30.955775	\N	2	5	Irregular Receipts
4014	1772-07-27	Lundi	1772-1773	85		\N	3315	10	24	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.778287	2013-01-06 04:38:18.137752	\N	2	5	Irregular Receipts
4016	1772-07-30	Jeudi	1772-1773	87		\N	488	10	26	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.828175	2013-01-06 04:41:01.627462	\N	2	5	Irregular Receipts
4018	1772-08-01	Samedi	1772-1773	89		\N	2050	10	1	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:40.878328	2013-01-06 04:43:07.290289	\N	2	5	Irregular Receipts
4020	1772-08-03	Lundi	1772-1773	91		\N	1914	10	3	Dauberval, Dalainval (?)	L'Epreuve réciproque avec un divertisment		f	f	2012-09-17 07:24:40.928227	2013-01-06 04:46:00.217807	\N	2	5	Irregular Receipts
4021	1772-08-05	Mercredi	1772-1773	92		\N	1870	0	4	Dauberval, Dalainval (?)	Les curieux de Compiègne avec un divertisement		f	f	2012-09-17 07:24:40.953233	2013-01-06 04:48:59.174881	\N	2	5	Irregular Receipts
4023	1772-08-07	Vendredi	1772-1773	94		\N	118	0	6	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.003236	2013-01-06 04:51:20.811124	\N	2	5	Irregular Receipts
4025	1772-08-09	Dimanche	1772-1773	96		\N	332	0	8	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.053234	2013-01-06 04:53:42.301391	\N	2	5	Irregular Receipts
4027	1772-08-12	Mercredi	1772-1773	98		\N	1663	10	10	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.103225	2013-01-06 04:56:01.183324	\N	2	5	Irregular Receipts
4029	1772-08-14	Vendredi	1772-1773	100		\N	156	10	12	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.153308	2013-01-06 04:57:42.690737	\N	2	5	Irregular Receipts
3361	1770-06-01	Vendredi	1770-1771	1		\N	0	0	39		Special performance for the marriage of the dauphin - free performance.	Check first play.	f	f	2012-09-17 07:24:23.284278	2013-01-06 11:13:15.438744	\N	2	5	Irregular Receipts
3364	1770-06-05	Mardi	1770-1771	4		\N	1389	0	42				f	f	2012-09-17 07:24:23.359355	2013-01-06 11:21:58.443261	\N	2	5	Irregular Receipts
3365	1770-06-06	Mercredi	1770-1771	5		\N	1346	0	43		M. Desmaritre plays the role of the father in the second play.	First play not in database.	f	f	2012-09-17 07:24:23.384273	2013-01-06 11:25:24.399056	\N	2	5	Irregular Receipts
3368	1770-06-09	Samedi	1770-1771	8		\N	1325	0	46			First play not in database	f	f	2012-09-17 07:24:23.459335	2013-01-06 11:30:55.669821	\N	2	5	Irregular Receipts
4031	1772-08-17	Lundi	1772-1773	102		\N	1661	0	14	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.203395	2013-01-06 17:17:20.712786	\N	2	5	Irregular Receipts
4033	1772-08-20	Jeudi	1772-1773	104		\N	547	0	16	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.253395	2013-01-06 17:19:39.59886	\N	2	5	Irregular Receipts
4035	1772-08-22	Samedi	1772-1773	106		\N	1257	0	18	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.339333	2013-01-06 19:58:07.547284	\N	2	5	Irregular Receipts
4036	1772-08-23	Dimanche	1772-1773	107		\N	919	0	19	Dauberval, Dalainval (?)	La Coupe Enchantée avec un divertisement		f	f	2012-09-17 07:24:41.361612	2013-01-06 19:59:19.437148	\N	2	5	Irregular Receipts
4038	1772-08-25	Mardi	1772-1773	109		\N	457	0	21	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.411582	2013-01-06 20:01:40.314349	\N	2	5	Irregular Receipts
4040	1772-08-27	Jeudi	1772-1773	111		\N	312	0	23	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.461636	2013-01-06 20:03:49.163926	\N	2	5	Irregular Receipts
4042	1772-08-29	Samedi	1772-1773	113		\N	2042	10	25	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.511623	2013-01-06 20:06:02.846555	\N	2	5	Irregular Receipts
4044	1772-08-31	Lundi	1772-1773	115		\N	896	0	27	Dauberval, Dalainval (?)			f	f	2012-09-17 07:24:41.561628	2013-01-06 20:08:14.527315	\N	2	5	Irregular Receipts
4045	1772-09-02	Mercredi	1772-1773	116		\N	958	0	1	Dauberval, Dalainval (?)		New actor info to be transcribed	f	f	2012-09-17 07:24:41.586615	2013-01-06 20:09:33.981041	\N	2	5	Irregular Receipts
\.


--
-- Name: registers_pkey; Type: CONSTRAINT; Schema: public; Owner: cfrp; Tablespace: 
--

ALTER TABLE ONLY registers
    ADD CONSTRAINT registers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

