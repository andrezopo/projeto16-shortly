--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" bigint DEFAULT date_part('epoch'::text, now()) NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: shortenedUrls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."shortenedUrls" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "shortUrl" text NOT NULL,
    url text NOT NULL,
    "visitCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."shortenedUrls" OWNER TO postgres;

--
-- Name: shortenedUrls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."shortenedUrls_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."shortenedUrls_id_seq" OWNER TO postgres;

--
-- Name: shortenedUrls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."shortenedUrls_id_seq" OWNED BY public."shortenedUrls".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(60) NOT NULL,
    password text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "visitCount" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: shortenedUrls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortenedUrls" ALTER COLUMN id SET DEFAULT nextval('public."shortenedUrls_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, "userId", token, "createdAt", "updatedAt") FROM stdin;
1	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvYW9AZHJpdmVuLmNvbS5iciIsImlhdCI6MTY1OTkxOTA5M30.6750G7T6x2rsfQsXV0IHN2hl2NIPkgsVbGnwkaPfjKY	2022-08-07 21:38:13.376939	1659931018
3	2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImdpYmFAZHJpdmVuLmNvbS5iciIsImlhdCI6MTY1OTkyODUxM30.Sb8LiPd-Ovps8N15E883CBjkKnu8LcssHwjDS5YRr04	2022-08-08 00:15:13.154257	1659931018
2	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvYW9AZHJpdmVuLmNvbS5iciIsImlhdCI6MTY1OTkyMTc0OX0.Du_sqXqvUl_KfX80kJgnMt1mJ7H4QdMundYBzdiIpmo	2022-08-07 22:22:29.497435	1659931338539
\.


--
-- Data for Name: shortenedUrls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."shortenedUrls" (id, "userId", "shortUrl", url, "visitCount", "createdAt") FROM stdin;
2	1	NXnkYHsv	https://figuradosabiah.jpg	5	2022-08-07 23:11:55.388963
3	2	8z9wEXfz	https://figuradosabiah.jpg	10	2022-08-08 00:15:46.126979
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, "createdAt", "visitCount") FROM stdin;
1	João	joao@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkxODY0MH0.gi0zHuzPQMMMxVX_KEkVI97suS0CTnHOZbc9UYtLjw0	2022-08-07 21:30:40.143886	2
2	Gilberto	giba@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkyODQ2MX0.3833iz7tOVonAPkWKfMe2JWUayFjgJ39EFM9gLZTLgw	2022-08-08 00:14:21.990215	10
3	Gilberto	gavea@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkyODczN30.7ljMByslrR0sEA7A_37m9997xpsGYvnhJIVFOwEBovQ	2022-08-08 00:18:57.171257	0
4	Nadia	senhora@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkyODc0NX0.9_G5BK8bLVRRWPNQWQK5x9dQU-vWo_KEDXyuyiT1-VI	2022-08-08 00:19:05.615964	0
5	Nimaria	obtusa@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkyODc1NH0.nS3lb9uMMtNot0wJeeqwOtueWC3Cix3eNlmwFWtV8sg	2022-08-08 00:19:14.003865	0
6	Silabão	Sabio@driven.com.br	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXNzd29yZCI6IkRyaXZlbjEyMyIsImlhdCI6MTY1OTkyODc2M30.RRDM0T-n_8z_0BYHqPQ6gPpfPjdPK363j_G5UysqIiU	2022-08-08 00:19:23.301271	0
\.


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 3, true);


--
-- Name: shortenedUrls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."shortenedUrls_id_seq"', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- Name: shortenedUrls shortenedUrls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortenedUrls"
    ADD CONSTRAINT "shortenedUrls_pkey" PRIMARY KEY (id);


--
-- Name: shortenedUrls shortenedUrls_shortUrl_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortenedUrls"
    ADD CONSTRAINT "shortenedUrls_shortUrl_key" UNIQUE ("shortUrl");


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: shortenedUrls shortenedUrls_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."shortenedUrls"
    ADD CONSTRAINT "shortenedUrls_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

