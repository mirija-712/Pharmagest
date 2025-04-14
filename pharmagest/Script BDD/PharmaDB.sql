--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2025-04-14 09:38:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 236 (class 1259 OID 21844)
-- Name: bilan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bilan (
    id integer NOT NULL,
    facture_id integer NOT NULL,
    date_vente date NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.bilan OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 21843)
-- Name: bilan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bilan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bilan_id_seq OWNER TO postgres;

--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 235
-- Name: bilan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bilan_id_seq OWNED BY public.bilan.id;


--
-- TOC entry 222 (class 1259 OID 21731)
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande (
    id integer NOT NULL,
    no_commande integer NOT NULL,
    date_commande date NOT NULL,
    prix_total numeric(10,2) NOT NULL,
    fournisseur_id integer NOT NULL,
    utilisateur_id integer NOT NULL,
    statut character varying(20) NOT NULL
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 21730)
-- Name: commande_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commande_id_seq OWNER TO postgres;

--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 221
-- Name: commande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;


--
-- TOC entry 234 (class 1259 OID 21828)
-- Name: facture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facture (
    id integer NOT NULL,
    numero_facture integer NOT NULL,
    date_emission date NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    vente_id integer NOT NULL
);


ALTER TABLE public.facture OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 21827)
-- Name: facture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facture_id_seq OWNER TO postgres;

--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 233
-- Name: facture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facture_id_seq OWNED BY public.facture.id;


--
-- TOC entry 218 (class 1259 OID 21708)
-- Name: fournisseur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fournisseur (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    adresse text,
    contact character varying(255)
);


ALTER TABLE public.fournisseur OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 21707)
-- Name: fournisseur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fournisseur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fournisseur_id_seq OWNER TO postgres;

--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 217
-- Name: fournisseur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fournisseur_id_seq OWNED BY public.fournisseur.id;


--
-- TOC entry 224 (class 1259 OID 21750)
-- Name: lignecommande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lignecommande (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    medicament_id integer,
    quantites integer NOT NULL,
    prix_achat numeric(10,2) NOT NULL,
    CONSTRAINT lignecommande_quantites_check CHECK ((quantites > 0))
);


ALTER TABLE public.lignecommande OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 21749)
-- Name: lignecommande_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lignecommande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lignecommande_id_seq OWNER TO postgres;

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 223
-- Name: lignecommande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lignecommande_id_seq OWNED BY public.lignecommande.id;


--
-- TOC entry 232 (class 1259 OID 21805)
-- Name: lignevente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lignevente (
    id integer NOT NULL,
    vente_id integer NOT NULL,
    medicament_id integer,
    quantite integer NOT NULL,
    prix_unitaire numeric(10,2) NOT NULL,
    prescription_id integer,
    typevente character varying(25) NOT NULL,
    CONSTRAINT lignevente_quantite_check CHECK ((quantite > 0))
);


ALTER TABLE public.lignevente OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 21804)
-- Name: lignevente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lignevente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lignevente_id_seq OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 231
-- Name: lignevente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lignevente_id_seq OWNED BY public.lignevente.id;


--
-- TOC entry 226 (class 1259 OID 21768)
-- Name: livraison; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livraison (
    id integer NOT NULL,
    date_livraison date NOT NULL,
    status character varying(255) NOT NULL,
    commande_id integer NOT NULL
);


ALTER TABLE public.livraison OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 21767)
-- Name: livraison_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livraison_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livraison_id_seq OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 225
-- Name: livraison_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livraison_id_seq OWNED BY public.livraison.id;


--
-- TOC entry 220 (class 1259 OID 21719)
-- Name: medicament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicament (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    prix_achat numeric(10,2) NOT NULL,
    prix_vente numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    seuil_alerte integer NOT NULL,
    quantite_max integer NOT NULL,
    necessite_prescription boolean NOT NULL,
    forme_medicament character varying(255),
    famille character varying(255),
    dosage character varying(50),
    fournisseur_id integer,
    CONSTRAINT medicament_quantite_max_check CHECK ((quantite_max >= 0)),
    CONSTRAINT medicament_seuil_alerte_check CHECK ((seuil_alerte >= 0)),
    CONSTRAINT medicament_stock_check CHECK ((stock >= 0))
);


ALTER TABLE public.medicament OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 21718)
-- Name: medicament_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicament_id_seq OWNER TO postgres;

--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 219
-- Name: medicament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicament_id_seq OWNED BY public.medicament.id;


--
-- TOC entry 230 (class 1259 OID 21794)
-- Name: prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription (
    id integer NOT NULL,
    numero_prescription character varying(255) NOT NULL,
    nom_medecin character varying(255) NOT NULL,
    date_prescription date NOT NULL,
    nom_patient character varying(255) NOT NULL,
    medicament character varying(500) NOT NULL
);


ALTER TABLE public.prescription OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 21793)
-- Name: prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescription_id_seq OWNER TO postgres;

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 229
-- Name: prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_id_seq OWNED BY public.prescription.id;


--
-- TOC entry 216 (class 1259 OID 21695)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    identifiant character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    numero character varying(255),
    motdepasse character varying(255) NOT NULL,
    statut character varying(255) NOT NULL
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 21694)
-- Name: utilisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_seq OWNER TO postgres;

--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 215
-- Name: utilisateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;


--
-- TOC entry 228 (class 1259 OID 21780)
-- Name: vente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vente (
    id integer NOT NULL,
    no_vente integer NOT NULL,
    date_vente date NOT NULL,
    type_vente character varying(25) NOT NULL,
    prix_total numeric(10,2) NOT NULL,
    statut_vente character varying(25) NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.vente OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 21779)
-- Name: vente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vente_id_seq OWNER TO postgres;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 227
-- Name: vente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vente_id_seq OWNED BY public.vente.id;


--
-- TOC entry 4694 (class 2604 OID 21847)
-- Name: bilan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan ALTER COLUMN id SET DEFAULT nextval('public.bilan_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 21734)
-- Name: commande id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);


--
-- TOC entry 4693 (class 2604 OID 21831)
-- Name: facture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture ALTER COLUMN id SET DEFAULT nextval('public.facture_id_seq'::regclass);


--
-- TOC entry 4685 (class 2604 OID 21711)
-- Name: fournisseur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur ALTER COLUMN id SET DEFAULT nextval('public.fournisseur_id_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 21753)
-- Name: lignecommande id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande ALTER COLUMN id SET DEFAULT nextval('public.lignecommande_id_seq'::regclass);


--
-- TOC entry 4692 (class 2604 OID 21808)
-- Name: lignevente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente ALTER COLUMN id SET DEFAULT nextval('public.lignevente_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 21771)
-- Name: livraison id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison ALTER COLUMN id SET DEFAULT nextval('public.livraison_id_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 21722)
-- Name: medicament id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament ALTER COLUMN id SET DEFAULT nextval('public.medicament_id_seq'::regclass);


--
-- TOC entry 4691 (class 2604 OID 21797)
-- Name: prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription ALTER COLUMN id SET DEFAULT nextval('public.prescription_id_seq'::regclass);


--
-- TOC entry 4684 (class 2604 OID 21698)
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- TOC entry 4690 (class 2604 OID 21783)
-- Name: vente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente ALTER COLUMN id SET DEFAULT nextval('public.vente_id_seq'::regclass);


--
-- TOC entry 4914 (class 0 OID 21844)
-- Dependencies: 236
-- Data for Name: bilan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bilan (id, facture_id, date_vente, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 4900 (class 0 OID 21731)
-- Dependencies: 222
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commande (id, no_commande, date_commande, prix_total, fournisseur_id, utilisateur_id, statut) FROM stdin;
\.


--
-- TOC entry 4912 (class 0 OID 21828)
-- Dependencies: 234
-- Data for Name: facture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facture (id, numero_facture, date_emission, montant_total, vente_id) FROM stdin;
\.


--
-- TOC entry 4896 (class 0 OID 21708)
-- Dependencies: 218
-- Data for Name: fournisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fournisseur (id, nom, adresse, contact) FROM stdin;
1	Pharmacie Nouvelle	Royal Road, Port Louis, Île Maurice	+230 210 1234 / nouvelle@pharma.mu
2	Pharmacie Populaire	Remy Ollier Street, Curepipe, Île Maurice	+230 674 5678 / populaire@pharma.mu
3	Pharmacie Centrale	John Kennedy Street, Quatre Bornes, Île Maurice	+230 465 7890 / centrale@pharma.mu
4	Pharmacie de l’Océan	Coastal Road, Grand Baie, Île Maurice	+230 263 4567 / ocean@pharma.mu
5	Pharmacie Belle Vue	Avenue des Palmiers, Flic-en-Flac, Île Maurice	+230 453 9876 / bellevue@pharma.mu
\.


--
-- TOC entry 4902 (class 0 OID 21750)
-- Dependencies: 224
-- Data for Name: lignecommande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lignecommande (id, commande_id, medicament_id, quantites, prix_achat) FROM stdin;
\.


--
-- TOC entry 4910 (class 0 OID 21805)
-- Dependencies: 232
-- Data for Name: lignevente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lignevente (id, vente_id, medicament_id, quantite, prix_unitaire, prescription_id, typevente) FROM stdin;
\.


--
-- TOC entry 4904 (class 0 OID 21768)
-- Dependencies: 226
-- Data for Name: livraison; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livraison (id, date_livraison, status, commande_id) FROM stdin;
\.


--
-- TOC entry 4898 (class 0 OID 21719)
-- Dependencies: 220
-- Data for Name: medicament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicament (id, nom, prix_achat, prix_vente, stock, seuil_alerte, quantite_max, necessite_prescription, forme_medicament, famille, dosage, fournisseur_id) FROM stdin;
1	Paracétamol	5.00	10.00	100	10	500	f	Comprimé	Antalgique	500mg	1
2	Ibuprofène	8.00	15.00	80	5	400	t	Comprimé	Anti-inflammatoire	400mg	2
3	Amoxicilline	20.00	35.00	50	5	200	t	Gélule	Antibiotique	500mg	3
4	Loratadine	12.00	22.00	60	5	300	f	Comprimé	Antihistaminique	10mg	4
5	Omeprazole	18.00	30.00	70	10	250	t	Capsule	IPP	20mg	5
6	Metformine	15.00	28.00	90	10	400	t	Comprimé	Antidiabétique	850mg	1
7	Salbutamol	25.00	40.00	40	5	150	t	Inhalateur	Bronchodilatateur	100mcg	2
8	Diclofénac	10.00	20.00	85	10	350	t	Comprimé	Anti-inflammatoire	50mg	3
9	Aspirine	6.00	12.00	120	10	600	f	Comprimé	Antalgique	500mg	4
10	Cétirizine	14.00	25.00	75	10	300	f	Comprimé	Antihistaminique	10mg	5
11	Ranitidine	16.00	30.00	55	5	200	t	Comprimé	Antiacide	150mg	1
12	Furosemide	10.00	18.00	65	5	250	t	Comprimé	Diurétique	40mg	2
13	Atorvastatine	22.00	40.00	50	10	180	t	Comprimé	Hypolipémiant	10mg	3
14	Losartan	20.00	38.00	45	10	160	t	Comprimé	Antihypertenseur	50mg	4
15	Glibenclamide	12.00	22.00	70	10	220	t	Comprimé	Antidiabétique	5mg	5
16	Prednisolone	18.00	32.00	50	10	200	t	Comprimé	Corticostéroïde	5mg	1
17	Ciprofloxacine	25.00	45.00	40	5	140	t	Comprimé	Antibiotique	500mg	2
18	Dextrométhorphane	10.00	18.00	85	10	350	f	Sirop	Antitussif	10mg/5mL	3
19	Aciclovir	30.00	50.00	35	5	120	t	Comprimé	Antiviral	400mg	4
20	Fluconazole	28.00	48.00	40	5	140	t	Comprimé	Antifongique	150mg	5
21	Insuline	100.00	150.00	20	5	100	t	Injection	Antidiabétique	10mL	1
22	Cetirizine	15.00	27.00	60	5	280	f	Comprimé	Antihistaminique	10mg	2
23	Hydrochlorothiazide	10.00	20.00	80	10	300	t	Comprimé	Diurétique	25mg	3
24	Levothyroxine	18.00	35.00	50	5	200	t	Comprimé	Hormone thyroïdienne	50mcg	4
25	Nifédipine	20.00	40.00	45	10	150	t	Comprimé	Antihypertenseur	10mg	5
26	Carbamazépine	22.00	42.00	40	5	140	t	Comprimé	Anticonvulsivant	200mg	1
27	Tramadol	30.00	55.00	30	5	120	t	Comprimé	Antalgique	50mg	2
28	Chlorhexidine	12.00	22.00	70	10	350	f	Solution	Antiseptique	0.12%	3
29	Bromhexine	14.00	26.00	65	10	300	f	Sirop	Expectorant	4mg/5mL	4
30	Amlodipine	24.00	45.00	50	10	200	t	Comprimé	Antihypertenseur	5mg	5
31	Ceftriaxone	40.00	70.00	25	5	100	t	Injection	Antibiotique	1g	1
32	Miconazole	16.00	30.00	50	10	250	t	Crème	Antifongique	2%	2
\.


--
-- TOC entry 4908 (class 0 OID 21794)
-- Dependencies: 230
-- Data for Name: prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription (id, numero_prescription, nom_medecin, date_prescription, nom_patient, medicament) FROM stdin;
\.


--
-- TOC entry 4894 (class 0 OID 21695)
-- Dependencies: 216
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, nom, prenom, identifiant, email, numero, motdepasse, statut) FROM stdin;
3	SuperAdmin	Admin	Admin	admin@gmail.com	+230 1234 1234	0000	Admin
4	SuperVendeur	Vendeur	Vendeur	vendeur@gmail.com	+230 2315 1235	0000	Vendeur
\.


--
-- TOC entry 4906 (class 0 OID 21780)
-- Dependencies: 228
-- Data for Name: vente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente (id, no_vente, date_vente, type_vente, prix_total, statut_vente, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 235
-- Name: bilan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilan_id_seq', 1, false);


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 221
-- Name: commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_seq', 1, false);


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 233
-- Name: facture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facture_id_seq', 1, false);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 217
-- Name: fournisseur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fournisseur_id_seq', 5, true);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 223
-- Name: lignecommande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lignecommande_id_seq', 1, false);


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 231
-- Name: lignevente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lignevente_id_seq', 1, false);


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 225
-- Name: livraison_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livraison_id_seq', 1, false);


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 219
-- Name: medicament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicament_id_seq', 32, true);


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 229
-- Name: prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_id_seq', 1, false);


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 215
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 4, true);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 227
-- Name: vente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vente_id_seq', 1, false);


--
-- TOC entry 4737 (class 2606 OID 21849)
-- Name: bilan bilan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_pkey PRIMARY KEY (id);


--
-- TOC entry 4713 (class 2606 OID 21738)
-- Name: commande commande_no_commande_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_no_commande_key UNIQUE (no_commande);


--
-- TOC entry 4715 (class 2606 OID 21736)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 21835)
-- Name: facture facture_numero_facture_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_numero_facture_key UNIQUE (numero_facture);


--
-- TOC entry 4733 (class 2606 OID 21833)
-- Name: facture facture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 21837)
-- Name: facture facture_vente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_key UNIQUE (vente_id);


--
-- TOC entry 4707 (class 2606 OID 21717)
-- Name: fournisseur fournisseur_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_nom_key UNIQUE (nom);


--
-- TOC entry 4709 (class 2606 OID 21715)
-- Name: fournisseur fournisseur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id);


--
-- TOC entry 4717 (class 2606 OID 21756)
-- Name: lignecommande lignecommande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 21811)
-- Name: lignevente lignevente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_pkey PRIMARY KEY (id);


--
-- TOC entry 4719 (class 2606 OID 21773)
-- Name: livraison livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_pkey PRIMARY KEY (id);


--
-- TOC entry 4711 (class 2606 OID 21729)
-- Name: medicament medicament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 21803)
-- Name: prescription prescription_numero_prescription_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_numero_prescription_key UNIQUE (numero_prescription);


--
-- TOC entry 4727 (class 2606 OID 21801)
-- Name: prescription prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (id);


--
-- TOC entry 4701 (class 2606 OID 21706)
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- TOC entry 4703 (class 2606 OID 21704)
-- Name: utilisateur utilisateur_identifiant_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_identifiant_key UNIQUE (identifiant);


--
-- TOC entry 4705 (class 2606 OID 21702)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 21787)
-- Name: vente vente_no_vente_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_no_vente_key UNIQUE (no_vente);


--
-- TOC entry 4723 (class 2606 OID 21785)
-- Name: vente vente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id);


--
-- TOC entry 4748 (class 2606 OID 21850)
-- Name: bilan bilan_facture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_facture_id_fkey FOREIGN KEY (facture_id) REFERENCES public.facture(id);


--
-- TOC entry 4749 (class 2606 OID 21855)
-- Name: bilan bilan_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- TOC entry 4738 (class 2606 OID 21739)
-- Name: commande commande_fournisseur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_fournisseur_id_fkey FOREIGN KEY (fournisseur_id) REFERENCES public.fournisseur(id);


--
-- TOC entry 4739 (class 2606 OID 21744)
-- Name: commande commande_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- TOC entry 4747 (class 2606 OID 21838)
-- Name: facture facture_vente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);


--
-- TOC entry 4740 (class 2606 OID 21757)
-- Name: lignecommande lignecommande_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(id);


--
-- TOC entry 4741 (class 2606 OID 21762)
-- Name: lignecommande lignecommande_medicament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);


--
-- TOC entry 4744 (class 2606 OID 21817)
-- Name: lignevente lignevente_medicament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);


--
-- TOC entry 4745 (class 2606 OID 21822)
-- Name: lignevente lignevente_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescription(id);


--
-- TOC entry 4746 (class 2606 OID 21812)
-- Name: lignevente lignevente_vente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);


--
-- TOC entry 4742 (class 2606 OID 21774)
-- Name: livraison livraison_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(no_commande);


--
-- TOC entry 4743 (class 2606 OID 21788)
-- Name: vente vente_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


-- Completed on 2025-04-14 09:38:43

--
-- PostgreSQL database dump complete
--

