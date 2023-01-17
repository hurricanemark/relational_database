--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (2, 'Al', 1, 14);
INSERT INTO public.users VALUES (3, 'Mama', 1, 10);
INSERT INTO public.users VALUES (4, 'Al Pine', 1, 14);
INSERT INTO public.users VALUES (34, 'user_1673931734946', 1, 305);
INSERT INTO public.users VALUES (7, 'Ernie Swatter', 1, 14);
INSERT INTO public.users VALUES (33, 'user_1673931734947', 1, 186);
INSERT INTO public.users VALUES (28, 'Rolly Polly', 1, 4);
INSERT INTO public.users VALUES (36, 'user_1673931854260', 1, 673);
INSERT INTO public.users VALUES (35, 'user_1673931854261', 1, 275);
INSERT INTO public.users VALUES (1, 'Momo', 4, 9);
INSERT INTO public.users VALUES (38, 'user_1673931944481', 1, 19);
INSERT INTO public.users VALUES (37, 'user_1673931944482', 1, 79);
INSERT INTO public.users VALUES (40, 'user_1673932037055', 1, 414);
INSERT INTO public.users VALUES (39, 'user_1673932037056', 1, 146);
INSERT INTO public.users VALUES (42, 'user_1673932055800', 1, 46);
INSERT INTO public.users VALUES (41, 'user_1673932055801', 1, 249);
INSERT INTO public.users VALUES (30, 'user_1673931618537', 1, 186);
INSERT INTO public.users VALUES (29, 'user_1673931618538', 1, 11);
INSERT INTO public.users VALUES (32, 'user_1673931677725', 1, 76);
INSERT INTO public.users VALUES (31, 'user_1673931677726', 1, 78);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 42, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

