toc.dat                                                                                             0000600 0004000 0002000 00000102734 15002352226 0014443 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP   
        
            }         
   pharmagest    16.2    16.2 n    C           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         D           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         E           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         F           1262    23054 
   pharmagest    DATABASE     }   CREATE DATABASE pharmagest WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE pharmagest;
                postgres    false         �            1255    23373    log_connexion()    FUNCTION     �  CREATE FUNCTION public.log_connexion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO connexion_log (nom_utilisateur, type_action)
        VALUES (NEW.nom, 'CONNEXION');
    ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.est_connecte = false AND OLD.est_connecte = true THEN
            INSERT INTO connexion_log (nom_utilisateur, type_action)
            VALUES (NEW.nom, 'DECONNEXION');
        END IF;
    END IF;
    RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.log_connexion();
       public          postgres    false         �            1259    23055    bilan    TABLE     �   CREATE TABLE public.bilan (
    id integer NOT NULL,
    facture_id integer NOT NULL,
    date_vente date NOT NULL,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.bilan;
       public         heap    postgres    false         �            1259    23058    bilan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bilan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.bilan_id_seq;
       public          postgres    false    215         G           0    0    bilan_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.bilan_id_seq OWNED BY public.bilan.id;
          public          postgres    false    216         �            1259    23059    commande    TABLE       CREATE TABLE public.commande (
    id integer NOT NULL,
    no_commande integer NOT NULL,
    date_commande date NOT NULL,
    prix_total numeric(10,2) NOT NULL,
    fournisseur_id integer NOT NULL,
    utilisateur_id integer NOT NULL,
    statut character varying(20) NOT NULL
);
    DROP TABLE public.commande;
       public         heap    postgres    false         �            1259    23062    commande_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.commande_id_seq;
       public          postgres    false    217         H           0    0    commande_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;
          public          postgres    false    218         �            1259    23366    connexion_log    TABLE     �   CREATE TABLE public.connexion_log (
    id integer NOT NULL,
    nom_utilisateur character varying(100),
    type_action character varying(20),
    date_heure timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.connexion_log;
       public         heap    postgres    false         �            1259    23365    connexion_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.connexion_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.connexion_log_id_seq;
       public          postgres    false    238         I           0    0    connexion_log_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.connexion_log_id_seq OWNED BY public.connexion_log.id;
          public          postgres    false    237         �            1259    23063    facture    TABLE     �   CREATE TABLE public.facture (
    id integer NOT NULL,
    numero_facture integer NOT NULL,
    date_emission date NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    vente_id integer NOT NULL
);
    DROP TABLE public.facture;
       public         heap    postgres    false         �            1259    23066    facture_id_seq    SEQUENCE     �   CREATE SEQUENCE public.facture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.facture_id_seq;
       public          postgres    false    219         J           0    0    facture_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.facture_id_seq OWNED BY public.facture.id;
          public          postgres    false    220         �            1259    23067    fournisseur    TABLE     �   CREATE TABLE public.fournisseur (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    adresse text,
    contact character varying(255)
);
    DROP TABLE public.fournisseur;
       public         heap    postgres    false         �            1259    23072    fournisseur_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fournisseur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.fournisseur_id_seq;
       public          postgres    false    221         K           0    0    fournisseur_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.fournisseur_id_seq OWNED BY public.fournisseur.id;
          public          postgres    false    222         �            1259    23073    lignecommande    TABLE     	  CREATE TABLE public.lignecommande (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    medicament_id integer,
    quantites integer NOT NULL,
    prix_achat numeric(10,2) NOT NULL,
    CONSTRAINT lignecommande_quantites_check CHECK ((quantites > 0))
);
 !   DROP TABLE public.lignecommande;
       public         heap    postgres    false         �            1259    23077    lignecommande_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lignecommande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.lignecommande_id_seq;
       public          postgres    false    223         L           0    0    lignecommande_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.lignecommande_id_seq OWNED BY public.lignecommande.id;
          public          postgres    false    224         �            1259    23078 
   lignevente    TABLE     K  CREATE TABLE public.lignevente (
    id integer NOT NULL,
    vente_id integer NOT NULL,
    medicament_id integer,
    quantite integer NOT NULL,
    prix_unitaire numeric(10,2) NOT NULL,
    prescription_id integer,
    typevente character varying(25) NOT NULL,
    CONSTRAINT lignevente_quantite_check CHECK ((quantite > 0))
);
    DROP TABLE public.lignevente;
       public         heap    postgres    false         �            1259    23082    lignevente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lignevente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.lignevente_id_seq;
       public          postgres    false    225         M           0    0    lignevente_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.lignevente_id_seq OWNED BY public.lignevente.id;
          public          postgres    false    226         �            1259    23083 	   livraison    TABLE     �   CREATE TABLE public.livraison (
    id integer NOT NULL,
    date_livraison date NOT NULL,
    status character varying(255) NOT NULL,
    commande_id integer NOT NULL
);
    DROP TABLE public.livraison;
       public         heap    postgres    false         �            1259    23086    livraison_id_seq    SEQUENCE     �   CREATE SEQUENCE public.livraison_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.livraison_id_seq;
       public          postgres    false    227         N           0    0    livraison_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.livraison_id_seq OWNED BY public.livraison.id;
          public          postgres    false    228         �            1259    23087 
   medicament    TABLE     �  CREATE TABLE public.medicament (
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
    DROP TABLE public.medicament;
       public         heap    postgres    false         �            1259    23095    medicament_id_seq    SEQUENCE     �   CREATE SEQUENCE public.medicament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.medicament_id_seq;
       public          postgres    false    229         O           0    0    medicament_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.medicament_id_seq OWNED BY public.medicament.id;
          public          postgres    false    230         �            1259    23096    prescription    TABLE     .  CREATE TABLE public.prescription (
    id integer NOT NULL,
    numero_prescription character varying(255) NOT NULL,
    nom_medecin character varying(255) NOT NULL,
    date_prescription date NOT NULL,
    nom_patient character varying(255) NOT NULL,
    medicament character varying(500) NOT NULL
);
     DROP TABLE public.prescription;
       public         heap    postgres    false         �            1259    23101    prescription_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prescription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.prescription_id_seq;
       public          postgres    false    231         P           0    0    prescription_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.prescription_id_seq OWNED BY public.prescription.id;
          public          postgres    false    232         �            1259    23102    utilisateur    TABLE     �  CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    prenom character varying(255) NOT NULL,
    identifiant character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    numero character varying(255),
    motdepasse character varying(255) NOT NULL,
    statut character varying(255) NOT NULL,
    est_connecte boolean DEFAULT false
);
    DROP TABLE public.utilisateur;
       public         heap    postgres    false         �            1259    23107    utilisateur_id_seq    SEQUENCE     �   CREATE SEQUENCE public.utilisateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.utilisateur_id_seq;
       public          postgres    false    233         Q           0    0    utilisateur_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;
          public          postgres    false    234         �            1259    23108    vente    TABLE        CREATE TABLE public.vente (
    id integer NOT NULL,
    no_vente integer NOT NULL,
    date_vente date NOT NULL,
    type_vente character varying(25) NOT NULL,
    prix_total numeric(10,2) NOT NULL,
    statut_vente character varying(25) NOT NULL,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.vente;
       public         heap    postgres    false         �            1259    23111    vente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.vente_id_seq;
       public          postgres    false    235         R           0    0    vente_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.vente_id_seq OWNED BY public.vente.id;
          public          postgres    false    236         R           2604    23112    bilan id    DEFAULT     d   ALTER TABLE ONLY public.bilan ALTER COLUMN id SET DEFAULT nextval('public.bilan_id_seq'::regclass);
 7   ALTER TABLE public.bilan ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215         S           2604    23113    commande id    DEFAULT     j   ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);
 :   ALTER TABLE public.commande ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217         ^           2604    23369    connexion_log id    DEFAULT     t   ALTER TABLE ONLY public.connexion_log ALTER COLUMN id SET DEFAULT nextval('public.connexion_log_id_seq'::regclass);
 ?   ALTER TABLE public.connexion_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237    238         T           2604    23114 
   facture id    DEFAULT     h   ALTER TABLE ONLY public.facture ALTER COLUMN id SET DEFAULT nextval('public.facture_id_seq'::regclass);
 9   ALTER TABLE public.facture ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219         U           2604    23115    fournisseur id    DEFAULT     p   ALTER TABLE ONLY public.fournisseur ALTER COLUMN id SET DEFAULT nextval('public.fournisseur_id_seq'::regclass);
 =   ALTER TABLE public.fournisseur ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221         V           2604    23116    lignecommande id    DEFAULT     t   ALTER TABLE ONLY public.lignecommande ALTER COLUMN id SET DEFAULT nextval('public.lignecommande_id_seq'::regclass);
 ?   ALTER TABLE public.lignecommande ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223         W           2604    23117    lignevente id    DEFAULT     n   ALTER TABLE ONLY public.lignevente ALTER COLUMN id SET DEFAULT nextval('public.lignevente_id_seq'::regclass);
 <   ALTER TABLE public.lignevente ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225         X           2604    23118    livraison id    DEFAULT     l   ALTER TABLE ONLY public.livraison ALTER COLUMN id SET DEFAULT nextval('public.livraison_id_seq'::regclass);
 ;   ALTER TABLE public.livraison ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227         Y           2604    23119    medicament id    DEFAULT     n   ALTER TABLE ONLY public.medicament ALTER COLUMN id SET DEFAULT nextval('public.medicament_id_seq'::regclass);
 <   ALTER TABLE public.medicament ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229         Z           2604    23120    prescription id    DEFAULT     r   ALTER TABLE ONLY public.prescription ALTER COLUMN id SET DEFAULT nextval('public.prescription_id_seq'::regclass);
 >   ALTER TABLE public.prescription ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231         [           2604    23121    utilisateur id    DEFAULT     p   ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);
 =   ALTER TABLE public.utilisateur ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233         ]           2604    23122    vente id    DEFAULT     d   ALTER TABLE ONLY public.vente ALTER COLUMN id SET DEFAULT nextval('public.vente_id_seq'::regclass);
 7   ALTER TABLE public.vente ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235         )          0    23055    bilan 
   TABLE DATA           K   COPY public.bilan (id, facture_id, date_vente, utilisateur_id) FROM stdin;
    public          postgres    false    215       4905.dat +          0    23059    commande 
   TABLE DATA           v   COPY public.commande (id, no_commande, date_commande, prix_total, fournisseur_id, utilisateur_id, statut) FROM stdin;
    public          postgres    false    217       4907.dat @          0    23366    connexion_log 
   TABLE DATA           U   COPY public.connexion_log (id, nom_utilisateur, type_action, date_heure) FROM stdin;
    public          postgres    false    238       4928.dat -          0    23063    facture 
   TABLE DATA           ]   COPY public.facture (id, numero_facture, date_emission, montant_total, vente_id) FROM stdin;
    public          postgres    false    219       4909.dat /          0    23067    fournisseur 
   TABLE DATA           @   COPY public.fournisseur (id, nom, adresse, contact) FROM stdin;
    public          postgres    false    221       4911.dat 1          0    23073    lignecommande 
   TABLE DATA           ^   COPY public.lignecommande (id, commande_id, medicament_id, quantites, prix_achat) FROM stdin;
    public          postgres    false    223       4913.dat 3          0    23078 
   lignevente 
   TABLE DATA           v   COPY public.lignevente (id, vente_id, medicament_id, quantite, prix_unitaire, prescription_id, typevente) FROM stdin;
    public          postgres    false    225       4915.dat 5          0    23083 	   livraison 
   TABLE DATA           L   COPY public.livraison (id, date_livraison, status, commande_id) FROM stdin;
    public          postgres    false    227       4917.dat 7          0    23087 
   medicament 
   TABLE DATA           �   COPY public.medicament (id, nom, prix_achat, prix_vente, stock, seuil_alerte, quantite_max, necessite_prescription, forme_medicament, famille, dosage, fournisseur_id) FROM stdin;
    public          postgres    false    229       4919.dat 9          0    23096    prescription 
   TABLE DATA           x   COPY public.prescription (id, numero_prescription, nom_medecin, date_prescription, nom_patient, medicament) FROM stdin;
    public          postgres    false    231       4921.dat ;          0    23102    utilisateur 
   TABLE DATA           t   COPY public.utilisateur (id, nom, prenom, identifiant, email, numero, motdepasse, statut, est_connecte) FROM stdin;
    public          postgres    false    233       4923.dat =          0    23108    vente 
   TABLE DATA           o   COPY public.vente (id, no_vente, date_vente, type_vente, prix_total, statut_vente, utilisateur_id) FROM stdin;
    public          postgres    false    235       4925.dat S           0    0    bilan_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.bilan_id_seq', 1, true);
          public          postgres    false    216         T           0    0    commande_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.commande_id_seq', 1, false);
          public          postgres    false    218         U           0    0    connexion_log_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.connexion_log_id_seq', 3, true);
          public          postgres    false    237         V           0    0    facture_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.facture_id_seq', 1, true);
          public          postgres    false    220         W           0    0    fournisseur_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.fournisseur_id_seq', 6, true);
          public          postgres    false    222         X           0    0    lignecommande_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.lignecommande_id_seq', 1, false);
          public          postgres    false    224         Y           0    0    lignevente_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.lignevente_id_seq', 1, true);
          public          postgres    false    226         Z           0    0    livraison_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.livraison_id_seq', 1, false);
          public          postgres    false    228         [           0    0    medicament_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.medicament_id_seq', 33, true);
          public          postgres    false    230         \           0    0    prescription_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.prescription_id_seq', 1, false);
          public          postgres    false    232         ]           0    0    utilisateur_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.utilisateur_id_seq', 7, true);
          public          postgres    false    234         ^           0    0    vente_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.vente_id_seq', 1, true);
          public          postgres    false    236         f           2606    23124    bilan bilan_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.bilan DROP CONSTRAINT bilan_pkey;
       public            postgres    false    215         h           2606    23126 !   commande commande_no_commande_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_no_commande_key UNIQUE (no_commande);
 K   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_no_commande_key;
       public            postgres    false    217         j           2606    23128    commande commande_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_pkey;
       public            postgres    false    217         �           2606    23372     connexion_log connexion_log_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.connexion_log
    ADD CONSTRAINT connexion_log_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.connexion_log DROP CONSTRAINT connexion_log_pkey;
       public            postgres    false    238         l           2606    23130 "   facture facture_numero_facture_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_numero_facture_key UNIQUE (numero_facture);
 L   ALTER TABLE ONLY public.facture DROP CONSTRAINT facture_numero_facture_key;
       public            postgres    false    219         n           2606    23132    facture facture_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.facture DROP CONSTRAINT facture_pkey;
       public            postgres    false    219         p           2606    23134    facture facture_vente_id_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_key UNIQUE (vente_id);
 F   ALTER TABLE ONLY public.facture DROP CONSTRAINT facture_vente_id_key;
       public            postgres    false    219         r           2606    23136    fournisseur fournisseur_nom_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_nom_key UNIQUE (nom);
 I   ALTER TABLE ONLY public.fournisseur DROP CONSTRAINT fournisseur_nom_key;
       public            postgres    false    221         t           2606    23138    fournisseur fournisseur_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.fournisseur DROP CONSTRAINT fournisseur_pkey;
       public            postgres    false    221         v           2606    23140     lignecommande lignecommande_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.lignecommande DROP CONSTRAINT lignecommande_pkey;
       public            postgres    false    223         x           2606    23142    lignevente lignevente_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.lignevente DROP CONSTRAINT lignevente_pkey;
       public            postgres    false    225         z           2606    23144    livraison livraison_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.livraison DROP CONSTRAINT livraison_pkey;
       public            postgres    false    227         |           2606    23146    medicament medicament_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.medicament DROP CONSTRAINT medicament_pkey;
       public            postgres    false    229         ~           2606    23148 1   prescription prescription_numero_prescription_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_numero_prescription_key UNIQUE (numero_prescription);
 [   ALTER TABLE ONLY public.prescription DROP CONSTRAINT prescription_numero_prescription_key;
       public            postgres    false    231         �           2606    23150    prescription prescription_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.prescription DROP CONSTRAINT prescription_pkey;
       public            postgres    false    231         �           2606    23152 !   utilisateur utilisateur_email_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);
 K   ALTER TABLE ONLY public.utilisateur DROP CONSTRAINT utilisateur_email_key;
       public            postgres    false    233         �           2606    23154 '   utilisateur utilisateur_identifiant_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_identifiant_key UNIQUE (identifiant);
 Q   ALTER TABLE ONLY public.utilisateur DROP CONSTRAINT utilisateur_identifiant_key;
       public            postgres    false    233         �           2606    23156    utilisateur utilisateur_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.utilisateur DROP CONSTRAINT utilisateur_pkey;
       public            postgres    false    233         �           2606    23158    vente vente_no_vente_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_no_vente_key UNIQUE (no_vente);
 B   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_no_vente_key;
       public            postgres    false    235         �           2606    23160    vente vente_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_pkey;
       public            postgres    false    235         �           2620    23376    utilisateur trigger_connexion    TRIGGER     �   CREATE TRIGGER trigger_connexion AFTER INSERT OR UPDATE ON public.utilisateur FOR EACH ROW EXECUTE FUNCTION public.log_connexion();
 6   DROP TRIGGER trigger_connexion ON public.utilisateur;
       public          postgres    false    233    239         �           2606    23161    bilan bilan_facture_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_facture_id_fkey FOREIGN KEY (facture_id) REFERENCES public.facture(id);
 E   ALTER TABLE ONLY public.bilan DROP CONSTRAINT bilan_facture_id_fkey;
       public          postgres    false    219    4718    215         �           2606    23166    bilan bilan_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);
 I   ALTER TABLE ONLY public.bilan DROP CONSTRAINT bilan_utilisateur_id_fkey;
       public          postgres    false    215    233    4742         �           2606    23171 %   commande commande_fournisseur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_fournisseur_id_fkey FOREIGN KEY (fournisseur_id) REFERENCES public.fournisseur(id);
 O   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_fournisseur_id_fkey;
       public          postgres    false    217    221    4724         �           2606    23176 %   commande commande_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);
 O   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_utilisateur_id_fkey;
       public          postgres    false    4742    217    233         �           2606    23181    facture facture_vente_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);
 G   ALTER TABLE ONLY public.facture DROP CONSTRAINT facture_vente_id_fkey;
       public          postgres    false    4746    235    219         �           2606    23186 ,   lignecommande lignecommande_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(id);
 V   ALTER TABLE ONLY public.lignecommande DROP CONSTRAINT lignecommande_commande_id_fkey;
       public          postgres    false    217    223    4714         �           2606    23191 .   lignecommande lignecommande_medicament_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);
 X   ALTER TABLE ONLY public.lignecommande DROP CONSTRAINT lignecommande_medicament_id_fkey;
       public          postgres    false    4732    229    223         �           2606    23196 (   lignevente lignevente_medicament_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);
 R   ALTER TABLE ONLY public.lignevente DROP CONSTRAINT lignevente_medicament_id_fkey;
       public          postgres    false    225    4732    229         �           2606    23201 *   lignevente lignevente_prescription_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescription(id);
 T   ALTER TABLE ONLY public.lignevente DROP CONSTRAINT lignevente_prescription_id_fkey;
       public          postgres    false    225    4736    231         �           2606    23206 #   lignevente lignevente_vente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);
 M   ALTER TABLE ONLY public.lignevente DROP CONSTRAINT lignevente_vente_id_fkey;
       public          postgres    false    235    225    4746         �           2606    23211 $   livraison livraison_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(no_commande);
 N   ALTER TABLE ONLY public.livraison DROP CONSTRAINT livraison_commande_id_fkey;
       public          postgres    false    4712    227    217         �           2606    23216    vente vente_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);
 I   ALTER TABLE ONLY public.vente DROP CONSTRAINT vente_utilisateur_id_fkey;
       public          postgres    false    235    4742    233                                            4905.dat                                                                                            0000600 0004000 0002000 00000000026 15002352226 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	2025-04-17	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          4907.dat                                                                                            0000600 0004000 0002000 00000000005 15002352226 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4928.dat                                                                                            0000600 0004000 0002000 00000000220 15002352226 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Admin	DECONNEXION	2025-04-24 09:25:36.972913
2	Admin	CONNEXION	2025-04-24 09:29:19.036839
3	Admin	DECONNEXION	2025-04-24 09:29:28.064282
\.


                                                                                                                                                                                                                                                                                                                                                                                4909.dat                                                                                            0000600 0004000 0002000 00000000037 15002352226 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	10799	2025-04-17	5.20	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 4911.dat                                                                                            0000600 0004000 0002000 00000001070 15002352226 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Medisupply Ltd	No. 45, Royal Road, Curepipe, Mauritius	Tél : +230 601 2345 | Email : contact@medisupply.mu
2	PharmaIsland Co	12, St Jean Road, Quatre Bornes, Mauritius	Tél : +230 466 7890 | Email : info@pharmisland.mu
4	IslandMed Distribution	3, Victoria Street, Rose Hill, Mauritius	Tél : +230 464 1122 | Email : hello@islandmed.mu
5	SunHealth Ltd	21, Coastal Road, Grand Baie, Mauritius	Tél : +230 263 4455 | Email : support@sunhealth.mu
3	Tropic Pharma	9, John Kennedy Avenue, Port Louis, Mauritius	Tél : +230 212 9988 | Email : service@tropicpharma.mu
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                        4913.dat                                                                                            0000600 0004000 0002000 00000000005 15002352226 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4915.dat                                                                                            0000600 0004000 0002000 00000000033 15002352226 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	6	1	5.20	\N	Libre
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     4917.dat                                                                                            0000600 0004000 0002000 00000000005 15002352226 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4919.dat                                                                                            0000600 0004000 0002000 00000003704 15002352226 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Doliprane	2.50	4.00	100	10	200	t	Comprimé	Analgésique	500mg	1
2	Efferalgan	3.00	5.00	80	10	150	t	Comprimé effervescent	Analgésique	500mg	1
3	Ibuprofène	1.80	3.50	60	15	100	t	Comprimé	Anti-inflammatoire	400mg	2
4	Amoxicilline	5.00	8.50	70	20	120	t	Capsule	Antibiotique	500mg	2
5	RhinAdvil	4.50	6.90	50	10	100	t	Comprimé	Décongestionnant	200mg	3
7	Ventoline	6.00	10.00	30	5	60	t	Spray	Bronchodilatateur	100mcg	4
8	Doliprane Enfant	2.00	3.50	60	5	100	f	Sirop	Analgésique	250mg/5ml	4
9	Clamoxyl	4.00	7.00	50	10	90	t	Comprimé	Antibiotique	500mg	5
10	Zyrtec	3.20	6.00	40	10	80	f	Comprimé	Antihistaminique	10mg	5
11	Paracétamol	1.50	2.50	150	20	300	f	Comprimé	Analgésique	500mg	1
12	Augmentin	7.00	12.00	30	5	70	t	Comprimé	Antibiotique	875mg/125mg	1
13	Célestène	4.00	6.50	25	5	60	t	Sirop	Corticoïde	0.5mg/ml	2
14	Hextril	3.50	5.80	35	5	70	f	Bain de bouche	Antiseptique	250ml	2
15	Spasfon	2.20	4.00	80	10	150	f	Comprimé	Antispasmodique	80mg	3
16	Smecta	1.90	3.50	90	15	120	f	Sachet	Antidiarrhéique	3g	3
17	Imodium	2.60	4.70	40	10	80	f	Capsule	Antidiarrhéique	2mg	4
18	Polysiane Crème	4.50	7.90	20	5	40	f	Crème	Dermatologique	100ml	4
19	Actifed	3.20	5.50	30	5	70	t	Comprimé	Décongestionnant	60mg	5
20	Exomuc	3.00	5.20	40	10	90	f	Sachet	Expectorant	200mg	5
21	Dafalgan	2.70	4.50	70	15	120	f	Comprimé	Analgésique	500mg	1
22	Nurofen	3.80	6.20	60	10	100	t	Comprimé	Anti-inflammatoire	400mg	1
23	Gaviscon	4.00	6.50	50	10	90	f	Comprimé à croquer	Antiacide	500mg	2
24	Maalox	3.50	5.90	40	10	80	f	Suspension	Antiacide	250mg/5ml	2
25	DoliNuit	4.20	6.80	30	5	60	t	Capsule	Somnifère	25mg	3
26	Euphytose	5.00	8.00	40	10	80	f	Comprimé	Sédatif	Variable	3
27	Panadol	2.60	4.10	90	20	180	f	Comprimé	Analgésique	500mg	4
28	Strepsils	3.10	5.30	50	10	100	f	Pastille	Antiseptique	2mg	4
29	Tiorfan	3.80	6.10	30	5	70	f	Capsule	Antidiarrhéique	100mg	5
30	Telfast	4.50	7.20	35	10	80	f	Comprimé	Antihistaminique	180mg	5
6	Toplexil	2.90	5.20	39	10	90	f	Sirop	Antitussif	100ml	3
\.


                                                            4921.dat                                                                                            0000600 0004000 0002000 00000000005 15002352226 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4923.dat                                                                                            0000600 0004000 0002000 00000000217 15002352226 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	Vendeur	Vendeur	Vendeur	vendeur@gmail.com	+230 1234 1234	0000	Vendeur	f
1	Admin	Admin	Admin	admin@gmail.com	+230 1234 1234	0000	Admin	f
\.


                                                                                                                                                                                                                                                                                                                                                                                 4925.dat                                                                                            0000600 0004000 0002000 00000000053 15002352226 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	68	2025-04-17	Libre	5.20	FACTURÉ	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     restore.sql                                                                                         0000600 0004000 0002000 00000064747 15002352226 0015403 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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

DROP DATABASE pharmagest;
--
-- Name: pharmagest; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE pharmagest WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';


ALTER DATABASE pharmagest OWNER TO postgres;

\connect pharmagest

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
-- Name: log_connexion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_connexion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO connexion_log (nom_utilisateur, type_action)
        VALUES (NEW.nom, 'CONNEXION');
    ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.est_connecte = false AND OLD.est_connecte = true THEN
            INSERT INTO connexion_log (nom_utilisateur, type_action)
            VALUES (NEW.nom, 'DECONNEXION');
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_connexion() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
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
-- Name: bilan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bilan_id_seq OWNED BY public.bilan.id;


--
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
-- Name: commande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;


--
-- Name: connexion_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connexion_log (
    id integer NOT NULL,
    nom_utilisateur character varying(100),
    type_action character varying(20),
    date_heure timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.connexion_log OWNER TO postgres;

--
-- Name: connexion_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.connexion_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.connexion_log_id_seq OWNER TO postgres;

--
-- Name: connexion_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.connexion_log_id_seq OWNED BY public.connexion_log.id;


--
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
-- Name: facture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facture_id_seq OWNED BY public.facture.id;


--
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
-- Name: fournisseur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fournisseur_id_seq OWNED BY public.fournisseur.id;


--
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
-- Name: lignecommande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lignecommande_id_seq OWNED BY public.lignecommande.id;


--
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
-- Name: lignevente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lignevente_id_seq OWNED BY public.lignevente.id;


--
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
-- Name: livraison_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livraison_id_seq OWNED BY public.livraison.id;


--
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
-- Name: medicament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicament_id_seq OWNED BY public.medicament.id;


--
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
-- Name: prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescription_id_seq OWNED BY public.prescription.id;


--
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
    statut character varying(255) NOT NULL,
    est_connecte boolean DEFAULT false
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
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
-- Name: utilisateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;


--
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
-- Name: vente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vente_id_seq OWNED BY public.vente.id;


--
-- Name: bilan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan ALTER COLUMN id SET DEFAULT nextval('public.bilan_id_seq'::regclass);


--
-- Name: commande id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);


--
-- Name: connexion_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connexion_log ALTER COLUMN id SET DEFAULT nextval('public.connexion_log_id_seq'::regclass);


--
-- Name: facture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture ALTER COLUMN id SET DEFAULT nextval('public.facture_id_seq'::regclass);


--
-- Name: fournisseur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur ALTER COLUMN id SET DEFAULT nextval('public.fournisseur_id_seq'::regclass);


--
-- Name: lignecommande id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande ALTER COLUMN id SET DEFAULT nextval('public.lignecommande_id_seq'::regclass);


--
-- Name: lignevente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente ALTER COLUMN id SET DEFAULT nextval('public.lignevente_id_seq'::regclass);


--
-- Name: livraison id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison ALTER COLUMN id SET DEFAULT nextval('public.livraison_id_seq'::regclass);


--
-- Name: medicament id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament ALTER COLUMN id SET DEFAULT nextval('public.medicament_id_seq'::regclass);


--
-- Name: prescription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription ALTER COLUMN id SET DEFAULT nextval('public.prescription_id_seq'::regclass);


--
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- Name: vente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente ALTER COLUMN id SET DEFAULT nextval('public.vente_id_seq'::regclass);


--
-- Data for Name: bilan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bilan (id, facture_id, date_vente, utilisateur_id) FROM stdin;
\.
COPY public.bilan (id, facture_id, date_vente, utilisateur_id) FROM '$$PATH$$/4905.dat';

--
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commande (id, no_commande, date_commande, prix_total, fournisseur_id, utilisateur_id, statut) FROM stdin;
\.
COPY public.commande (id, no_commande, date_commande, prix_total, fournisseur_id, utilisateur_id, statut) FROM '$$PATH$$/4907.dat';

--
-- Data for Name: connexion_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.connexion_log (id, nom_utilisateur, type_action, date_heure) FROM stdin;
\.
COPY public.connexion_log (id, nom_utilisateur, type_action, date_heure) FROM '$$PATH$$/4928.dat';

--
-- Data for Name: facture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facture (id, numero_facture, date_emission, montant_total, vente_id) FROM stdin;
\.
COPY public.facture (id, numero_facture, date_emission, montant_total, vente_id) FROM '$$PATH$$/4909.dat';

--
-- Data for Name: fournisseur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fournisseur (id, nom, adresse, contact) FROM stdin;
\.
COPY public.fournisseur (id, nom, adresse, contact) FROM '$$PATH$$/4911.dat';

--
-- Data for Name: lignecommande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lignecommande (id, commande_id, medicament_id, quantites, prix_achat) FROM stdin;
\.
COPY public.lignecommande (id, commande_id, medicament_id, quantites, prix_achat) FROM '$$PATH$$/4913.dat';

--
-- Data for Name: lignevente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lignevente (id, vente_id, medicament_id, quantite, prix_unitaire, prescription_id, typevente) FROM stdin;
\.
COPY public.lignevente (id, vente_id, medicament_id, quantite, prix_unitaire, prescription_id, typevente) FROM '$$PATH$$/4915.dat';

--
-- Data for Name: livraison; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livraison (id, date_livraison, status, commande_id) FROM stdin;
\.
COPY public.livraison (id, date_livraison, status, commande_id) FROM '$$PATH$$/4917.dat';

--
-- Data for Name: medicament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicament (id, nom, prix_achat, prix_vente, stock, seuil_alerte, quantite_max, necessite_prescription, forme_medicament, famille, dosage, fournisseur_id) FROM stdin;
\.
COPY public.medicament (id, nom, prix_achat, prix_vente, stock, seuil_alerte, quantite_max, necessite_prescription, forme_medicament, famille, dosage, fournisseur_id) FROM '$$PATH$$/4919.dat';

--
-- Data for Name: prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription (id, numero_prescription, nom_medecin, date_prescription, nom_patient, medicament) FROM stdin;
\.
COPY public.prescription (id, numero_prescription, nom_medecin, date_prescription, nom_patient, medicament) FROM '$$PATH$$/4921.dat';

--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, nom, prenom, identifiant, email, numero, motdepasse, statut, est_connecte) FROM stdin;
\.
COPY public.utilisateur (id, nom, prenom, identifiant, email, numero, motdepasse, statut, est_connecte) FROM '$$PATH$$/4923.dat';

--
-- Data for Name: vente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente (id, no_vente, date_vente, type_vente, prix_total, statut_vente, utilisateur_id) FROM stdin;
\.
COPY public.vente (id, no_vente, date_vente, type_vente, prix_total, statut_vente, utilisateur_id) FROM '$$PATH$$/4925.dat';

--
-- Name: bilan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilan_id_seq', 1, true);


--
-- Name: commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_seq', 1, false);


--
-- Name: connexion_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.connexion_log_id_seq', 3, true);


--
-- Name: facture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facture_id_seq', 1, true);


--
-- Name: fournisseur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fournisseur_id_seq', 6, true);


--
-- Name: lignecommande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lignecommande_id_seq', 1, false);


--
-- Name: lignevente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lignevente_id_seq', 1, true);


--
-- Name: livraison_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livraison_id_seq', 1, false);


--
-- Name: medicament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicament_id_seq', 33, true);


--
-- Name: prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescription_id_seq', 1, false);


--
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 7, true);


--
-- Name: vente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vente_id_seq', 1, true);


--
-- Name: bilan bilan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_pkey PRIMARY KEY (id);


--
-- Name: commande commande_no_commande_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_no_commande_key UNIQUE (no_commande);


--
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);


--
-- Name: connexion_log connexion_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.connexion_log
    ADD CONSTRAINT connexion_log_pkey PRIMARY KEY (id);


--
-- Name: facture facture_numero_facture_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_numero_facture_key UNIQUE (numero_facture);


--
-- Name: facture facture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_pkey PRIMARY KEY (id);


--
-- Name: facture facture_vente_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_key UNIQUE (vente_id);


--
-- Name: fournisseur fournisseur_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_nom_key UNIQUE (nom);


--
-- Name: fournisseur fournisseur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fournisseur
    ADD CONSTRAINT fournisseur_pkey PRIMARY KEY (id);


--
-- Name: lignecommande lignecommande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_pkey PRIMARY KEY (id);


--
-- Name: lignevente lignevente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_pkey PRIMARY KEY (id);


--
-- Name: livraison livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_pkey PRIMARY KEY (id);


--
-- Name: medicament medicament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament
    ADD CONSTRAINT medicament_pkey PRIMARY KEY (id);


--
-- Name: prescription prescription_numero_prescription_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_numero_prescription_key UNIQUE (numero_prescription);


--
-- Name: prescription prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (id);


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- Name: utilisateur utilisateur_identifiant_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_identifiant_key UNIQUE (identifiant);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: vente vente_no_vente_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_no_vente_key UNIQUE (no_vente);


--
-- Name: vente vente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_pkey PRIMARY KEY (id);


--
-- Name: utilisateur trigger_connexion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_connexion AFTER INSERT OR UPDATE ON public.utilisateur FOR EACH ROW EXECUTE FUNCTION public.log_connexion();


--
-- Name: bilan bilan_facture_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_facture_id_fkey FOREIGN KEY (facture_id) REFERENCES public.facture(id);


--
-- Name: bilan bilan_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan
    ADD CONSTRAINT bilan_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: commande commande_fournisseur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_fournisseur_id_fkey FOREIGN KEY (fournisseur_id) REFERENCES public.fournisseur(id);


--
-- Name: commande commande_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: facture facture_vente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facture
    ADD CONSTRAINT facture_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);


--
-- Name: lignecommande lignecommande_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(id);


--
-- Name: lignecommande lignecommande_medicament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignecommande
    ADD CONSTRAINT lignecommande_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);


--
-- Name: lignevente lignevente_medicament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_medicament_id_fkey FOREIGN KEY (medicament_id) REFERENCES public.medicament(id);


--
-- Name: lignevente lignevente_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescription(id);


--
-- Name: lignevente lignevente_vente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lignevente
    ADD CONSTRAINT lignevente_vente_id_fkey FOREIGN KEY (vente_id) REFERENCES public.vente(id);


--
-- Name: livraison livraison_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraison
    ADD CONSTRAINT livraison_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commande(no_commande);


--
-- Name: vente vente_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente
    ADD CONSTRAINT vente_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         