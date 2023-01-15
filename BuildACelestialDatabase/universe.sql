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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: class_luminosity; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.class_luminosity AS ENUM (
    'Subdwarf',
    'Dwarf',
    'Subgiant',
    'Giant',
    'Supergiant'
);


ALTER TYPE public.class_luminosity OWNER TO freecodecamp;

--
-- Name: coolness; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.coolness AS ENUM (
    'Awesome',
    'Sick',
    'Bomb',
    'Boring'
);


ALTER TYPE public.coolness OWNER TO freecodecamp;

--
-- Name: galaxy_type; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.galaxy_type AS ENUM (
    'Spiral',
    'Elliptical',
    'Perculiar',
    'Irregular',
    'Lenticular'
);


ALTER TYPE public.galaxy_type OWNER TO freecodecamp;

--
-- Name: planet_class; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.planet_class AS ENUM (
    'D',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'R',
    'T',
    'Y'
);


ALTER TYPE public.planet_class OWNER TO freecodecamp;

--
-- Name: specialization; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.specialization AS ENUM (
    'Ore Extraction',
    'ZeroGrav Manufacturing',
    'Space Tourism',
    'Military'
);


ALTER TYPE public.specialization OWNER TO freecodecamp;

--
-- Name: star_classification; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.star_classification AS ENUM (
    'Solar',
    'Hot Blue',
    'Red Dwarf',
    'Red Giant',
    'White Dwarf'
);


ALTER TYPE public.star_classification OWNER TO freecodecamp;

--
-- Name: stellar_classification; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.stellar_classification AS ENUM (
    'O',
    'B',
    'A',
    'F',
    'G',
    'K',
    'M'
);


ALTER TYPE public.stellar_classification OWNER TO freecodecamp;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    coolness_rank integer,
    formation_type public.galaxy_type,
    diameter numeric,
    blackholes numeric,
    habitable boolean DEFAULT true,
    barrered_center boolean,
    scientific_name character varying(100),
    CONSTRAINT galaxy_coolness_rank_check CHECK (((coolness_rank > 0) AND (coolness_rank < 11)))
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: mining_company; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.mining_company (
    mining_company_id integer NOT NULL,
    name character varying(100) NOT NULL,
    specialized public.specialization DEFAULT 'Ore Extraction'::public.specialization,
    valuation numeric,
    transportships integer,
    federationdesignation text,
    deepsapcecapable boolean DEFAULT true,
    weaponized boolean,
    planet_id integer
);


ALTER TABLE public.mining_company OWNER TO freecodecamp;

--
-- Name: minning_company_company_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.minning_company_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minning_company_company_id_seq OWNER TO freecodecamp;

--
-- Name: minning_company_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.minning_company_company_id_seq OWNED BY public.mining_company.mining_company_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    has_atmostphere boolean DEFAULT false,
    has_water boolean DEFAULT false,
    retro_rotation boolean DEFAULT false,
    moon_mass numeric,
    moon_size integer,
    mining_companies integer,
    human_bases integer,
    geolocked boolean DEFAULT false,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    planet_classification public.planet_class DEFAULT 'M'::public.planet_class,
    exo_planet boolean DEFAULT true,
    goldilock_zone boolean DEFAULT false,
    retro_orbit boolean DEFAULT false,
    planet_size numeric,
    planet_mass integer,
    planet_circumference integer,
    number_of_moons integer DEFAULT 0,
    active_electromagnetic boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_is_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_is_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_is_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_is_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_is_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    star_type public.star_classification,
    star_class public.stellar_classification,
    star_luminosity public.class_luminosity,
    star_temp numeric,
    star_mass integer,
    star_circumference integer,
    constellation text,
    going_supernova boolean DEFAULT false,
    binary_star boolean DEFAULT false,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: mining_company mining_company_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mining_company ALTER COLUMN mining_company_id SET DEFAULT nextval('public.minning_company_company_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_is_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milkyway', 10, 'Spiral', 102039235, 23513461, true, false, 'J22L345-OPTIC33-HAL2001');
INSERT INTO public.galaxy VALUES (21, 'Andromida', 9, 'Elliptical', 56435335, 22345281, true, false, 'OMICRON214-OPTIC76-HAL2010');
INSERT INTO public.galaxy VALUES (3, 'JhuntainStern', 4, 'Lenticular', 90659679, 52345, false, true, 'HALO-RING234-AWE102');
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy', 5, 'Perculiar', 23452345, 654, false, false, 'JUST-KILL_ME12');
INSERT INTO public.galaxy VALUES (5, 'Black Eye Galaxy', 10, 'Spiral', 1234124, 543, true, true, 'KNOCKEDOUT-GORGEOUS');
INSERT INTO public.galaxy VALUES (6, 'Messier 82', 7, 'Lenticular', 6754745, 45623, true, true, 'WOW-0001-PEACE');


--
-- Data for Name: mining_company; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.mining_company VALUES (1, 'SpaceX', 'Military', 23412, 34, 'Deepsapce Downfall', true, true, 4);
INSERT INTO public.mining_company VALUES (2, 'Apple', 'Ore Extraction', 2134623, 55, 'Whimpy Snopish ManBoys', true, true, 4);
INSERT INTO public.mining_company VALUES (3, 'RolEmi', 'ZeroGrav Manufacturing', 21353412, 634, 'Thristle Down', true, true, 4);
INSERT INTO public.mining_company VALUES (4, 'Men Testicles', 'Space Tourism', 2134623, 9555, 'AintAllRight', false, true, 4);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', false, true, false, 345342, 216326, 3, 45, true, 4);
INSERT INTO public.moon VALUES (2, 'Enceladus', true, true, false, 134513, 2344123, 3, 43, false, 5);
INSERT INTO public.moon VALUES (3, 'Mimas', false, false, false, 2345, 3245, 0, 1, false, 5);
INSERT INTO public.moon VALUES (4, 'Cylene', true, true, false, 12345, 23423, 4, 0, false, 5);
INSERT INTO public.moon VALUES (5, 'Ganymede', false, false, false, 5534, 5677, 4554, 0, false, 6);
INSERT INTO public.moon VALUES (6, 'Callisto', false, true, false, 32534, 87677, 90874, 0, false, 6);
INSERT INTO public.moon VALUES (7, 'Europa', true, true, false, 123124, 812677, 7, 11, false, 6);
INSERT INTO public.moon VALUES (8, 'Io', true, true, false, 12224, 12677, 0, 1, false, 6);
INSERT INTO public.moon VALUES (9, 'Amalthea', false, false, false, 224, 677, 0, 0, false, 6);
INSERT INTO public.moon VALUES (10, 'Alara', false, false, false, 1224, 1677, 0, 0, false, 6);
INSERT INTO public.moon VALUES (11, 'Pasiphae', false, false, false, 9194, 9677, 0, 0, false, 6);
INSERT INTO public.moon VALUES (12, 'Sinope', false, false, false, 794, 677, 0, 0, false, 6);
INSERT INTO public.moon VALUES (13, 'Titan', true, true, false, 1729194, 489677, 21, 3, false, 7);
INSERT INTO public.moon VALUES (14, 'Rhea', true, true, true, 43194, 21677, 1, 1, false, 7);
INSERT INTO public.moon VALUES (15, 'Dione', true, true, false, 777194, 33427, 0, 0, false, 7);
INSERT INTO public.moon VALUES (16, 'Iapetus', false, false, false, 887764, 99927, 0, 0, false, 7);
INSERT INTO public.moon VALUES (17, 'Tethys', false, false, false, 17764, 43927, 0, 0, false, 7);
INSERT INTO public.moon VALUES (18, 'Hyperion', false, false, false, 7614, 11927, 0, 0, false, 7);
INSERT INTO public.moon VALUES (19, 'Janus', false, false, false, 11614, 7627, 0, 0, false, 7);
INSERT INTO public.moon VALUES (20, 'Titania', false, true, false, 77116141, 347627, 1, 1, false, 9);
INSERT INTO public.moon VALUES (21, 'Umbriel', false, true, false, 6141, 627, 12, 1, false, 9);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'K', true, false, false, 1258658, 8563, 3476845, 0, true, 2);
INSERT INTO public.planet VALUES (2, 'Venus', 'K', true, false, true, 6546343, 34798, 6754234, 0, true, 2);
INSERT INTO public.planet VALUES (3, 'Mars', 'K', true, false, true, 2135, 56856, 34573, 0, false, 2);
INSERT INTO public.planet VALUES (4, 'Earth', 'M', true, true, false, 637635, 8453, 2345, 1, true, 2);
INSERT INTO public.planet VALUES (5, 'Pluto', 'L', true, true, true, 456745, 346734, 2345, 5, false, 2);
INSERT INTO public.planet VALUES (6, 'Jupiter', 'H', false, false, false, 23452152134, 324637234, 12323523, 62, false, 2);
INSERT INTO public.planet VALUES (7, 'Saturn', 'J', false, false, false, 112452134, 724637234, 32451233, 83, false, 2);
INSERT INTO public.planet VALUES (8, 'Neptune', 'L', false, false, false, 452134, 4637234, 451233, 53, false, 2);
INSERT INTO public.planet VALUES (9, 'Uranus', 'K', false, false, false, 8462134, 95463724, 43741233, 27, false, 2);
INSERT INTO public.planet VALUES (11, 'Tatooin', 'K', true, true, false, 23134, 63724, 288233, 15, false, 3);
INSERT INTO public.planet VALUES (12, 'DeathStar', 'D', true, false, false, 32423134, 963724, 77288233, 0, false, 3);
INSERT INTO public.planet VALUES (13, 'Oceanus', 'H', true, true, true, 12134, 3724, 338233, 0, true, 3);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Betelgeuse', 'Red Giant', 'G', 'Subgiant', 5234513, 23452312, 123456, 'Andromeda', true, false, 1);
INSERT INTO public.star VALUES (2, 'Sun', 'Solar', 'M', 'Dwarf', 632623, 234623, 213467, NULL, true, false, 1);
INSERT INTO public.star VALUES (3, 'P234523', 'White Dwarf', 'B', 'Supergiant', 38563, 34784, 2137, 'TatooEntoan', false, false, 21);
INSERT INTO public.star VALUES (4, 'Sirius', 'Red Dwarf', 'B', 'Supergiant', 5324532, 234532, 12345, 'Alpha Canis Majoris', false, false, 1);
INSERT INTO public.star VALUES (5, 'Rigel', 'Hot Blue', 'G', 'Dwarf', 2365346, 324523, 3245, 'Beta Orionis', true, true, 3);
INSERT INTO public.star VALUES (6, 'Arcturus', 'Red Giant', 'O', 'Subdwarf', 5466, 3456, 3336, 'Bootes', false, false, 21);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 1, false);


--
-- Name: minning_company_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.minning_company_company_id_seq', 1, false);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 1, false);


--
-- Name: planet_planet_is_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_is_seq', 1, false);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 1, false);


--
-- Name: galaxy galaxy_galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: mining_company minning_company_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mining_company
    ADD CONSTRAINT minning_company_name_key UNIQUE (name);


--
-- Name: mining_company minning_company_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mining_company
    ADD CONSTRAINT minning_company_pkey PRIMARY KEY (mining_company_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: mining_company minning_company_federated_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mining_company
    ADD CONSTRAINT minning_company_federated_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: moon moon_planetary_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planetary_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_stellar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_stellar_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_cluster_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--
