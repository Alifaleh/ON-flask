PGDMP     7    8                y            ondb    13.0    13.0 J               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            
           1262    24874    ondb    DATABASE     h   CREATE DATABASE ondb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1256';
    DROP DATABASE ondb;
             	   onnetwork    false            �            1259    24960    account_admin_log    TABLE     �  CREATE TABLE public.account_admin_log (
    admin_id bigint NOT NULL,
    effected_id bigint NOT NULL,
    changed_columns character varying,
    old_values character varying,
    new_values character varying,
    deleted_sessions character varying,
    deleted_vc character varying,
    deleted_pr character varying,
    sent_ve boolean,
    sent_pre boolean,
    date time with time zone
);
 %   DROP TABLE public.account_admin_log;
       public         heap 	   onnetwork    false            �            1259    24956    account_admin_log_admin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_admin_log_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.account_admin_log_admin_id_seq;
       public       	   onnetwork    false    215                       0    0    account_admin_log_admin_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.account_admin_log_admin_id_seq OWNED BY public.account_admin_log.admin_id;
          public       	   onnetwork    false    213            �            1259    24958 !   account_admin_log_effected_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_admin_log_effected_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.account_admin_log_effected_id_seq;
       public       	   onnetwork    false    215                       0    0 !   account_admin_log_effected_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.account_admin_log_effected_id_seq OWNED BY public.account_admin_log.effected_id;
          public       	   onnetwork    false    214            �            1259    24875    account_type    TABLE     u   CREATE TABLE public.account_type (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    acc_type bigint NOT NULL
);
     DROP TABLE public.account_type;
       public         heap 	   onnetwork    false            �            1259    24878    account_type_id_seq    SEQUENCE     |   CREATE SEQUENCE public.account_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.account_type_id_seq;
       public       	   onnetwork    false    200                       0    0    account_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.account_type_id_seq OWNED BY public.account_type.id;
          public       	   onnetwork    false    201            �            1259    24880    account_type_u_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.account_type_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.account_type_u_id_seq;
       public       	   onnetwork    false    200                       0    0    account_type_u_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.account_type_u_id_seq OWNED BY public.account_type.u_id;
          public       	   onnetwork    false    202            �            1259    33168    products    TABLE     �   CREATE TABLE public.products (
    id bigint NOT NULL,
    title character varying NOT NULL,
    discription character varying NOT NULL,
    price character varying NOT NULL,
    p_order integer NOT NULL,
    image_name character varying NOT NULL
);
    DROP TABLE public.products;
       public         heap 	   onnetwork    false            �            1259    33166    products_id_seq    SEQUENCE     x   CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public       	   onnetwork    false    217                       0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public       	   onnetwork    false    216            �            1259    24882    pw_reset    TABLE     �   CREATE TABLE public.pw_reset (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    reset_key character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
    DROP TABLE public.pw_reset;
       public         heap 	   onnetwork    false            �            1259    24888    pw_reset_id_seq    SEQUENCE     x   CREATE SEQUENCE public.pw_reset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.pw_reset_id_seq;
       public       	   onnetwork    false    203                       0    0    pw_reset_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.pw_reset_id_seq OWNED BY public.pw_reset.id;
          public       	   onnetwork    false    204            �            1259    24890    pw_reset_u_id_seq    SEQUENCE     z   CREATE SEQUENCE public.pw_reset_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pw_reset_u_id_seq;
       public       	   onnetwork    false    203                       0    0    pw_reset_u_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pw_reset_u_id_seq OWNED BY public.pw_reset.u_id;
          public       	   onnetwork    false    205            �            1259    24892    sessions    TABLE     �   CREATE TABLE public.sessions (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    user_agent character varying NOT NULL,
    session_key character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
    DROP TABLE public.sessions;
       public         heap 	   onnetwork    false            �            1259    24898    sessions_id_seq1    SEQUENCE     y   CREATE SEQUENCE public.sessions_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sessions_id_seq1;
       public       	   onnetwork    false    206                       0    0    sessions_id_seq1    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.sessions_id_seq1 OWNED BY public.sessions.id;
          public       	   onnetwork    false    207            �            1259    24900    sessions_u_id_seq1    SEQUENCE     {   CREATE SEQUENCE public.sessions_u_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sessions_u_id_seq1;
       public       	   onnetwork    false    206                       0    0    sessions_u_id_seq1    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.sessions_u_id_seq1 OWNED BY public.sessions.u_id;
          public       	   onnetwork    false    208            �            1259    24902    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    verified boolean NOT NULL
);
    DROP TABLE public.users;
       public         heap 	   onnetwork    false            �            1259    24908    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       	   onnetwork    false    209                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public       	   onnetwork    false    210            �            1259    24910    verification_codes    TABLE     �   CREATE TABLE public.verification_codes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    vc character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
 &   DROP TABLE public.verification_codes;
       public         heap 	   onnetwork    false            �            1259    24916    verification_codes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.verification_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.verification_codes_id_seq;
       public       	   onnetwork    false    211                       0    0    verification_codes_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.verification_codes_id_seq OWNED BY public.verification_codes.id;
          public       	   onnetwork    false    212            \           2604    24963    account_admin_log admin_id    DEFAULT     �   ALTER TABLE ONLY public.account_admin_log ALTER COLUMN admin_id SET DEFAULT nextval('public.account_admin_log_admin_id_seq'::regclass);
 I   ALTER TABLE public.account_admin_log ALTER COLUMN admin_id DROP DEFAULT;
       public       	   onnetwork    false    213    215    215            ]           2604    24964    account_admin_log effected_id    DEFAULT     �   ALTER TABLE ONLY public.account_admin_log ALTER COLUMN effected_id SET DEFAULT nextval('public.account_admin_log_effected_id_seq'::regclass);
 L   ALTER TABLE public.account_admin_log ALTER COLUMN effected_id DROP DEFAULT;
       public       	   onnetwork    false    214    215    215            T           2604    24918    account_type id    DEFAULT     r   ALTER TABLE ONLY public.account_type ALTER COLUMN id SET DEFAULT nextval('public.account_type_id_seq'::regclass);
 >   ALTER TABLE public.account_type ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    201    200            U           2604    24919    account_type u_id    DEFAULT     v   ALTER TABLE ONLY public.account_type ALTER COLUMN u_id SET DEFAULT nextval('public.account_type_u_id_seq'::regclass);
 @   ALTER TABLE public.account_type ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    202    200            ^           2604    33171    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    217    216    217            V           2604    24920    pw_reset id    DEFAULT     j   ALTER TABLE ONLY public.pw_reset ALTER COLUMN id SET DEFAULT nextval('public.pw_reset_id_seq'::regclass);
 :   ALTER TABLE public.pw_reset ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    204    203            W           2604    24921    pw_reset u_id    DEFAULT     n   ALTER TABLE ONLY public.pw_reset ALTER COLUMN u_id SET DEFAULT nextval('public.pw_reset_u_id_seq'::regclass);
 <   ALTER TABLE public.pw_reset ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    205    203            X           2604    24922    sessions id    DEFAULT     k   ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq1'::regclass);
 :   ALTER TABLE public.sessions ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    207    206            Y           2604    24923    sessions u_id    DEFAULT     o   ALTER TABLE ONLY public.sessions ALTER COLUMN u_id SET DEFAULT nextval('public.sessions_u_id_seq1'::regclass);
 <   ALTER TABLE public.sessions ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    208    206            Z           2604    24924    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    210    209            [           2604    24925    verification_codes id    DEFAULT     ~   ALTER TABLE ONLY public.verification_codes ALTER COLUMN id SET DEFAULT nextval('public.verification_codes_id_seq'::regclass);
 D   ALTER TABLE public.verification_codes ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    212    211                      0    24960    account_admin_log 
   TABLE DATA           �   COPY public.account_admin_log (admin_id, effected_id, changed_columns, old_values, new_values, deleted_sessions, deleted_vc, deleted_pr, sent_ve, sent_pre, date) FROM stdin;
    public       	   onnetwork    false    215   WT       �          0    24875    account_type 
   TABLE DATA           :   COPY public.account_type (id, u_id, acc_type) FROM stdin;
    public       	   onnetwork    false    200   �Y                 0    33168    products 
   TABLE DATA           V   COPY public.products (id, title, discription, price, p_order, image_name) FROM stdin;
    public       	   onnetwork    false    217   �Y       �          0    24882    pw_reset 
   TABLE DATA           ?   COPY public.pw_reset (id, u_id, reset_key, "time") FROM stdin;
    public       	   onnetwork    false    203   �\       �          0    24892    sessions 
   TABLE DATA           M   COPY public.sessions (id, u_id, user_agent, session_key, "time") FROM stdin;
    public       	   onnetwork    false    206   �\       �          0    24902    users 
   TABLE DATA           H   COPY public.users (id, username, email, password, verified) FROM stdin;
    public       	   onnetwork    false    209   �]       �          0    24910    verification_codes 
   TABLE DATA           E   COPY public.verification_codes (id, user_id, vc, "time") FROM stdin;
    public       	   onnetwork    false    211   c^                  0    0    account_admin_log_admin_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.account_admin_log_admin_id_seq', 1, false);
          public       	   onnetwork    false    213                       0    0 !   account_admin_log_effected_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.account_admin_log_effected_id_seq', 1, false);
          public       	   onnetwork    false    214                       0    0    account_type_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.account_type_id_seq', 6, true);
          public       	   onnetwork    false    201                       0    0    account_type_u_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.account_type_u_id_seq', 1, false);
          public       	   onnetwork    false    202                       0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 37, true);
          public       	   onnetwork    false    216                       0    0    pw_reset_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.pw_reset_id_seq', 25, true);
          public       	   onnetwork    false    204                       0    0    pw_reset_u_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pw_reset_u_id_seq', 1, false);
          public       	   onnetwork    false    205                       0    0    sessions_id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.sessions_id_seq1', 57, true);
          public       	   onnetwork    false    207                       0    0    sessions_u_id_seq1    SEQUENCE SET     A   SELECT pg_catalog.setval('public.sessions_u_id_seq1', 1, false);
          public       	   onnetwork    false    208                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 7, true);
          public       	   onnetwork    false    210                        0    0    verification_codes_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.verification_codes_id_seq', 130, true);
          public       	   onnetwork    false    212            `           2606    24927    account_type account_type_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.account_type DROP CONSTRAINT account_type_pkey;
       public         	   onnetwork    false    200            j           2606    33176    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public         	   onnetwork    false    217            b           2606    24929    pw_reset pw_reset_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pw_reset
    ADD CONSTRAINT pw_reset_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.pw_reset DROP CONSTRAINT pw_reset_pkey;
       public         	   onnetwork    false    203            d           2606    24931    sessions sessions_pkey1 
   CONSTRAINT     U   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey1 PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey1;
       public         	   onnetwork    false    206            f           2606    24933    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         	   onnetwork    false    209            h           2606    24935 *   verification_codes verification_codes_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT verification_codes_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.verification_codes DROP CONSTRAINT verification_codes_pkey;
       public         	   onnetwork    false    211            o           2606    24968    account_admin_log admin_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_admin_log
    ADD CONSTRAINT admin_id FOREIGN KEY (admin_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.account_admin_log DROP CONSTRAINT admin_id;
       public       	   onnetwork    false    209    215    2918            p           2606    24973    account_admin_log effected_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_admin_log
    ADD CONSTRAINT effected_id FOREIGN KEY (effected_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.account_admin_log DROP CONSTRAINT effected_id;
       public       	   onnetwork    false    2918    209    215            m           2606    24936    sessions user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.sessions DROP CONSTRAINT user_id;
       public       	   onnetwork    false    209    2918    206            l           2606    24941    pw_reset user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pw_reset
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 :   ALTER TABLE ONLY public.pw_reset DROP CONSTRAINT user_id;
       public       	   onnetwork    false    209    2918    203            k           2606    24946    account_type user_id    FK CONSTRAINT     p   ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id);
 >   ALTER TABLE ONLY public.account_type DROP CONSTRAINT user_id;
       public       	   onnetwork    false    209    200    2918            n           2606    24951    verification_codes user_vc    FK CONSTRAINT     �   ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT user_vc FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.verification_codes DROP CONSTRAINT user_vc;
       public       	   onnetwork    false    209    2918    211               =  x��W�nG}���bx���~As���q�8���J��k)NZ�2�8�$�9<��6�1����~�{�����~{�ez����6S}z��v�ܷ�՗��?�4��g��.Ўe�A�@w�s�ˠ���A�ϧ�q�6�E=A���/�������qz·���������V7�5/x����y]�#��9�?D|9ӟTZ8%mڌ1����d+�˄@'IFr��6����׏�?ˌ֭�0+���T���>���/�^���g�aqMN�7�ߊ�
��,(#cK�
�E.ڸV���ľ��@B0�q~G�9���OL_�+;�r�vDo�s�#�_�3���{4 E~m�7�:�kn��?,�w��1J&g�K'��aKW%�R2HzV�%��t ���7�\}4����O�$=�l�}�̒�H��0��M.dG2PY���G�.� "�5��>E�����.�z���e���$W��Y�X��ibŀv��Q�77Y���קϋǫ��S�,���{��qa4�h����<k �� N�8w6�"����r���&<�$%ƥA���z!u�Hm� ��˥�!�i��t���M�9,��vkX�T�7�g��h(�2����F�kNW�$5�ҭ��Ȑ��0^��x<a"��A�ٔ̄V5n4�?N�Jd5��G��4Zku�0��$��w�&��:�3a��[J�9��c#g�Qj� �=@`��Y ���Y3|�n�=�Ӽ�Vԩ5
��ˏ��D	Y8k/�?v�c�?�wQH���<���-�W�4�5��57� �C��*�u��A���g����L�M)���3`�0bwRD�ʁ�� c��8z���?m(�-��x��x��Uͱl�s����u�Kd�8�
�X#�go��-�
c���t�4���w�֓�1n�#՞Hu�p��n9gtV��%�N�%�W��.���J�	'aK�"Pq=�2��<�|��Ȓ��I�b��lsE#�r9���������xrx_@g���8n���:z����]�L)G��%	%I՚�e��-�).�.���
r��0��h�ȁ4ԑ�+��V��\2.#�+���9�b#�2�xԸ�f��6�6E�T|����f����RѠ��: 8gz�e��E.������t_$g"�^}A����ӧ��K~�s��?^.B���68��;Yi4s�vG�ɩ�z��^q����z�k.�� CU| ���eh}E���'y]�����u��m,����ǋ��Sjԓ�Y)9���J���Yн�����3�����V����O���ų���cp��{����+�����<7��zl������ߴ���      �   +   x��9 0�zL�Ȅ?�X��&��$�fww��;�>h��         �  x�Ք�n�0���S����I��^6 h�f@/F�m���J�S��h9.���.�$S�����g�S�=�q���.�U�s�C�IB�ਸ਼�t��PS �L	B�l�9���@�DpJ���!C���K>M�]��%y�Dh�|ѯ6mӊK�ڔ�<O~��[��,!9���:8c�1!��;�?~��,Y�W�a��F!Z������d����H�l�����n�����^qa���s��dr/[��B�V��o�V��$����s8���1_0��>����̦n�ֈX���A���S�Xt<�lM���J�pɃoE��ֺoe���!P�7��̧ն�}�J�t� P��@�*+�v��b~�ji�E���>�������R�p����*	DW��+�@g��Uk$��O;��ed^i�i*d3�P9�����Z_���m��^_�d�7���i�EV�vԋ�1,q�����Gu{�mO��v�qT*9��5�񺹆�kco5hD*��c�k�g�Y7��Y���h;�̠�P��ё��մz#n:Q��`��{���uq����<N)�����c��V��n4�"9f��ᙟD��=�pG����1���g%�g�a���%���b��Tty*�v�]���ѽ���l�g��      �      x������ � �      �      x�]�In�0 �5��}���s�n� �M���m������QQ�bw���Y�1��4�b�K�͇�E�D�4x$�]N{�xVv��a6�":q�] x�>ϴ @��x#�Bڂl��� �h��7���3��o�tyh<�*5n����Yzjn�g��at6v��p��v'~Hr�Z-`�4��x�\���6�XRYC�=������=Ĩ$�KX������p�ne/{u|��iq%$B��%���� ���Ϻ,�/ݿk
      �   �   x�m�=�0�99��6m�1����PSG$��Tq{ҨT u�OO.:���úV�6�G���{��겐1"H��� OǶ�I�6!������j�h��3w��A��v�V��s��Z���:~��>a
&�p�/�F��DOsuQV���R�\S�      �      x������ � �     