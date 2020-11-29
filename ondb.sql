PGDMP     &            	    
    x            ondb    13.0    13.0 *    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24648    ondb    DATABASE     h   CREATE DATABASE ondb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1256';
    DROP DATABASE ondb;
             	   onnetwork    false            �            1259    24790    account_type    TABLE     u   CREATE TABLE public.account_type (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    acc_type bigint NOT NULL
);
     DROP TABLE public.account_type;
       public         heap 	   onnetwork    false            �            1259    24786    account_type_id_seq    SEQUENCE     |   CREATE SEQUENCE public.account_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.account_type_id_seq;
       public       	   onnetwork    false    212            �           0    0    account_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.account_type_id_seq OWNED BY public.account_type.id;
          public       	   onnetwork    false    210            �            1259    24788    account_type_u_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.account_type_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.account_type_u_id_seq;
       public       	   onnetwork    false    212            �           0    0    account_type_u_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.account_type_u_id_seq OWNED BY public.account_type.u_id;
          public       	   onnetwork    false    211            �            1259    24766    pw_reset    TABLE     �   CREATE TABLE public.pw_reset (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    reset_key character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
    DROP TABLE public.pw_reset;
       public         heap 	   onnetwork    false            �            1259    24762    pw_reset_id_seq    SEQUENCE     x   CREATE SEQUENCE public.pw_reset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.pw_reset_id_seq;
       public       	   onnetwork    false    209            �           0    0    pw_reset_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.pw_reset_id_seq OWNED BY public.pw_reset.id;
          public       	   onnetwork    false    207            �            1259    24764    pw_reset_u_id_seq    SEQUENCE     z   CREATE SEQUENCE public.pw_reset_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pw_reset_u_id_seq;
       public       	   onnetwork    false    209            �           0    0    pw_reset_u_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pw_reset_u_id_seq OWNED BY public.pw_reset.u_id;
          public       	   onnetwork    false    208            �            1259    24732    sessions    TABLE     �   CREATE TABLE public.sessions (
    id bigint NOT NULL,
    u_id bigint NOT NULL,
    user_agent character varying NOT NULL,
    session_key character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
    DROP TABLE public.sessions;
       public         heap 	   onnetwork    false            �            1259    24728    sessions_id_seq1    SEQUENCE     y   CREATE SEQUENCE public.sessions_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sessions_id_seq1;
       public       	   onnetwork    false    206            �           0    0    sessions_id_seq1    SEQUENCE OWNED BY     D   ALTER SEQUENCE public.sessions_id_seq1 OWNED BY public.sessions.id;
          public       	   onnetwork    false    204            �            1259    24730    sessions_u_id_seq1    SEQUENCE     {   CREATE SEQUENCE public.sessions_u_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sessions_u_id_seq1;
       public       	   onnetwork    false    206            �           0    0    sessions_u_id_seq1    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.sessions_u_id_seq1 OWNED BY public.sessions.u_id;
          public       	   onnetwork    false    205            �            1259    24651    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    verified boolean NOT NULL
);
    DROP TABLE public.users;
       public         heap 	   onnetwork    false            �            1259    24649    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       	   onnetwork    false    201            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public       	   onnetwork    false    200            �            1259    24662    verification_codes    TABLE     �   CREATE TABLE public.verification_codes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    vc character varying NOT NULL,
    "time" timestamp with time zone NOT NULL
);
 &   DROP TABLE public.verification_codes;
       public         heap 	   onnetwork    false            �            1259    24660    verification_codes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.verification_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.verification_codes_id_seq;
       public       	   onnetwork    false    203            �           0    0    verification_codes_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.verification_codes_id_seq OWNED BY public.verification_codes.id;
          public       	   onnetwork    false    202            J           2604    24793    account_type id    DEFAULT     r   ALTER TABLE ONLY public.account_type ALTER COLUMN id SET DEFAULT nextval('public.account_type_id_seq'::regclass);
 >   ALTER TABLE public.account_type ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    212    210    212            K           2604    24794    account_type u_id    DEFAULT     v   ALTER TABLE ONLY public.account_type ALTER COLUMN u_id SET DEFAULT nextval('public.account_type_u_id_seq'::regclass);
 @   ALTER TABLE public.account_type ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    212    211    212            H           2604    24769    pw_reset id    DEFAULT     j   ALTER TABLE ONLY public.pw_reset ALTER COLUMN id SET DEFAULT nextval('public.pw_reset_id_seq'::regclass);
 :   ALTER TABLE public.pw_reset ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    209    207    209            I           2604    24770    pw_reset u_id    DEFAULT     n   ALTER TABLE ONLY public.pw_reset ALTER COLUMN u_id SET DEFAULT nextval('public.pw_reset_u_id_seq'::regclass);
 <   ALTER TABLE public.pw_reset ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    209    208    209            F           2604    24735    sessions id    DEFAULT     k   ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq1'::regclass);
 :   ALTER TABLE public.sessions ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    204    206    206            G           2604    24736    sessions u_id    DEFAULT     o   ALTER TABLE ONLY public.sessions ALTER COLUMN u_id SET DEFAULT nextval('public.sessions_u_id_seq1'::regclass);
 <   ALTER TABLE public.sessions ALTER COLUMN u_id DROP DEFAULT;
       public       	   onnetwork    false    206    205    206            D           2604    24654    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    201    200    201            E           2604    24665    verification_codes id    DEFAULT     ~   ALTER TABLE ONLY public.verification_codes ALTER COLUMN id SET DEFAULT nextval('public.verification_codes_id_seq'::regclass);
 D   ALTER TABLE public.verification_codes ALTER COLUMN id DROP DEFAULT;
       public       	   onnetwork    false    202    203    203            U           2606    24796    account_type account_type_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.account_type DROP CONSTRAINT account_type_pkey;
       public         	   onnetwork    false    212            S           2606    24775    pw_reset pw_reset_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pw_reset
    ADD CONSTRAINT pw_reset_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.pw_reset DROP CONSTRAINT pw_reset_pkey;
       public         	   onnetwork    false    209            Q           2606    24741    sessions sessions_pkey1 
   CONSTRAINT     U   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey1 PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey1;
       public         	   onnetwork    false    206            M           2606    24659    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         	   onnetwork    false    201            O           2606    24670 *   verification_codes verification_codes_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT verification_codes_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.verification_codes DROP CONSTRAINT verification_codes_pkey;
       public         	   onnetwork    false    203            W           2606    24742    sessions user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public.sessions DROP CONSTRAINT user_id;
       public       	   onnetwork    false    2893    206    201            X           2606    24781    pw_reset user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pw_reset
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 :   ALTER TABLE ONLY public.pw_reset DROP CONSTRAINT user_id;
       public       	   onnetwork    false    201    2893    209            Y           2606    24797    account_type user_id    FK CONSTRAINT     p   ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT user_id FOREIGN KEY (u_id) REFERENCES public.users(id);
 >   ALTER TABLE ONLY public.account_type DROP CONSTRAINT user_id;
       public       	   onnetwork    false    212    201    2893            V           2606    24671    verification_codes user_vc    FK CONSTRAINT     �   ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT user_vc FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.verification_codes DROP CONSTRAINT user_vc;
       public       	   onnetwork    false    203    201    2893           