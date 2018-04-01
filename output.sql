--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: class_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE class_type AS ENUM (
    'improvisation',
    'sketch',
    'standup',
    'acting'
);


ALTER TYPE class_type OWNER TO postgres;

--
-- Name: credit_card_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE credit_card_type AS ENUM (
    'Visa',
    'American Express',
    'MasterCard',
    'Discover',
    'JCB',
    'Diners Club',
    'Unknown'
);


ALTER TYPE credit_card_type OWNER TO postgres;

--
-- Name: event_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE event_status AS ENUM (
    'hidden',
    'draft',
    'normal'
);


ALTER TYPE event_status OWNER TO postgres;

--
-- Name: listing_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE listing_status AS ENUM (
    'unpublished',
    'active',
    'completed',
    'canceled',
    'deleted'
);


ALTER TYPE listing_status OWNER TO postgres;

--
-- Name: listing_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE listing_type AS ENUM (
    'class',
    'show',
    'camp'
);


ALTER TYPE listing_type OWNER TO postgres;

--
-- Name: order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE order_status AS ENUM (
    'started',
    'processing',
    'completed',
    'errored',
    'cancelled'
);


ALTER TYPE order_status OWNER TO postgres;

--
-- Name: ticket_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ticket_status AS ENUM (
    'available',
    'locked',
    'processing',
    'purchased',
    'emailed',
    'checkedin'
);


ALTER TYPE ticket_status OWNER TO postgres;

--
-- Name: user_credential_provider; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE user_credential_provider AS ENUM (
    'facebook',
    'google',
    'linkedin',
    'twitter',
    'microsoft',
    'amazon'
);


ALTER TYPE user_credential_provider OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE user_role AS ENUM (
    'admin',
    'concierge',
    'customer',
    'oauth_customer',
    'guest'
);


ALTER TYPE user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE accounts (
    id uuid NOT NULL,
    name text,
    description text,
    url text,
    enabled boolean,
    logo text,
    creator_id uuid,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE accounts OWNER TO postgres;

--
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE classes (
    id uuid NOT NULL,
    type class_type NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    description text NOT NULL,
    menu_order integer,
    account_id uuid,
    prerequisite_id uuid,
    image_url text,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE classes OWNER TO postgres;

--
-- Name: credit_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE credit_cards (
    id uuid NOT NULL,
    user_id uuid,
    type credit_card_type,
    stripe_id text,
    name text,
    line_1_check text,
    zip_check text,
    cvc_check text,
    exp_month integer,
    exp_year integer,
    fingerprint text,
    funding text,
    last_4 text,
    address jsonb,
    metadata jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE credit_cards OWNER TO postgres;

--
-- Name: event_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE event_tags (
    id uuid NOT NULL,
    event_id uuid NOT NULL,
    tag text NOT NULL,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE event_tags OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE events (
    id uuid NOT NULL,
    slug text NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status event_status DEFAULT 'normal'::event_status,
    account_id uuid,
    user_id uuid,
    image_url text,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE events OWNER TO postgres;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE listings (
    id uuid NOT NULL,
    slug text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    status listing_status DEFAULT 'unpublished'::listing_status,
    type listing_type DEFAULT 'show'::listing_type,
    start_at timestamp with time zone DEFAULT now(),
    end_at timestamp with time zone,
    pass_fees_to_buyer boolean DEFAULT true,
    user_id uuid,
    event_id uuid,
    class_id uuid,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE listings OWNER TO postgres;

--
-- Name: order_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE order_details (
    id uuid NOT NULL,
    order_id uuid,
    charge_id text,
    balance_transaction text,
    client_ip text,
    status text,
    failure_code text,
    failure_message text,
    amount text,
    network_status text,
    risk_level text,
    response jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE order_details OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orders (
    id uuid NOT NULL,
    user_id uuid,
    credit_card_id uuid,
    slug text NOT NULL,
    status order_status DEFAULT 'started'::order_status,
    subtotal integer NOT NULL,
    credit_card_fee integer DEFAULT 0,
    processing_fee integer DEFAULT 0,
    total_price integer DEFAULT 0,
    started_at timestamp with time zone,
    processing_at timestamp with time zone,
    completed_at timestamp with time zone,
    emailed_at timestamp with time zone,
    errored_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE orders OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teachers (
    id uuid NOT NULL,
    slug character varying(255),
    name character varying(255),
    email character varying(255),
    biography text,
    social jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE teachers OWNER TO postgres;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tickets (
    id uuid NOT NULL,
    slug text NOT NULL,
    listing_id uuid NOT NULL,
    order_id uuid,
    name text NOT NULL,
    "group" text NOT NULL,
    status ticket_status DEFAULT 'available'::ticket_status,
    description text,
    price integer NOT NULL,
    guest_name text,
    guest_email text,
    sale_start timestamp with time zone,
    sale_end timestamp with time zone,
    locked_until timestamp with time zone,
    purchased_at timestamp with time zone,
    emailed_at timestamp with time zone,
    checked_in_at timestamp with time zone,
    checked_in_by uuid,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE tickets OWNER TO postgres;

--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_credentials (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    provider user_credential_provider NOT NULL,
    token text NOT NULL,
    secret text,
    extra_details jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE user_credentials OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id uuid NOT NULL,
    name character varying(255),
    email character varying(255),
    password_hash character varying(255),
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    failed_attempts integer DEFAULT 0,
    locked_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    unlock_token character varying(255),
    stripe_customer_id character varying(255),
    one_time_token character varying(255),
    one_time_token_at timestamp without time zone,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    account_id uuid,
    role user_role DEFAULT 'customer'::user_role
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE versions (
    id uuid NOT NULL,
    event character varying(10) NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id uuid,
    item_changes jsonb NOT NULL,
    originator_id uuid,
    origin character varying(50),
    meta jsonb,
    inserted_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    updated_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL
);


ALTER TABLE versions OWNER TO postgres;

--
-- Name: waitlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE waitlists (
    id uuid NOT NULL,
    listing_id uuid,
    class_id uuid,
    user_id uuid,
    name character varying(255),
    email_address character varying(255),
    admin_notified boolean,
    message_sent_at timestamp with time zone,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE waitlists OWNER TO postgres;

--
-- Name: webhook_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE webhook_details (
    id uuid NOT NULL,
    source text,
    request jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE webhook_details OWNER TO postgres;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY accounts (id, name, description, url, enabled, logo, creator_id, inserted_at, updated_at) FROM stdin;
3601266a-808d-4153-be01-ff1577831f5d	Push Comedy Theater	Push Comedy Theater	https://pushcomedytheater.com	t	\N	\N	2018-04-01 01:36:38+00	2018-04-01 01:36:38+00
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY classes (id, type, title, slug, description, menu_order, account_id, prerequisite_id, image_url, inserted_at, updated_at) FROM stdin;
d6e8a637-a08c-44c2-93e4-17c3715dbe54	acting	Acting 101	acting101	This foundational course introduces the basic principles of acting through improvisation, monologue, scene work, and technical methods in voice, physical action, and text analysis. It involves fundamental skills and techniques with an emphasis on physical/vocal awareness, spontaneity, concentration, and truthful response.	1	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/hgjkgz1oh1qqjrqznljt.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
6ab20b69-d755-402a-87ff-b3937e97ceb4	improvisation	Improv 101: Introduction to Improvisational Comedy	improv101	Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn: <ul><li>the fundamentals of 'Yes, And'</li><li>how to support scene partners' ideas and energy</li><li>and how to make strong character choices.</li></ul> Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strides to create a fun, safe and supportive experience for all students.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	1	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wd4vnbdjwchrclmuhomg.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
17c14a44-51c7-4b26-9793-6cfc022f0a28	improvisation	Improv 201: Foundations of the Harold: Game and Second Beats	improv201	This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	2	3601266a-808d-4153-be01-ff1577831f5d	6ab20b69-d755-402a-87ff-b3937e97ceb4	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/qphl4uwhh5opshbsjuvl.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
0dddb009-b2b2-4612-86f4-e8eaebabd48e	improvisation	Improv 301: The Harold: Openers and Group Games	improv301	This course continues the Harold work started in 202. Students will delve more deeply into 'The Harold' structure. They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	3	3601266a-808d-4153-be01-ff1577831f5d	17c14a44-51c7-4b26-9793-6cfc022f0a28	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/uyjvypsmg96fcd4zl88j.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
0d9db0a1-80e7-4a25-8b23-9f79fb0878bc	improvisation	Improv 401: Advanced Harold	improv401	Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	4	3601266a-808d-4153-be01-ff1577831f5d	0dddb009-b2b2-4612-86f4-e8eaebabd48e	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/vbstqyeecfovcwm3mx9r.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
ce4517aa-9b7c-48f3-bcf6-5e399de7554c	improvisation	Improv 501: Improv Studio	improv501	***THIS COURSE WILL CAP AT 16 STUDENTS*** This course focuses on giving students individual attention to their strengths and weaknesses. We will also break down the different components of improv scenes and the choices that improvisers have and make within those scenes.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	5	3601266a-808d-4153-be01-ff1577831f5d	0d9db0a1-80e7-4a25-8b23-9f79fb0878bc	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/hhlz9x5qcz2qqkk3xyga.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
e6cdb5b3-7f74-4eb7-b374-c4ce39ad44f1	improvisation	Kidprov 101	kidprov101	Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This is class is $150 for new students and $140 for returning students.<br />New students also receive a free tshirt.	6	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/g0upzsg4dchanai2ul0l.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
787033b0-e0a7-4991-8732-80275c14bdbc	improvisation	Kidprov Studio	kidprov_studio	Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.<br />This class is open to children ages 8 to 12 who have previously taken at least 2 sessions of KidProv 101. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.<br />This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun<br />The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.<br />This class is $150.	7	3601266a-808d-4153-be01-ff1577831f5d	e6cdb5b3-7f74-4eb7-b374-c4ce39ad44f1	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/orrcrhg9bcgnexgseitw.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
57361873-5dfd-405d-ab6d-35ccede54cd2	improvisation	Musical Improv 101	music_improv101	This is what you've been waiting for! The Push Comedy Theater brings you MUSICAL IMPROV!!!<br />This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.<br />Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.	8	3601266a-808d-4153-be01-ff1577831f5d	6ab20b69-d755-402a-87ff-b3937e97ceb4	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/vggfmhm2c99mhkxi7r7v.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
a31eb58b-effd-48f6-b44e-30521e49402c	improvisation	Musical Improv 201	music_improv201	This class is focused on building a long form Musical Harold. It will improve upon the concepts and skills learned in Musical Improv 101, with a focus on finding deeper relationships and themes to bring to life through song.	9	3601266a-808d-4153-be01-ff1577831f5d	57361873-5dfd-405d-ab6d-35ccede54cd2	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/rxu5yn34d5rp0nvnkssf.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
9e8a767d-d543-489c-b4cb-6bfd4ae6f91c	improvisation	Musical Improv Studio	music_improv_studio	This course builds on what is learned in Musical Improv 101 and 201. We will work together on creating new forms and building skills for more varied and interesting scenes and songs.<br />Together, we will create a thematic musical form that will be the structure for our graduation show.	10	3601266a-808d-4153-be01-ff1577831f5d	a31eb58b-effd-48f6-b44e-30521e49402c	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/yes_yfvtxd.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
036e2611-29a3-4434-85fb-c3d917720bd6	sketch	Sketch Comedy Writing 101	sketch101	Dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page. In this class we will examine the various types of sketches, learn how to generate funny ideas and then turn them into a sketches ready for the stage. This class is open to everyone, no writing or comedy experience is ready.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.	1	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/nfshrdoaapy0pcsqayru.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
85ba6a21-c707-4050-a13a-24aac4b7004a	sketch	Sketch Comedy Writing 201	sketch201	This course builds upon the fundamentals and skills learned in 101.<br />At the end of the session, students sketches will be performed on the Push Comedy Theater stage by some of Hampton Roads finest actors.	2	3601266a-808d-4153-be01-ff1577831f5d	036e2611-29a3-4434-85fb-c3d917720bd6	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/wk3zfokdjzhpxpfsrgxx.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
778642e6-0c43-45ff-bd8e-70026b8176df	standup	Standup 101	standup101	Learn how to perform stand-up comedy!<br />Learn about the often-overlooked basics of stand-up comedy and the nuances of fine tuning your act from almost-jaded veteran comic Hatton Jordan.<br />This class focuses on learning three skills:<br /><ul><li>HOW to craft an original set,</li><li>HOW to host a show like a pro</li><li>HOW to market yourself so club bookers will want to pay you.</li></ul><br />This course culminates with YOU and the others in your class performing your set at your Grad Show at the Push Theater.<br />The class will be a 6 week course ending with a graduation show at the 90 seat Push Comedy Theater.	1	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/sxdcjtuvqwxkwyraic4x.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
2d19dcbd-095e-41dc-a36e-d83a44a16617	improvisation	Improv for Teens	teen_improv	Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 18. Absolutely no experience is needed. Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind. We will then use improv as a springboard for writing basic comedy sketches- like those seen on SNL. We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.<br />At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.	11	3601266a-808d-4153-be01-ff1577831f5d	\N	https://res.cloudinary.com/push-comedy-theater/image/upload/covers/s9uyzugyefwu81hmicmb.jpg	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
\.


--
-- Data for Name: credit_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY credit_cards (id, user_id, type, stripe_id, name, line_1_check, zip_check, cvc_check, exp_month, exp_year, fingerprint, funding, last_4, address, metadata, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: event_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event_tags (id, event_id, tag, inserted_at, updated_at) FROM stdin;
3ce4a674-25ac-4548-bcec-9946f4cef7b8	e351c882-8f56-4008-b5ff-5871d8da1e2d	show	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
d1a7e50f-2a77-44ad-ac74-ae74f2ef6bc5	e351c882-8f56-4008-b5ff-5871d8da1e2d	deal	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
3b4f7d66-bc5d-4231-a8cc-9adf1204da17	e351c882-8f56-4008-b5ff-5871d8da1e2d	couple	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
cc54a914-af7d-4566-8804-2d7db5779bc3	e351c882-8f56-4008-b5ff-5871d8da1e2d	therapy	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
974daf11-aeb4-4fcb-a432-79fc26f1bd24	e351c882-8f56-4008-b5ff-5871d8da1e2d	couples	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
9159a4d4-d8a6-42ea-a235-40aefc9da721	162ad5f4-d5a9-499c-b651-4d4d61abb28c	show	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
a2f245ef-6fa0-47b3-88c2-c1ff46555593	162ad5f4-d5a9-499c-b651-4d4d61abb28c	deal	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
6e1e28e9-4b40-435e-bb73-4689c400c36f	162ad5f4-d5a9-499c-b651-4d4d61abb28c	date-night	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
c19c7433-c3b0-4686-826a-376191bfa11d	162ad5f4-d5a9-499c-b651-4d4d61abb28c	sketch	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
51052d65-141d-4e5a-931b-983ad55e175b	162ad5f4-d5a9-499c-b651-4d4d61abb28c	couples	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
6df2b927-b880-4038-acfb-1b33e2e09951	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	show	2018-04-01 01:39:33+00	2018-04-01 01:39:33+00
1528c929-67f6-4e66-9f82-a5691b8a29d8	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	deal	2018-04-01 01:39:33+00	2018-04-01 01:39:33+00
882f93d5-7196-4f3d-9b24-1227c22e82f0	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	harold	2018-04-01 01:39:33+00	2018-04-01 01:39:33+00
f37c4b5c-645a-4096-bfac-26d49e5d49de	60fc9da2-91f5-4f0a-8a91-f68222a4b908	show	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
08aec30a-4cfc-4f57-9db0-9ddb98161608	60fc9da2-91f5-4f0a-8a91-f68222a4b908	murder-mystery	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
6c3500e2-a2e0-4117-8232-9d227462fe76	60fc9da2-91f5-4f0a-8a91-f68222a4b908	part	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
417b9caa-015c-4a36-8fc9-72f7ef3aae32	60fc9da2-91f5-4f0a-8a91-f68222a4b908	murder	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
d312ecf4-28fc-4557-ba9c-93f3f106ad08	60fc9da2-91f5-4f0a-8a91-f68222a4b908	improvised	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
0e56055d-c756-41b9-8040-94f93b2ae46d	60fc9da2-91f5-4f0a-8a91-f68222a4b908	mystery	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
062010c3-14e1-4dd8-9a28-1c4e5b59c7ee	60fc9da2-91f5-4f0a-8a91-f68222a4b908	unusual	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
70cbe5aa-b827-442f-827a-4061395eb59e	60fc9da2-91f5-4f0a-8a91-f68222a4b908	suspect	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
d2852789-445e-40f1-9e22-21404300edad	39d283f4-5dad-4567-a732-44930990da3c	show	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
14a940f1-d5ac-4669-8432-184eeba5b118	39d283f4-5dad-4567-a732-44930990da3c	deal	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
5ba03879-3a96-439a-898d-311316d6a894	39d283f4-5dad-4567-a732-44930990da3c	sketch	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
a072e882-d020-4d6f-b6f0-7b21e963c207	39d283f4-5dad-4567-a732-44930990da3c	sketchmageddon	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
87d6d50f-2caa-4e14-9afc-9719e1293ca0	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	free	2018-04-01 01:39:41+00	2018-04-01 01:39:41+00
df134537-7bdb-44a1-ba0c-9bc8b059cb3f	7ccf052e-76bf-4a08-8202-7e0f03826c53	show	2018-04-01 01:39:44+00	2018-04-01 01:39:44+00
09feb76c-de81-4126-bb54-74a742e1feba	7ccf052e-76bf-4a08-8202-7e0f03826c53	deal	2018-04-01 01:39:44+00	2018-04-01 01:39:44+00
02e97520-0371-4c1d-97de-d17e5f2416df	7ccf052e-76bf-4a08-8202-7e0f03826c53	monocle	2018-04-01 01:39:44+00	2018-04-01 01:39:44+00
babe30ee-687b-469b-9483-aef7c2f7bd93	7ccf052e-76bf-4a08-8202-7e0f03826c53	act	2018-04-01 01:39:44+00	2018-04-01 01:39:44+00
9fe2ccd3-000f-4ab8-ae15-65960ddd98d2	58eef19d-0c8f-4576-bc93-ba1cc0f9e980	show	2018-04-01 01:39:46+00	2018-04-01 01:39:46+00
95518c1a-6330-4838-ac99-cc4faf7eacd5	58eef19d-0c8f-4576-bc93-ba1cc0f9e980	good-talk	2018-04-01 01:39:46+00	2018-04-01 01:39:46+00
c2bcc421-d6c3-4b07-a8b3-327e7ce30424	58eef19d-0c8f-4576-bc93-ba1cc0f9e980	college	2018-04-01 01:39:46+00	2018-04-01 01:39:46+00
fde9ce7f-8747-4941-921a-e8e36263ca74	7a6e46c2-0db1-43a6-aaf5-1086e445b898	show	2018-04-01 01:39:49+00	2018-04-01 01:39:49+00
fa4ed628-fe77-452d-bfe9-bd5b9ed9ee0a	7a6e46c2-0db1-43a6-aaf5-1086e445b898	deal	2018-04-01 01:39:49+00	2018-04-01 01:39:49+00
c8c3dc97-0dec-423a-be23-639dc3e9239e	7a6e46c2-0db1-43a6-aaf5-1086e445b898	ghost	2018-04-01 01:39:49+00	2018-04-01 01:39:49+00
20c1c48c-2bd2-4061-bb40-c0e6e951bc04	141b715a-97b5-44b0-b599-e7e24aa50cb7	show	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
f80e579a-781c-4bf7-a91b-00329d18910a	141b715a-97b5-44b0-b599-e7e24aa50cb7	deal	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
df289613-1440-4765-ae17-5540aab96a40	141b715a-97b5-44b0-b599-e7e24aa50cb7	improvageddon	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
206f7adf-4bc3-4086-b56c-68916330ac91	141b715a-97b5-44b0-b599-e7e24aa50cb7	contest	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
3bd21cf2-1bfb-4d1f-ada1-71c8d363f245	141b715a-97b5-44b0-b599-e7e24aa50cb7	final	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
34ea8975-bb88-45ee-bcb6-d248d421c108	c58b009b-60f5-4781-a46e-d1585069a37c	show	2018-04-01 01:39:54+00	2018-04-01 01:39:54+00
03631287-50b3-4738-8237-e8383eca8560	c58b009b-60f5-4781-a46e-d1585069a37c	workshop	2018-04-01 01:39:54+00	2018-04-01 01:39:54+00
4460c6fb-5c48-4f05-bf8e-a9e6057bfc57	42e34702-1adc-4987-975f-b3323c53bd00	camp	2018-04-01 01:39:57+00	2018-04-01 01:39:57+00
edb67087-93c2-4bce-ab13-257f6d28723a	42e34702-1adc-4987-975f-b3323c53bd00	sketch	2018-04-01 01:39:57+00	2018-04-01 01:39:57+00
a5e1fac3-5dfc-4051-94a5-1e9a5f76c73b	42e34702-1adc-4987-975f-b3323c53bd00	students	2018-04-01 01:39:57+00	2018-04-01 01:39:57+00
2d6efa58-3899-429f-a176-783dd3f4b428	2b7039b5-f804-440d-a65e-05a54f2c19b8	camp	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
51a4190a-30fc-4003-a48c-a4402f71a3a2	2b7039b5-f804-440d-a65e-05a54f2c19b8	session	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
66e93361-277c-441b-be12-25eae95ad0fc	2b7039b5-f804-440d-a65e-05a54f2c19b8	sketch	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
02f8ed80-1cbc-42b6-b317-d12ab1c9c1e1	2b7039b5-f804-440d-a65e-05a54f2c19b8	students	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
fc6d4282-f713-4ecc-adff-baf07bf6c0cc	c03e100e-7c3a-4dbc-b044-ccbd7cbe6672	camp	2018-04-01 01:40:02+00	2018-04-01 01:40:02+00
395b25b0-0d40-4383-b7a1-a5605951bec4	f530b6fb-0124-4648-9f05-dd87d0eed87a	camp	2018-04-01 01:40:05+00	2018-04-01 01:40:05+00
5b3c72d4-0473-435f-9c3d-509fbacad01e	f530b6fb-0124-4648-9f05-dd87d0eed87a	session	2018-04-01 01:40:05+00	2018-04-01 01:40:05+00
03921fa3-fe05-4c27-82fd-66d5746f1a7e	f530b6fb-0124-4648-9f05-dd87d0eed87a	teen	2018-04-01 01:40:05+00	2018-04-01 01:40:05+00
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY events (id, slug, title, description, status, account_id, user_id, image_url, inserted_at, updated_at) FROM stdin;
e351c882-8f56-4008-b5ff-5871d8da1e2d	9X0YFP	Couples Therapy	<p>You think your relationship has problems?!?\n</p>\n<p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.\n</p>\n<p><br>Based on an audience suggestion, they take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.\n</p>\n<p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.\n</p>\n<p>Two Improvisers... One Scene!!!\n</p>\n<p>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.\n</p>\n<p><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, March 31st at 8pm<br>Tickets are $5\n</p>\n<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p><br>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1511021892/496fbc13-a69a-41cb-82ca-5d4cbcc3e5a2.jpg	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
162ad5f4-d5a9-499c-b651-4d4d61abb28c	27TVN1	Date Night: With Brad McMurran and Alba Woolard	<p><strong>Get ready as we improvise your relationship.</strong>\n</p>\n<p>It's the most fun you'll ever have on date night!\n</p>\n<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!\n</p>\n<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.\n</p>\n<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!\n</p>\n<p><br>\n</p>\n<p><strong>Date Night: With Brad and Alba</strong>\n</p>\n<p>Friday, April 6th at 8pm\n</p>\n<p>Tickets are $5\n</p>\n<p>---\n</p>\n<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.\n</p>\n<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.\n</p>\n<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.\n</p>\n<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611639/7e2ff30f-6b86-488e-8838-cfc9912b6824.jpg	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
3c62ccd2-939f-466d-82f4-fef0dcaa3a96	RPB6JG	Harold Night	<p>It's Harold Night at the Push Comedy Theater!\n</p>\n<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?\n</p>\n<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.\n</p>\n<p>Harold Night\n</p>\n<p>Friday, November 24th at 10:00pm\n</p>\n<p>Tickets are $5\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n<p>--\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611634/49cb7b83-12f7-40fe-a963-5ad538df05a4.jpg	2018-04-01 01:39:33+00	2018-04-01 01:39:33+00
60fc9da2-91f5-4f0a-8a91-f68222a4b908	495XZ2	The Unusual Suspects (formerly Who Dunnit)	<p><strong>Who Dunnit: The Improvised Murder Mystery</strong> is now <strong>The Unusual Suspects</strong>... new name, same great show.\n</p>\n<p>Someone has been murdered, and anyone could be a suspect.  Including you.\n</p>\n<p><br>\n</p>\n<p>Welcome to<strong> The Unusual Suspect: An Improvised Murder Mystery Comedy</strong>\n</p>\n<p>Throughout the evening you'll meet a series of unusual characters ranging from the wacky to the dastardly.  But beware, you too are a suspect.  You too may find yourself being interviewed the intrepid detective.\n</p>\n<p>And let's talk about this detective.  He's part Sherlock, part Matlock, part Columbo, part Jessica Fletcher.  You just never know which part you'll get.\n</p>\n<p>The Unusual Suspects is the hit show that has had sold-out audiences howling with laughter.  Don't miss it.\n</p>\n<p><br>\n</p>\n<p><strong>The Unusual Suspect: An Improvised Murder Mystery Comedy</strong><strong></strong><br>\n</p>\n<p>Saturday, March 10th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $15\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1521219210/e1d80801-9403-4c56-9a43-2fef2029ce4c.jpg	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
39d283f4-5dad-4567-a732-44930990da3c	LQBR2T	SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	<p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>\n</p>\n<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.\n</p>\n<p>SKETCHMAGEDDON\n</p>\n<p><br>\n</p>\n<p>--\n</p>\n<p>Get ready for a sketch comedy show like no other!!!\n</p>\n<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!\n</p>\n<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!\n</p>\n<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.\n</p>\n<p>This is a completely experimental show.  You never know what you are going to see.\n</p>\n<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>\n</p>\n<p>Saturday, April 7th at 10pm\n</p>\n<p>Tickets are $5\n</p>\n<p>------------\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611641/83a0c1e9-fd2e-4b82-9e5b-a1edaf6416c9.jpg	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
7ccf052e-76bf-4a08-8202-7e0f03826c53	03LT7F	Monocle: The Improvised One-Act Play!	<p><strong>Monocle: The Improvised One-Act Play </strong>is a group of five good friends with over 50 years of stage &amp; improv experience looking to make you laugh your ass off!\n</p>\n<p>Here's how our show works:\n</p>\n<p>We ask the audience for any song lyric (except "Hit me, baby, one more time." Ew.) With that one lyrical suggestion, we will improvise an entire one-act play!\n</p>\n<p>We come up with big, funny characters and compelling storylines right in front of your eyes. It may be dramatic, maybe even a little tragic, but it's always funny (we are dipshits)!\n</p>\n<p>Our show may look like we rehearsed it somehow, but we promise you there is no script. Just lots of laughs &amp; lots of fun!\n</p>\n<p>C<strong>omedy! Drama! Spectacle! Monocle!</strong><br><br><strong>Monocle: The Improvised One-Act Play</strong><br>Friday, April 6th at the Push Comedy Theater<br>The show starts at 10 pm, tickets are $5\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1518458457/c42cabc2-af30-4068-98cc-34f31ca36584.jpg	2018-04-01 01:39:43+00	2018-04-01 01:39:43+00
58eef19d-0c8f-4576-bc93-ba1cc0f9e980	D40ZP5	Good Talk: The Brad McMurran Show	<p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.<br>\n</p>\n<p style="text-align: center;">The College Years\n</p>\n<p style="text-align: center;">The college years for Brad were some of the best 8 years of his life. From Virginia Wesleyan as a basketball player with a future... to ODU as a troublemaker with a past... Brad loved college so much, he didn't want to leave!\n</p>\n<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>\n</p>\n<p style="text-align: center;">The College Years\n</p>\n<p style="text-align: center;">Sunday, April 8th at 7pm\n</p>\n<p style="text-align: center;">Tickets are $12\n</p>\n<p style="text-align: center;">Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.\n</p>\n<p style="text-align: center;">Each month, Good Talk looks at the life and experiences of a sketch and improv comedian.  Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.\n</p>\n<p style="text-align: center;">You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.\n</p>\n<p style="text-align: center;">The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.\n</p>\n<p style="text-align: center;">Upcoming episodes of Good Talk: The Brad McMurran Show will include -\n</p>\n<p style="text-align: center;">The New York Years\n</p>\n<p style="text-align: center;">Life and Death\n</p>\n<p style="text-align: center;">Failure\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611645/de52f7d0-daa6-4b61-b647-322e1c8b9958.jpg	2018-04-01 01:39:46+00	2018-04-01 01:39:46+00
7a6e46c2-0db1-43a6-aaf5-1086e445b898	86ND4K	Tales from the Campfire: The Improvised Ghost Story	<p>I ain't afraid of no ghost!<br>\n</p>\n<p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).<br>\n</p>\n<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>\n</p>\n<p><strong><br></strong>\n</p>\n<p>With an audience suggestion, this talented group of improvisers will make up a series of gut-busting ghost story right before your eyes.<br>\n</p>\n<p><br>\n</p>\n<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>\n</p>\n<p>Saturday, April 7th at 8pm\n</p>\n<p>Tickets are $5\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611643/fbca7042-3e12-4e21-9cff-98a451943cdf.jpg	2018-04-01 01:39:49+00	2018-04-01 01:39:49+00
141b715a-97b5-44b0-b599-e7e24aa50cb7	YW52JC	IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	<p>Prepare for Glory!!\n</p>\n<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!\n</p>\n<p>Who will raise the Hammer of Lowell in final victory? <br>You'll have to come to this month's show to find out!\n</p>\n<p><br><br>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.\n</p>\n<p><br>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!\n</p>\n<p>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.\n</p>\n<p><br>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!\n</p>\n<p><br>Let the final war for comedic supremacy begin!\n</p>\n<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, March 31st\n</p>\n<p>The show starts at 10pm\n</p>\n<p>Tickets are $5\n</p>\n<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1508611638/6a654ad0-cfee-43a6-9c35-dc86dfd97340.jpg	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
c58b009b-60f5-4781-a46e-d1585069a37c	4XPQLY	Workshop: Scenework DNA	<p>Workshop: Scenework DNA\n</p>\n<p>Have you ever felt like your scenes end too quickly, never get off the ground, or become too confusing too often?\n</p>\n<p>Then you should take this workshop!\n</p>\n<p>Using tons of exercises and scene-specific feedback, you will learn to create more sustainable scenes. Great shows can be broken down into great scenes.\n</p>\n<p>In this fun, fast-paced workshop, students will learn to take an analytical eye towards their own scene work and use the information they find to give themselves more opportunities for play.\n</p>\n<p>You won’t have to worry about burning through the fuel of your scene too early or getting so absurd that you can’t follow what’s going on anymore. This workshop will give you the tools you’ve been looking for to create better scenes (and therefore, better shows!)\n</p>\n<p>Workshop: Scenework DNA with Andy Livengood\n</p>\n<p>Saturday, April 12th at Noon\n</p>\n<p>Tuition - $40\n</p>\n<p>--\n</p>\n<p>Andy Livengood (AndyLivengood.com) has been teaching and performing improv for over 13 years. He is an instructor and performer at Theatre 99 in Charleston, SC and has studied improv at The Annoyance Theatre (Chicago) and the Upright Citizens Brigade Theatre (NY).\n</p>\n<p>Andy was voted Charleston’s Best Comic by the Charleston City Paper and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. In 2011, his one-man show, The Christmas will be Televised, was voted the Best Play in Charleston and has been performed in theaters all over the south-east.\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1522513485/1188ed45-c39e-4dac-8fe4-cfc33d5a4920.jpg	2018-04-01 01:39:54+00	2018-04-01 01:39:54+00
42e34702-1adc-4987-975f-b3323c53bd00	M1LS06	Teen Improv and Sketch Comedy Summer Camp (Session 2)	<p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 17, and absolutely no experience is needed.</strong>\n</p>\n<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.\n</p>\n<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!\n</p>\n<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.\n</p>\n<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p>Students will also be eligible to perform in the 7th Annual Norfolk Comedy Festival in September 2018.\n</p>\n<p>Session Tuition: $200\n</p>\n<p><strong>Teen Improv and Sketch Comedy Summer Camp (Session 2)\n</strong>\n</p>\n<p><strong>July 23rd thru 27th, 1pm to 4pm</strong>\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1511022273/247dfa5c-424f-4af3-bc04-bb54efc000f2.jpg	2018-04-01 01:39:57+00	2018-04-01 01:39:57+00
2b7039b5-f804-440d-a65e-05a54f2c19b8	Y69FN5	Teen Improv and Sketch Comedy Summer Camp (Session 1)	<p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 17, and absolutely no experience is needed.</strong>\n</p>\n<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.\n</p>\n<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!\n</p>\n<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.\n</p>\n<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p>Students will also be eligible to perform in the 7th Annual Norfolk Comedy Festival in September 2018.\n</p>\n<p>Session Tuition: $200\n</p>\n<p><strong>Teen Improv and Sketch Comedy Summer Camp (Session 1)</strong>\n</p>\n<p><strong>June 25th thru 29th, 1pm to 4pm</strong>\n</p>\n<p>Teen Improv and Sketch Comedy Summer Camp (Session 2)\n</p>\n<p>July 23rd thru 27th, 1pm to 4pm\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1511022273/247dfa5c-424f-4af3-bc04-bb54efc000f2.jpg	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
f530b6fb-0124-4648-9f05-dd87d0eed87a	P072D4	Pre-Teen Improv Camp (session 1)	<p><strong>Pre-Teen Improv Summer Camp (session 1)</strong>\n</p>\n<p>This camp is open to children ages 8 to 12.\n</p>\n<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.\n</p>\n<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.\n</p>\n<p><strong>Camp runs from 9:00 AM - 12:00 PM, Monday through Friday, with a graduation performance.</strong>\n</p>\n<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.\n</p>\n<p>Snacks and beverages will be provided every day during the morning break.\n</p>\n<p>These are all beginner level sessions, no experience is necessary.\n</p>\n<p>Tuition is $200 per student.\n</p>\n<p><strong>Pre-Teen Improv Camp (session 1)</strong>\n</p>\n<p><strong>June 25th thru 29th, 9am to 12pm</strong>\n</p>\n<p>Pre-Teen Improv Camp (session 2)\n</p>\n<p>July 23rd thru 27th, 9am to 12pm\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1511022366/bc026387-0fc7-4a5b-85ca-df84c16c9689.jpg	2018-04-01 01:40:05+00	2018-04-01 01:40:05+00
c03e100e-7c3a-4dbc-b044-ccbd7cbe6672	NB5SGL	Pre-Teen Improv Camp (session 2)	<p><strong>Pre-Teen Improv Summer Camp (session 2)</strong>\n</p>\n<p>This camp is open to children ages 8 to 12.\n</p>\n<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.\n</p>\n<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.\n</p>\n<p><strong>Camp runs from 9:00 AM - 12:00 PM, Monday through Friday, with a graduation performance.</strong>\n</p>\n<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.\n</p>\n<p>Snacks and beverages will be provided every day during the morning break.\n</p>\n<p>These are all beginner level sessions, no experience is necessary.\n</p>\n<p>Tuition is $200 per student.\n</p>\n<p><strong>Pre-Teen Improv Camp (session 2)\n</strong>\n</p>\n<p><strong>July 23rd thru 27th, 9am to 12pm</strong>\n</p>\n	normal	3601266a-808d-4153-be01-ff1577831f5d	952c3e0f-0886-4248-97d4-8f56d01a037c	https://res.cloudinary.com/push-comedy-theater/image/upload/v1511022366/bc026387-0fc7-4a5b-85ca-df84c16c9689.jpg	2018-04-01 01:40:02+00	2018-04-01 01:40:02+00
\.


--
-- Data for Name: listings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY listings (id, slug, title, description, status, type, start_at, end_at, pass_fees_to_buyer, user_id, event_id, class_id, inserted_at, updated_at) FROM stdin;
c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	GLVJXW	Sketch Comedy Writing 101	<p style="text-align: center;">Unleash your inner Will Ferrell, Tina Fey and Amy Poehler!!!<br>\n</p>\n<p style="text-align: center;"><strong><br>Sketch Comedy Writing 101</strong>\n</p>\n<p style="text-align: center;"><br>Here's your chance to dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely (or never) picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page.\n</p>\n<p style="text-align: center;"><br>We will examine the various types of sketches, learn how to generate funny ideas and then turn them into sketches ready for the stage. <br><br>This class is open to everyone, no writing or comedy experience is needed.\n</p>\n<p style="text-align: center;">The class will consist of 4 weeks of instruction followed by 2 weeks of rehearsal.<br>At the end of the session, students sketches will appear in their own SNL-style show<br><br>\n</p>\n<p style="text-align: center;"><strong>Prerequisites: none </strong>\n</p>\n<p style="text-align: center;"><strong>Cost: $210</strong>\n</p>\n<p style="text-align: center;">This class will be held on Monday nights from 6:30-9:30 pm at the Push Comedy Theater Training Center.\n</p>\n<p style="text-align: center;">The class runs February 25th through April 9th, with no class on March 12th.\n</p>\n<p style="text-align: center;"><strong>The Push Comedy Theater Training</strong><strong> Center</strong> is located at\n</p>\n<p style="text-align: center;">2710-A Granby Street . Norfolk, 23517.\n</p>\n	active	class	2018-02-26 23:30:00+00	2018-04-10 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	036e2611-29a3-4434-85fb-c3d917720bd6	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
5885edee-f310-4eba-9345-0bac64ab3ef1	K9YXR3	Improv for Teens at the Push Comedy Theater	<p>Jump head first into the wonderful worlds of sketch and improv comedy. This class is open to teens from the ages of 13 to 17.\n</p>\n<p>Absolutely no experience is needed.\n</p>\n<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous games to help you sharpen your mind.\n</p>\n<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends and most importantly... have fun.\n</p>\n<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p>Prerequisites: none\n</p>\n<p><strong>This class will be held from 1pm-3pm on Saturday afternoons from April 7th through May 12th.</strong>\n</p>\n<p>This is class is $170 for new students and $160 for returning students.\n</p>\n<p>--<br>\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	class	2018-04-07 17:00:00+00	2018-05-12 19:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	2d19dcbd-095e-41dc-a36e-d83a44a16617	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	LWKV9N	Musical Improv 101	<p><strong>The Push Comedy Theater brings you MUSICAL IMPROV!!!</strong>\n</p>\n<p>This course offers an introduction to long form musical improvisation. We will cover the basics of how to work with music while learning how to create two person musical numbers, placing them together to create a 15 minute thematic musical show.\n</p>\n<p>Additional focus will be on sound exploration, movement, stylization, and accessing voice. Prepare to challenge yourself while having a ton of fun! This course culminates with a graduation show.\n</p>\n<p>Prerequisites: Improv 101\n</p>\n<p>This course is 6 weeks long\n</p>\n<p>Cost $220\n</p>\n<p><strong>This class is held on Saturday afternoons, 3pm-6pm, March 10th through April 14th.</strong>\n</p>\n	active	class	2018-04-14 19:00:00+00	2018-05-19 22:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	57361873-5dfd-405d-ab6d-35ccede54cd2	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
cd7a312b-a8ad-408a-a297-11e5145a73cc	PNZ20L	Sketch Comedy Writing 101	<p style="text-align: center;">Unleash your inner Will Ferrell, Tina Fey and Amy Poehler!!!<br>\n</p>\n<p style="text-align: center;"><strong><br>Sketch Comedy Writing 101</strong>\n</p>\n<p style="text-align: center;"><br>Here's your chance to dive head first into the wonderful world of sketch comedy! Whether you're a seasoned writer or someone who rarely (or never) picks up a pen, this class will teach how to get the funny ideas out of your head and onto the page.\n</p>\n<p style="text-align: center;"><br>We will examine the various types of sketches, learn how to generate funny ideas and then turn them into sketches ready for the stage. <br><br>This class is open to everyone, no writing or comedy experience is needed.\n</p>\n<p style="text-align: center;">The class will consist of 4 weeks of instruction followed by 2 weeks of rehearsal.<br>At the end of the session, students sketches will appear in their own SNL-style show<br><br>\n</p>\n<p style="text-align: center;"><strong>Prerequisites: none </strong>\n</p>\n<p style="text-align: center;"><strong>Cost: $210</strong>\n</p>\n<p style="text-align: center;">This class will be held on Monday nights from 6:30-9:30 pm at the Push Comedy Theater Training Center.\n</p>\n<p style="text-align: center;">The class runs April 23rd through May 28th.\n</p>\n<p style="text-align: center;"><strong>The Push Comedy Theater Training</strong><strong> Center</strong> is located at\n</p>\n<p style="text-align: center;">2710-A Granby Street . Norfolk, 23517.\n</p>\n	active	class	2018-04-23 22:30:00+00	2018-05-29 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	036e2611-29a3-4434-85fb-c3d917720bd6	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
282a456f-c141-4c74-9ffc-25f3a8d4f54b	7Y9J82	Improv 101 with Brad McMurran	<p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>\n</p>\n<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.\n</p>\n<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.\n</p>\n<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p><br>This class meets six times from 6:30pm-9:30pm on Tuesday evenings from April 24th through May 29th.\n</p>\n<p>Cost: $210\n</p>\n<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	class	2018-04-24 22:30:00+00	2018-05-30 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	6ab20b69-d755-402a-87ff-b3937e97ceb4	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
e913634e-44e7-4f6b-b764-14ba24e4197a	CLQFMS	KidProv at the Push Comedy Theater	<p>Don't miss out on the fun!!! Sign up your kids, grand kids, nieces, nephews, even the stinky neighbor kid from down the street for KidProv at the Push Comedy Theater.\n</p>\n<p>This class is open to children ages 8 to 12. Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public-speaking, social and team-building skills.\n</p>\n<p>This class will be conducted in a non-judgmental environment where the students will build confidence, make friends and most importantly ... have fun\n</p>\n<p>The session concludes with the students performing in a graduation show on the Push Comedy Theater Stage.\n</p>\n<p>This class will be held from 10am-12pm on Saturday mornings from April 7th through May 12th.\n</p>\n<p>This is class is $170 for new students and $160 for returning students.\n</p>\n<p>New students also receive a free tshirt.\n</p>\n<p>---\n</p>\n<p>Mary and Jim Veverka collectively have over eight years experience studying and performing improv. Mary, a former children's librarian, has been a professional storyteller for 20+ years. During that time, Jim assisted Mary by playing a variety of characters at holiday events. Prior to moving to the Hampton Roads area, Mary was selected as an adjudicated artist by the Indiana Arts Commission. Mary has also taught storytelling to adults and children of all ages at schools, libraries and other venues.\n</p>\n<p>--\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	class	2018-04-07 14:00:00+00	2018-05-12 16:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	e6cdb5b3-7f74-4eb7-b374-c4ce39ad44f1	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
6f77a793-bd37-4d6c-a758-0a939c8549b0	J5QH3V	Improv 301: The Harold Openers and Group Games	<p><strong>Improv 301 : The Harold Openers and Group Games</strong><br>\n</p>\n<p>This course continues the Harold work started in 201. Students will delve more deeply into 'The Harold' structure.\n</p>\n<p>They will learn a series of 'openers' and 'group games' that will complete the Harold format. Openers are used to derive inspiration from the audience's suggestion while group games are multi person scenes that break up the traditional 2 person scenes.\n</p>\n<p> This is a 6 week course.\n</p>\n<p>Cost: $210<br>\n</p>\n<p>This class will be held from 6:30-9:30pm on Monday nights from February 26th through April 9th.\n</p>\n<p>There's no class on March 12th.<br>\n</p>\n<p>  ---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts. <br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	class	2018-02-26 23:30:00+00	2018-04-10 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	0dddb009-b2b2-4612-86f4-e8eaebabd48e	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
aaa9e83b-daa4-4624-9469-663439ed5175	TDL9GR	Improv 401: Advanced Harold	<p><strong></strong><strong></strong><strong></strong><strong>Improv 401: Advanced Harold</strong>\n</p>\n<p><br>Now we put it all together. Students will combine the skills learned in the previous courses for an in depth study of The Harold. This course will delve deeper into the form, focusing on editing scenes, individual and group commitment, as well as the components of 2-person, 3-person, and group scenes.\n</p>\n<p><br><br>At the end of the session, students will take part in a graduation show on the <strong>Push Comedy Theater </strong>stage.\n</p>\n<p><br><strong>Prerequisites: Improv 301\n</strong>\n</p>\n<p><strong>Improv 401: Advanced Harold is a 6 week course.</strong>\n</p>\n<p><strong>Wednesday nights from February 20th through April 3rd (no class on March 13th), 6:30pm to 9:30pm.</strong>\n</p>\n<p><strong>The price of this course is $210.</strong>\n</p>\n	active	class	2018-02-20 23:30:00+00	2018-04-04 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	0d9db0a1-80e7-4a25-8b23-9f79fb0878bc	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
9de64a31-6944-4a3f-8936-17d6b609dba6	H8CPDB	Improv 101 with Brad McMurran	<p><strong>Jump into the wonderful and wild world of improv comedy!!!</strong>\n</p>\n<p><br>Learn the beginnings of Chicago-based, long form improv. Students will learn how to create scenes based off of audience suggestions. They will learn the fundamentals of 'Yes, And,' how to support scene partners' ideas and energy, and how to make strong character choices.\n</p>\n<p>Absolutely no experience in acting or comedy is needed. The Push Comedy Theater strives to create a fun, safe and supportive experience for all students.\n</p>\n<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p><br>This class meets six times from noon-3pm on Sunday afternoons from March 4th through April 8th.\n</p>\n<p>Cost: $210\n</p>\n<p><br>--<br>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.<br>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting and film production.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	class	2018-03-04 17:00:00+00	2018-04-08 19:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	6ab20b69-d755-402a-87ff-b3937e97ceb4	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
688a2d63-3a9d-42cd-8a0a-655204b87d69	03LT7F	Monocle: The Improvised One-Act Play!	<p><strong>Monocle: The Improvised One-Act Play </strong>is a group of five good friends with over 50 years of stage &amp; improv experience looking to make you laugh your ass off!\n</p>\n<p>Here's how our show works:\n</p>\n<p>We ask the audience for any song lyric (except "Hit me, baby, one more time." Ew.) With that one lyrical suggestion, we will improvise an entire one-act play!\n</p>\n<p>We come up with big, funny characters and compelling storylines right in front of your eyes. It may be dramatic, maybe even a little tragic, but it's always funny (we are dipshits)!\n</p>\n<p>Our show may look like we rehearsed it somehow, but we promise you there is no script. Just lots of laughs &amp; lots of fun!\n</p>\n<p>C<strong>omedy! Drama! Spectacle! Monocle!</strong><br><br><strong>Monocle: The Improvised One-Act Play</strong><br>Friday, April 6th at the Push Comedy Theater<br>The show starts at 10 pm, tickets are $5\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	show	2018-04-07 02:00:00+00	2018-04-07 03:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	7ccf052e-76bf-4a08-8202-7e0f03826c53	\N	2018-04-01 01:39:44+00	2018-04-01 01:39:44+00
646be35c-c59c-43bd-a4c1-de82ff79257d	H0NP3Y	Improv 201 at the Push Comedy Theater	<p><strong></strong><strong>Improv 201 at the Push Comedy Theater</strong>\n</p>\n<p>This course builds upon the fundamentals and skills learned in 101. Students will learn the beginnings 'The Harold' a long form improvisation structure developed by Del Close. They will learn how to identify the 'game' of a scene and how to heighten these games to develop 'second beats'.\n</p>\n<p>At the end of the session, students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p><strong>This is a 6 week class.<br>Cost $210</strong>\n</p>\n<p><strong>This class will be held from 6:30-9:30pm on Tuesday nights from February 27th through April 10th.</strong>\n</p>\n<p><strong>There is no class April 13th.</strong>\n</p>\n<p>This Class is Held at the Push Comedy Theater Training Center\n</p>\n<p>2710-A Granby Street . Norfolk\n</p>\n	active	class	2018-02-27 23:30:00+00	2018-04-11 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	17c14a44-51c7-4b26-9793-6cfc022f0a28	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
7194bfc2-b409-45a7-a31c-1ef0726cd7b0	7ZHFY8	Stand-Up Comedy 101 with Hatton Jordan	<p><strong>Learn how to perform stand-up comedy!</strong>\n</p>\n<p>Learn about the often-overlooked basics of stand-up comedy and the nuances of fine tuning your act from almost-jaded veteran comic Hatton Jordan.\n</p>\n<p>This class focuses on learning three skills: HOW to craft an original set, HOW to host a show like a pro and HOW to market yourself so club bookers will want to pay you. This course culminates with YOU and the others in your class performing your set at your Grad Show at the Push Theater.\n</p>\n<p>The class will be a 6 week course ending with a graduation show at the 90 seat Push Comedy Theater.\n</p>\n<p>Class will be held Thursdays from 6:30pm to 9:30pm, March 8th through April 12th.\n</p>\n<p>This Class is held at the Push Comedy Theater Training Center\n</p>\n<p>Tutition is $190\n</p>\n<p>This class is taught by local comedian Hatton Jordan. Hatton has been in the stand-up game for 25 years and has made money telling jokes in more than 15 states and worked such clubs as the House of Blues in New Orleans, the Comedy Cabana in Myrtle Beach SC,  the DC Improv in Washington and he's even written for Mad Magazine.\n</p>\n	active	class	2018-03-08 23:30:00+00	2018-04-13 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	\N	778642e6-0c43-45ff-bd8e-70026b8176df	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
018cbd58-059f-4cff-adcd-a1b2452d5a47	27TVN1	Date Night: With Brad McMurran and Alba Woolard	<p><strong>Get ready as we improvise your relationship.</strong>\n</p>\n<p>It's the most fun you'll ever have on date night!\n</p>\n<p>Two lucky couples will see their love unfold on stage through the interpretation of 2 of Hampton Roads' wackiest improvisers!\n</p>\n<p>The couples will be selected at random and interviewed on stage in front of the audience. Using the information they learn, and their imagination, Brad and Alba will show the story of the couples' love.\n</p>\n<p>For years, The Pushers have been getting to know diverse couples all across Hampton Roads with this signature piece. Normally this is a piece within a larger show. This time, Brad and Alba are out to explore as much as possible by bringing it to you as its own show!\n</p>\n<p><br>\n</p>\n<p><strong>Date Night: With Brad and Alba</strong>\n</p>\n<p>Friday, April 6th at 8pm\n</p>\n<p>Tickets are $5\n</p>\n<p>---\n</p>\n<p>The Pushers are Virginia's premiere sketch and improv comedy group. For more than 11 years they have thrilled (and shocked) audiences with their wild antics both on and off stage. The group puts on a racy, high-octane, energetic show that is guaranteed to have audiences howling with laughter. In November of 2014, they opened their own theater, The Push Comedy Theater, located in the new Norfolk Arts District.\n</p>\n<p>In 2013 The Pushers' Off-Broadway musical Cuff Me: The Unauthorized Fifty Shades of Grey Musical Parody debuted in New York City. It ran for over a year in both New York and Chicago. A third production is currently touring the country.\n</p>\n<p>The Pushers have appeared at both The Charleston Comedy Festival and The North Carolina Comedy Arts Festival. In New York, they have performed at The People's Improv Theater, The Upright Citizen's Brigade and at The Kraine Theater in New York's East Village.\n</p>\n<p>Here in Hampton Roads the group have performed most notably at The Jewish Mother, The NorVa and The Virginia Beach Funnybone.\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	show	2018-04-07 00:00:00+00	2018-04-07 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	162ad5f4-d5a9-499c-b651-4d4d61abb28c	\N	2018-04-01 01:39:30+00	2018-04-01 01:39:30+00
447c468c-75f1-49c8-a212-a2a753e693f5	86ND4K	Tales from the Campfire: The Improvised Ghost Story	<p>I ain't afraid of no ghost!<br>\n</p>\n<p>The Push presents a frightful night of comedy (or is it a hilarious night of frights).<br>\n</p>\n<p><strong>Tales from the Campfire is quickly becoming one of the Push's biggest hits.</strong>\n</p>\n<p><strong><br></strong>\n</p>\n<p>With an audience suggestion, this talented group of improvisers will make up a series of gut-busting ghost story right before your eyes.<br>\n</p>\n<p><br>\n</p>\n<p><strong>Tales from the Campfire: The Improvised Ghost Story</strong>\n</p>\n<p>Saturday, April 7th at 8pm\n</p>\n<p>Tickets are $5\n</p>\n	active	show	2018-04-08 00:00:00+00	2018-04-08 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	7a6e46c2-0db1-43a6-aaf5-1086e445b898	\N	2018-04-01 01:39:49+00	2018-04-01 01:39:49+00
31de5df4-da98-42bc-b075-297489ff970d	495XZ2	The Unusual Suspects (formerly Who Dunnit)	<p><strong>Who Dunnit: The Improvised Murder Mystery</strong> is now <strong>The Unusual Suspects</strong>... new name, same great show.\n</p>\n<p>Someone has been murdered, and anyone could be a suspect.  Including you.\n</p>\n<p><br>\n</p>\n<p>Welcome to<strong> The Unusual Suspect: An Improvised Murder Mystery Comedy</strong>\n</p>\n<p>Throughout the evening you'll meet a series of unusual characters ranging from the wacky to the dastardly.  But beware, you too are a suspect.  You too may find yourself being interviewed the intrepid detective.\n</p>\n<p>And let's talk about this detective.  He's part Sherlock, part Matlock, part Columbo, part Jessica Fletcher.  You just never know which part you'll get.\n</p>\n<p>The Unusual Suspects is the hit show that has had sold-out audiences howling with laughter.  Don't miss it.\n</p>\n<p><br>\n</p>\n<p><strong>The Unusual Suspect: An Improvised Murder Mystery Comedy</strong><strong></strong><br>\n</p>\n<p>Saturday, March 10th at the Push Comedy Theater<br>The show starts at 8pm, tickets are $15\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n<p>---\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classes are offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	show	2018-04-15 00:00:00+00	2018-04-15 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	60fc9da2-91f5-4f0a-8a91-f68222a4b908	\N	2018-04-01 01:39:36+00	2018-04-01 01:39:36+00
b811cf87-408a-4bcb-970e-f942c45dde92	LQBR2T	SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	<p><strong>Don't miss this epic sketch comedy showdown, where truly anything can happen.</strong><br>\n</p>\n<p>And we do mean anything!!!  Sometimes it's funny, sometimes it's weird, it's always entertaining.\n</p>\n<p>SKETCHMAGEDDON\n</p>\n<p><br>\n</p>\n<p>--\n</p>\n<p>Get ready for a sketch comedy show like no other!!!\n</p>\n<p><strong>SKETCHMAGEDDON</strong> takes three groups and forces them to compete in an all-out comedy deathmatch!\n</p>\n<p>Each team will be given 15 minutes to dazzle you with their comedy prowess. It's Saturday Night Live meets Thunderdome!!!!\n</p>\n<p>Unlike its improvised sister show IMPROVAGEDDON, SKETCHMAGEDDON features all written and rehearsed material.  Props, costumes, and special effects are all legal in SKETCHMAGEDDON.\n</p>\n<p>This is a completely experimental show.  You never know what you are going to see.\n</p>\n<p><strong>SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition</strong>\n</p>\n<p>Saturday, April 7th at 10pm\n</p>\n<p>Tickets are $5\n</p>\n<p>------------\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n	active	show	2018-04-08 02:00:00+00	2018-04-08 03:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	39d283f4-5dad-4567-a732-44930990da3c	\N	2018-04-01 01:39:38+00	2018-04-01 01:39:38+00
d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	RBGNL6	Harold Night	<p>Don't miss Harold Night on it's brand new night and time... the third Thursday of every month at 7pm.\n</p>\n<p><br>\n</p>\n<p>It's Harold Night at the Push Comedy Theater!\n</p>\n<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?\n</p>\n<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.\n</p>\n<p>Harold Night\n</p>\n<p>Thursday, April 19th at 10:00pm\n</p>\n<p>This is a FREE show.\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n<p>--\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	active	show	2018-04-19 23:00:00+00	2018-04-20 00:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	\N	2018-04-01 01:39:41+00	2018-04-01 01:39:41+00
d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	D40ZP5	Good Talk: The Brad McMurran Show	<p style="text-align: center;">Get ready for a night of comedy from the Pushers' own Brad McMurran.<br>\n</p>\n<p style="text-align: center;">The College Years\n</p>\n<p style="text-align: center;">The college years for Brad were some of the best 8 years of his life. From Virginia Wesleyan as a basketball player with a future... to ODU as a troublemaker with a past... Brad loved college so much, he didn't want to leave!\n</p>\n<p style="text-align: center;"><strong>Good Talk: The Brad McMurran Show</strong>\n</p>\n<p style="text-align: center;">The College Years\n</p>\n<p style="text-align: center;">Sunday, April 8th at 7pm\n</p>\n<p style="text-align: center;">Tickets are $12\n</p>\n<p style="text-align: center;">Good Talk is a one-man show starring Brad McMurran and focusing on McMurran's wildly popular Facebook posts.\n</p>\n<p style="text-align: center;">Each month, Good Talk looks at the life and experiences of a sketch and improv comedian.  Through storytelling, improv and mixed media, Brad will bring his Good Talk Facebook posts to life.\n</p>\n<p style="text-align: center;">You'll see is struggles with bill collectors, relationships, alcohol, parents, opening a theater and just trying to act like an adult.\n</p>\n<p style="text-align: center;">The show is going to be an unpredictable, wild and borderline-insane ride... just like Brad's life.\n</p>\n<p style="text-align: center;">Upcoming episodes of Good Talk: The Brad McMurran Show will include -\n</p>\n<p style="text-align: center;">The New York Years\n</p>\n<p style="text-align: center;">Life and Death\n</p>\n<p style="text-align: center;">Failure\n</p>\n	active	show	2018-04-08 23:00:00+00	2018-04-09 01:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	58eef19d-0c8f-4576-bc93-ba1cc0f9e980	\N	2018-04-01 01:39:46+00	2018-04-01 01:39:46+00
9fd41ae1-26d8-4b49-a3fc-15207fb34620	NB5SGL	Pre-Teen Improv Camp (session 2)	<p><strong>Pre-Teen Improv Summer Camp (session 2)</strong>\n</p>\n<p>This camp is open to children ages 8 to 12.\n</p>\n<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.\n</p>\n<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.\n</p>\n<p><strong>Camp runs from 9:00 AM - 12:00 PM, Monday through Friday, with a graduation performance.</strong>\n</p>\n<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.\n</p>\n<p>Snacks and beverages will be provided every day during the morning break.\n</p>\n<p>These are all beginner level sessions, no experience is necessary.\n</p>\n<p>Tuition is $200 per student.\n</p>\n<p><strong>Pre-Teen Improv Camp (session 2)\n</strong>\n</p>\n<p><strong>July 23rd thru 27th, 9am to 12pm</strong>\n</p>\n	active	camp	2018-07-23 13:00:00+00	2018-07-27 16:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	c03e100e-7c3a-4dbc-b044-ccbd7cbe6672	\N	2018-04-01 01:40:02+00	2018-04-01 01:40:02+00
d07a5b96-0a39-4277-9e4a-e0737f2b8bec	YW52JC	IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	<p>Prepare for Glory!!\n</p>\n<p><br>Prepare for IMPROVAGEDDON: The Ultimate Improv Competition!!!\n</p>\n<p>Who will raise the Hammer of Lowell in final victory? <br>You'll have to come to this month's show to find out!\n</p>\n<p><br><br>3 teams will be given just 15 minutes to perform any style of improv comedy they choose... all in a quest to be declared Improvageddon champ and raise the Hammer of Lowell in final victory.\n</p>\n<p><br>This ain't your daddy's Improv cage match! If you think you've seen Improv competitions before then you ain't seen nothin yet!\n</p>\n<p>Improvageddon combines Improv Comedy with stylistic elements of Professional Wrestling to create a truly unique, and most definitely over-the-top Improv contest.\n</p>\n<p><br>Gimmicks will be displayed! <br>Trash will be talked! <br>Feats of comedic strength will be performed!\n</p>\n<p><br>Let the final war for comedic supremacy begin!\n</p>\n<p><br>IMPROVAGEDDON: The Ultimate Improv Competition!<br>Saturday, March 31st\n</p>\n<p>The show starts at 10pm\n</p>\n<p>Tickets are $5\n</p>\n<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p><br><br>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street, and in the lot directly in front of the theater.\n</p>\n	active	show	2018-04-01 02:00:00+00	2018-04-01 03:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	141b715a-97b5-44b0-b599-e7e24aa50cb7	\N	2018-04-01 01:39:51+00	2018-04-01 01:39:51+00
159faf63-a294-4a86-ae8f-ec4e572c5470	4XPQLY	Workshop: Scenework DNA	<p>Workshop: Scenework DNA\n</p>\n<p>Have you ever felt like your scenes end too quickly, never get off the ground, or become too confusing too often?\n</p>\n<p>Then you should take this workshop!\n</p>\n<p>Using tons of exercises and scene-specific feedback, you will learn to create more sustainable scenes. Great shows can be broken down into great scenes.\n</p>\n<p>In this fun, fast-paced workshop, students will learn to take an analytical eye towards their own scene work and use the information they find to give themselves more opportunities for play.\n</p>\n<p>You won’t have to worry about burning through the fuel of your scene too early or getting so absurd that you can’t follow what’s going on anymore. This workshop will give you the tools you’ve been looking for to create better scenes (and therefore, better shows!)\n</p>\n<p>Workshop: Scenework DNA with Andy Livengood\n</p>\n<p>Saturday, April 12th at Noon\n</p>\n<p>Tuition - $40\n</p>\n<p>--\n</p>\n<p>Andy Livengood (AndyLivengood.com) has been teaching and performing improv for over 13 years. He is an instructor and performer at Theatre 99 in Charleston, SC and has studied improv at The Annoyance Theatre (Chicago) and the Upright Citizens Brigade Theatre (NY).\n</p>\n<p>Andy was voted Charleston’s Best Comic by the Charleston City Paper and has written for the sketch comedy groups Maximum Brain Squad and This is Chucktown. In 2011, his one-man show, The Christmas will be Televised, was voted the Best Play in Charleston and has been performed in theaters all over the south-east.\n</p>\n	active	show	2018-04-14 16:00:00+00	2018-04-14 19:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	c58b009b-60f5-4781-a46e-d1585069a37c	\N	2018-04-01 01:39:54+00	2018-04-01 01:39:54+00
73c11902-a9ed-4325-bcc7-9132e1b34d3c	Y69FN5	Teen Improv and Sketch Comedy Summer Camp (Session 1)	<p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 17, and absolutely no experience is needed.</strong>\n</p>\n<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.\n</p>\n<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!\n</p>\n<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.\n</p>\n<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p>Students will also be eligible to perform in the 7th Annual Norfolk Comedy Festival in September 2018.\n</p>\n<p>Session Tuition: $200\n</p>\n<p><strong>Teen Improv and Sketch Comedy Summer Camp (Session 1)</strong>\n</p>\n<p><strong>June 25th thru 29th, 1pm to 4pm</strong>\n</p>\n<p>Teen Improv and Sketch Comedy Summer Camp (Session 2)\n</p>\n<p>July 23rd thru 27th, 1pm to 4pm\n</p>\n	active	camp	2018-06-25 17:00:00+00	2018-06-29 20:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	2b7039b5-f804-440d-a65e-05a54f2c19b8	\N	2018-04-01 01:39:59+00	2018-04-01 01:39:59+00
ae5321e2-e447-4ffa-872b-159623ffbbc9	P072D4	Pre-Teen Improv Camp (session 1)	<p><strong>Pre-Teen Improv Summer Camp (session 1)</strong>\n</p>\n<p>This camp is open to children ages 8 to 12.\n</p>\n<p>Students will explore the key elements of both long and short form improvisation. The children will play numerous improv games which will serve to develop and enhance their public speaking, social, and team-building skills.\n</p>\n<p>The camp is conducted in a non-judgmental environment where the students build confidence, make friends, and most importantly… have fun.\n</p>\n<p><strong>Camp runs from 9:00 AM - 12:00 PM, Monday through Friday, with a graduation performance.</strong>\n</p>\n<p>Each student will receive a "Pullers/Push Comedy" t-shirt that they (will keep and) wear at the graduation show.\n</p>\n<p>Snacks and beverages will be provided every day during the morning break.\n</p>\n<p>These are all beginner level sessions, no experience is necessary.\n</p>\n<p>Tuition is $200 per student.\n</p>\n<p><strong>Pre-Teen Improv Camp (session 1)</strong>\n</p>\n<p><strong>June 25th thru 29th, 9am to 12pm</strong>\n</p>\n<p>Pre-Teen Improv Camp (session 2)\n</p>\n<p>July 23rd thru 27th, 9am to 12pm\n</p>\n	active	camp	2018-06-25 13:00:00+00	2018-06-29 16:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	f530b6fb-0124-4648-9f05-dd87d0eed87a	\N	2018-04-01 01:40:05+00	2018-04-01 01:40:05+00
8fdd9346-b136-43e6-b6db-cd7e097c70f1	M1LS06	Teen Improv and Sketch Comedy Summer Camp (Session 2)	<p><strong>Jump head first into the wonderful world of improv and sketch comedy. This camp is open to teens from the age of 13 to 17, and absolutely no experience is needed.</strong>\n</p>\n<p>Students will explore the key tools behind both long and short form improvisation. We will play numerous improv games which will help to sharpen your mind and strengthen your public-speaking, social and team-building skills.\n</p>\n<p>Students will also explore the fundamentals of creating a written and rehearsed sketch comedy show!\n</p>\n<p>We strive to create a safe, non-judgmental environment where teens can build confidence, make friends, and most importantly ... have fun.\n</p>\n<p>At the end of camp, all students will take part in a graduation show on the Push Comedy Theater stage.\n</p>\n<p>Students will also be eligible to perform in the 7th Annual Norfolk Comedy Festival in September 2018.\n</p>\n<p>Session Tuition: $200\n</p>\n<p><strong>Teen Improv and Sketch Comedy Summer Camp (Session 2)\n</strong>\n</p>\n<p><strong>July 23rd thru 27th, 1pm to 4pm</strong>\n</p>\n	active	camp	2018-07-23 17:00:00+00	2018-07-27 20:00:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	42e34702-1adc-4987-975f-b3323c53bd00	\N	2018-04-01 01:39:57+00	2018-04-01 01:39:57+00
567f1b19-e440-42d6-bb5e-3e693fa240fa	9X0YFP	Couples Therapy	<p>You think your relationship has problems?!?\n</p>\n<p>In Couples Therapy you'll meet a couple on the rocks... be it newlyweds on a honeymoon from hell or an elderly couple at the end of their rope.\n</p>\n<p><br>Based on an audience suggestion, they take you through a roller coaster ride of emotions as they whisk you the trials and tribulations of couple they create right before your eyes.\n</p>\n<p>Oh yeah, and they do it all in a single, 25 minute long improvised scene.\n</p>\n<p>Two Improvisers... One Scene!!!\n</p>\n<p>Couples Therapy... is sometimes hilarious, sometimes poignant, always magical.\n</p>\n<p><br>Couples Therapy with Alan Johnson and the Alan Johnson Quintet<br>Saturday, March 31st at 8pm<br>Tickets are $5\n</p>\n<p><br><br>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available behind Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p><br>\n	completed	show	2018-04-01 00:00:00+00	2018-04-01 01:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	e351c882-8f56-4008-b5ff-5871d8da1e2d	\N	2018-04-01 01:39:28+00	2018-04-01 01:39:28+00
9561f75e-d647-4310-9365-dd021f48efbf	RPB6JG	Harold Night	<p>It's Harold Night at the Push Comedy Theater!\n</p>\n<p>So who the heck is Harold? More accurately the question should be... what the heck is a Harold?\n</p>\n<p>The Harold is the big, bad grand daddy of all long form improv! It starts with an audience suggestion, then improvisers weave together scenes, characters and group games to create a seamless piece. It can be bizarre and magical, baffling and amazing... it definitely needs to be seen.\n</p>\n<p>Harold Night\n</p>\n<p>Friday, November 24th at 10:00pm\n</p>\n<p>Tickets are $5\n</p>\n<p>The Push Comedy Theater only has 99 seats, so we recommend you get your tickets in advance.\n</p>\n<p>Free parking available at Slone Chiropractic (111 W Virginia Beach) just one block from the theater. There is also limited parking on the street.\n</p>\n<p>--\n</p>\n<p>The Push Comedy Theater is a 99 seat venue in the heart of Norfolk's brand new Arts District. Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.\n</p>\n<p>The Push Comedy Theater hosts live sketch, improv and stand-up comedy on Friday and Saturday nights. During the week classesare offered in stand-up, sketch and improv comedy as well as acting.\n</p>\n<p>Whether you're a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.\n</p>\n	completed	show	2017-11-25 03:00:00+00	2017-11-25 04:30:00+00	t	952c3e0f-0886-4248-97d4-8f56d01a037c	3c62ccd2-939f-466d-82f4-fef0dcaa3a96	\N	2018-04-01 01:39:33+00	2018-04-01 01:39:33+00
\.


--
-- Data for Name: order_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY order_details (id, order_id, charge_id, balance_transaction, client_ip, status, failure_code, failure_message, amount, network_status, risk_level, response, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orders (id, user_id, credit_card_id, slug, status, subtotal, credit_card_fee, processing_fee, total_price, started_at, processing_at, completed_at, emailed_at, errored_at, cancelled_at, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version, inserted_at) FROM stdin;
20170724134755	2018-04-01 01:36:35.849543
20170724134756	2018-04-01 01:36:35.918663
20170725134756	2018-04-01 01:36:35.954416
20170728231040	2018-04-01 01:36:35.988579
20170728233531	2018-04-01 01:36:36.016456
20170806194117	2018-04-01 01:36:36.049732
20171016234419	2018-04-01 01:36:36.078099
20171116020407	2018-04-01 01:36:36.114937
20171116020408	2018-04-01 01:36:36.160012
20171116020409	2018-04-01 01:36:36.195392
20171116020410	2018-04-01 01:36:36.24499
20171116020412	2018-04-01 01:36:36.27001
20171116020414	2018-04-01 01:36:36.313433
20171208181236	2018-04-01 01:36:36.341579
20171211141945	2018-04-01 01:36:36.367051
20171223212910	2018-04-01 01:36:36.403476
20180102135330	2018-04-01 01:36:36.434451
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY teachers (id, slug, name, email, biography, social, inserted_at, updated_at) FROM stdin;
b1f147a3-6740-488a-9f34-2a489e3ce1e9	alba_woolard	Alba Woolard	alba@pushcomedytheater.com	<p>Alba has been a performer and writer for the sketch and improv comedy group The Pushers since the summer of 2009. As a member of the group, she also produces and directs "Panties in a Twist: The All Female Sketch Comedy Show."</p><p>She graduated with a BFA in Acting from Old Dominion University. She has studied Improv with the Pushers and several regional improvisers. With the Pushers, she has performed up and down the east coast. By day, Alba is a Standardized Patient Educator at Eastern Virginia Medical School.</p>	{}	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
3593b62f-ba6e-4a44-a497-e58e1192bb66	brad_mcmurran	Brad McMurran	brad@pushcomedytheater.com	<p>Brad McMurran is the founder of The Pushers Sketch and Improvisation Comedy Troupe. He is the co-head writer, performer, and artistic director of the Push Comedy Theater.</p><p>Brad studied acting in college, trained in improvisation at Upright Citizen's Brigades, and is the co-writer of Cuff Me; The 50 Shades of Grey Musical Parody (which played off-broadway in New York for the past year).</p><p>Brad has been writing sketch comedy for ten years and is pleased as a pickle to be opening up this theater in Hampton Roads. McMurran is a graduate of Old Dominion and enjoys pizza.</p>	{"twitter": "https://twitter.com/Brad_ThePushers", "facebook": "https://www.facebook.com/bradmcmurran"}	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
aded632b-7188-4d1f-9b0f-db5c13b86c22	ed_carden	Ed Carden	ed@pushcomedytheater.com	<p>Ed Carden has been acting and performing comedy for more than a decade, and has appeared in nearly 30 local theatrical productions, as well as a handful of commercials and short films.</p><p>He is a founding member of The Pushers Sketch/Improv Comedy Group, in which he serves as a performer, writer, and producer. With The Pushers, he has performed up and down the east coast.</p><p>By day he works for Virginia Beach Public Schools. In addition to writing and performing, he enjoys cheeseburgers, sushi, and science fiction—not necessarily in that order.</p>	{"twitter": "https://twitter.com/TheEdCarden"}	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
76479d32-f640-4ffe-b478-1199f14b8ed0	sean_devereux	Sean Devereux	sean@pushcomedytheater.com	<p>Sean Devereux is an original member of The Pushers, and has been performing and writing comedy for nearly ten years.</p><p>Sean studied improv at the Upright Citizens Brigade Theater in New York and is one of the co-writers of the Off-Broadway hit Cuff Me: The Fifty Shades of Grey Musical Parody. In his civilian guise, Sean is an Emmy award winning writer and producer at WVEC-TV13.</p>	{"twitter": "https://twitter.com/Sean_ThePushers"}	2018-04-01 01:39:27+00	2018-04-01 01:39:27+00
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tickets (id, slug, listing_id, order_id, name, "group", status, description, price, guest_name, guest_email, sale_start, sale_end, locked_until, purchased_at, emailed_at, checked_in_at, checked_in_by, inserted_at, updated_at) FROM stdin;
2d50a143-4d76-4319-97bd-ae897d458f61	4c1e1460a2	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
e8446e1e-1d47-4dfb-94e0-298e1cc1a21a	7eb3d85c24	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
934f8ff7-8462-4543-b824-5939703f62fc	44abe0a7a1	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
2930ae7a-114c-450c-a4a7-5a8ec07252c1	8a0d179191	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
41eadb4f-6dfa-409c-bc98-2a2ed7526bc6	4a8da418c3	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
250d5e57-461c-4169-82e8-1e2c5276d7cc	8e770abe29	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
9755f304-60bc-48ed-acf0-a45ffdab1a84	0b68a7e5f0	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
e203f8bb-a0cd-49e9-b16d-256a21fecbb1	e33d2a3404	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
9c7583b2-fc6d-4eb9-a96e-7971d32135bc	9f89ab0040	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
9794bd94-ac8a-46e3-82df-ebb42b1869e8	a776782d42	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
62f9e413-ee2a-424e-ad5e-dcc7401a134b	b3b5a27bce	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
58cf91e9-a751-4b07-acd5-020b2d1a7658	9dafb7a98c	c78495b7-31c9-4c0d-9f7e-2e4e14e417a6	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.838966+00	2018-04-01 01:39:27.838966+00
14141f56-5adb-4fbd-ba7c-fbd8e5bef88c	a6db51e776	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
865900ae-afbe-4516-9cdb-1817c2ee915d	f43a06df34	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
c0f97834-4793-453c-8d5b-d29c3cf4aa83	019dab88d7	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
b2e230a7-48bb-4559-8c27-054458facdbe	e8580cc598	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
959e5a88-7138-4e9d-8109-df39bac56b27	75940ea236	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
41bc4c5a-3ef9-48d0-8930-458c8b97529f	45d6baec1d	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
4504ae27-5933-4436-b017-8f36cc633ba2	4f55c830f9	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
32580fd2-b75f-4a26-83ee-b88184b3d45a	0593ff99d8	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
f6ee6d4b-3f85-43a5-933c-f185d625f73f	6d32f6af3d	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
6642aba7-7bd5-4d3a-b4a2-8bc0d3fa1f13	28e7e91ef9	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
23dff8a3-a34e-4353-a0af-5df693fa8271	d4c6f7f9e4	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
b06f4726-12a8-4892-a905-14272b0f1d0d	87cc17e10b	5885edee-f310-4eba-9345-0bac64ab3ef1	\N	Ticket for Improv for Teens at the Push Comedy Theater	default	available	Ticket for Improv for Teens at the Push Comedy Theater	17000	\N	\N	2018-03-31 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.881709+00	2018-04-01 01:39:27.881709+00
834d4b28-7ec3-4a22-a282-da32fd464b94	e2ed80eae6	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
553992ba-fd77-486d-9e17-969fca19e452	ea66c54779	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
8f1727b8-8d36-4710-b875-f98feddea36f	ed39db0947	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
fea2e060-bf23-4bfa-83e4-52c2d3f5d120	5d652c4c57	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
0784550a-d2cc-43a0-83ea-354e4369c579	2ee75a5f68	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
b6a73be4-887d-41fa-a729-401b7d89adfd	c7348226eb	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
e467ade9-631c-4ce6-9369-13ef9ee378c0	9dcbd1e863	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
6bf2a998-a577-432a-9496-150394346504	aa9e97518b	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
757119df-3bd1-464f-be0e-c7778ac54d45	c20f2cc7de	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
6c151b25-110d-488b-ad26-54d516661d16	4f28e5fd70	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
f6a1660d-79c9-4c68-838c-58bce3c58964	c08e87ed93	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
ea2cd81c-2261-41db-9fa3-d1baa541e668	e5b0bacebd	9ebdaea3-d6ad-421f-b4ed-67bfa04833c9	\N	Ticket for Musical Improv 101	default	available	Ticket for Musical Improv 101	22000	\N	\N	2018-04-01 01:39:27.893126+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.914656+00	2018-04-01 01:39:27.914656+00
014be973-572f-499f-8bec-da849086fb83	5718fbd59a	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
147f1514-be23-4ff5-8419-8e632fa2280a	9162544219	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
76a47501-7201-4bec-8b44-d6b873ec7dcf	a72124fdd2	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
2da3f741-488e-4286-be75-69a80b0498c9	21825e2e54	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
681ac017-f0e1-4c1f-b369-6b21eb2d6bfc	36cdd87d03	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
90c7c619-5ec9-4f1a-a92f-7958fd9631a1	466a8dbd7d	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
b265c843-ccad-4dcb-8c48-b975716b7192	d3c5a00e1c	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
ccfc8e48-aec7-40a6-99f0-b249d61e107f	bcdfa66530	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
b95b2f69-bd0e-4d1b-9e2f-42365c4c3a44	ae0b38493d	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
6a868511-2503-49a2-9fce-548f92b3b33d	cc79178f32	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
532d7a83-c158-45b6-96b5-72bddb6264a4	2e15cd0e48	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
9892680a-52b7-41d3-8b4b-64c804991e28	8c20d75cff	cd7a312b-a8ad-408a-a297-11e5145a73cc	\N	Ticket for Sketch Comedy Writing 101	default	available	Ticket for Sketch Comedy Writing 101	21000	\N	\N	2018-04-01 01:39:27.925931+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.945657+00	2018-04-01 01:39:27.945657+00
1d657240-bd15-4b23-9f70-52f4a50b299e	224c290150	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
0e4838b5-1f03-40b9-a723-fe3a4c023260	3043dfc703	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
cfb2524f-4680-4287-9f31-93fd00cdbef8	3287cd67fa	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
11e88454-b5c1-429f-9845-490f647e49d4	ac572b55d6	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
5e58a915-3fa9-4ff8-9cd2-3e273781eaef	69ae6c4f25	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
2ac74218-3b3d-4dcb-9eac-b9d288da1397	0978596630	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
ef759346-b0e3-42b3-b7b5-cdc6b695d236	b6ae3b6f1e	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
bee1dc9c-3c88-4251-ac5d-fb19caf43e88	138aa271ae	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
56645e90-3433-4196-a68d-2a6309ef1af3	c25e805ced	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
e5979f42-503a-47ee-b538-78fac797b5bd	28865b5e4a	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
ca6be48c-c419-42e4-bbc1-a7f395a90677	7e3b50a858	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
dcfeb6c4-69a1-4bc5-ab49-c53797bfb1ae	f43e0d1abd	282a456f-c141-4c74-9ffc-25f3a8d4f54b	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-04-01 01:39:27.957832+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:27.975621+00	2018-04-01 01:39:27.975621+00
eb797f32-554a-404f-aa2c-0bb5c671aa9a	04c73740bd	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
a56e8803-941a-4564-b971-7f2a04c2443a	843e76cc6c	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
085d36e9-beea-4ecc-9ad3-81139563e229	5034e8425d	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
b95aa71f-a926-4c33-9039-ed343b7bf128	8d480b933a	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
deddcced-de65-4b08-9032-ed40c1d1a865	d946282d1c	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
a2dc9497-ab72-429d-9bbe-91469f2e4910	91853fe785	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
4907a784-30cb-4a23-a06f-75d0885b1af4	8669e4c435	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
8af6cbba-38eb-4991-94f7-da38bd2d8ccb	ff22209163	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
4d951fc1-ced8-4275-a7a1-07b273497599	c02e357f3c	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
324dee8f-5b12-4e51-93ef-d729bec60ec5	1226d62f2e	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
ddbaa7c3-a9ac-49a4-bcbf-a3e30d4eb499	204303b58f	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
e6d14483-e4b7-4e00-8436-a801713eec8f	a60259e28c	646be35c-c59c-43bd-a4c1-de82ff79257d	\N	Ticket for Improv 201 at the Push Comedy Theater	default	available	Ticket for Improv 201 at the Push Comedy Theater	21000	\N	\N	2018-02-20 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.094029+00	2018-04-01 01:39:28.094029+00
9534366a-cdc3-451c-aeb3-d208be9fe4b6	032c0bb200	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
8f81a497-52e9-4e08-9ee9-edeea49ccc23	b0dd66f574	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
d001ecac-e992-4f4a-9d8f-2cea40780387	c230629a91	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
efffe8f7-e6f4-4854-bc1f-46708a7954f5	bb6ca9adfa	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
c60a8738-7876-407b-8908-823eb1f1a92b	3ebb92a980	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
8f5550ab-8cca-432b-8341-0086b83a7d1f	de771f60b7	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
80a7a3b9-5a71-4203-b059-486e3347ad21	26480923cf	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
7f1db884-7659-466c-9c0b-84287a9d258f	47f60dea66	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
10b883b6-3370-4fa3-9c68-3fb9a047df5f	e15fbcb294	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
c846c831-ad5d-4d4d-b694-80e455df2075	a6169afc26	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
11957255-8f01-4b57-bb7d-7b434e7e4181	a98f76a35f	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
fb1c0ea7-ca09-4b8f-962f-77f87a45134b	d4cc6ccfb2	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
55bc6f85-3475-48c4-a5e3-0606363c6649	e219e94ba9	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
8ea57afe-f0a4-4f60-9516-5b79e85c54af	156b0f9ccf	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
5432e224-a766-44a1-99b1-ec9382649693	aa8c1f619d	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
948ef527-4719-481d-a8d6-c64c54bd0b25	e4794f8fcd	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
7504cb24-b585-4d21-8510-3b184cba699c	bb0a75532e	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
30689bf4-002f-4c03-b7f3-7a39920e8776	011f95d8d2	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
2d4c685e-f4ed-411c-b5c6-e2de515a2595	58921872c4	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
f1eb8a09-b3f1-44ba-9c97-7617be9fa9ae	cb7bd16421	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
536716bd-2692-4903-93f5-9e10c786b2d3	63be2312f4	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
1f4ac1fe-d23d-4f1a-a9ba-b52b1e62c9cb	c4cface1d0	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
abb25ea7-3b3b-4de3-8258-700dbdf48abc	35b5e09b22	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
a6512805-d10b-4b6f-9ca3-c064e11208fa	ff6cd144bb	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
72d7fe37-cbf6-4650-b970-485cc038cb01	2d29204a25	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
1ad45293-e7fc-44ba-9804-395fa614ad6d	0057d08f56	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
baed9fa9-0845-4d0b-aa8c-e4b8cd427444	6a5ebbdb10	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
57a1ab72-1085-4f4e-af22-0a53b34cad6b	eb5efb38bf	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
22cf2636-4a72-43f5-b4af-81011113e54d	81211c5d4f	e913634e-44e7-4f6b-b764-14ba24e4197a	\N	Ticket for KidProv at the Push Comedy Theater	default	available	Ticket for KidProv at the Push Comedy Theater	16000	\N	\N	2018-03-31 14:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.002002+00	2018-04-01 01:39:28.002002+00
bfbc4ca1-81a8-45cf-a92e-5c5074bf6090	33efd4a609	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
dfb6f072-b12b-45e7-b457-3e103a82d564	6a0742a7bf	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
9b6f526e-865f-43a4-a298-8e6b3639e5cd	901468c91f	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
87e282af-366c-4c55-929e-7df3513e361e	3eb7bf46bc	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
d02cea02-93a9-42d4-ba52-34fb9315ee18	612e65ef88	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
1173a493-7bb9-4f25-bb1c-5d05608156c7	f91dd876c2	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
90068722-3862-45b7-b19f-240a908cb78d	fb65b261a1	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
aad116d5-278b-4799-8e94-2a506221e2ad	bec9aa68c6	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
88ab48a5-e704-4874-bf65-8f680b4c4186	3348e75bc4	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
6fccad82-3e25-4e64-b5fc-e5f268f203b9	3bd1f47226	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
e2ad5eca-3120-4eb5-be12-2d6becc8fa2a	ec0697c7b0	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
2c3e719d-92ad-4490-9e6d-2f2660e48ee5	4e50799b00	6f77a793-bd37-4d6c-a758-0a939c8549b0	\N	Ticket for Improv 301: The Harold Openers and Group Games	default	available	Ticket for Improv 301: The Harold Openers and Group Games	21000	\N	\N	2018-02-19 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.029005+00	2018-04-01 01:39:28.029005+00
7d584604-9c5a-47dc-b7a2-3ece35c69eae	fe88da8aaf	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
d9adb7bb-dcad-4fdd-ad34-7bee40e9415e	26891e7927	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
8e884d27-82c8-4aa6-a8a0-3085dea77134	752cda1195	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
f9cd1a5e-1ddd-46ab-a57a-d829a3157611	3b79a94459	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
31eb9dd9-18aa-4ea6-9865-b8e91a56e107	29a4ed3065	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
80e6afc6-586a-4740-a75a-454d82f54f95	7f045b08eb	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
10bc2bd7-0747-43e4-9095-03c04b83ac04	2402dca3a6	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
de0c1689-b966-4651-92a3-3333ada497c8	ee20c1d905	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
f1d7e879-a5e6-4096-a883-2f3ba0682de1	5c8f3aa9ca	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
769fa43d-1ebd-4aef-affb-caed4e7e07fd	8401cd818c	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
36087595-5c06-4590-85bb-cf350e876b9a	f6e926a85b	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
4f7df09e-58cf-4f46-b3d9-4dbd3e432eeb	489ac9fc8d	aaa9e83b-daa4-4624-9469-663439ed5175	\N	Ticket for Improv 401: Advanced Harold	default	available	Ticket for Improv 401: Advanced Harold	21000	\N	\N	2018-02-13 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.064715+00	2018-04-01 01:39:28.064715+00
ce204d2c-55f9-45ec-90c1-b2945fb502c8	8301ef1f7f	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
a356dcaf-0ae9-4603-9b0a-653415e47b9f	19e6a0372b	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
6fe9cab3-d6b4-4f7a-b0e1-19d5e33e3a86	fd7e7a0593	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
f6b0bf4b-6c6b-47c9-b84c-629e598b2e49	e187af09ff	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
26dbd7c2-24b6-420e-a5a9-a848eea419cd	0872837d39	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
c571cf30-1a3e-4a03-82d4-ac501dfd065b	2b2c31a89f	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
0ef1a0f0-2197-474d-b851-061032136e2b	a59c8ca387	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
65fc42dc-e820-4c71-9b1a-d840914b70c0	236e55647c	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
7b01a3cf-1b6e-4f15-a968-a4055e876c43	ce4178779d	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
ec5fc350-988f-4798-8a78-b3806300cd4c	b64e1212af	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
db64ca46-04d5-4aa6-88f3-5ed150204030	a6795ece7b	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
b8c68f4e-7bfb-4fac-89e8-941b1531d7dc	62823cebc4	9de64a31-6944-4a3f-8936-17d6b609dba6	\N	Ticket for Improv 101 with Brad McMurran	default	available	Ticket for Improv 101 with Brad McMurran	21000	\N	\N	2018-02-25 17:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.121015+00	2018-04-01 01:39:28.121015+00
2f568537-ecfc-416d-8cd8-084b8d132d02	710a00293c	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
d2c08b30-b051-444a-a033-222ca53122d0	6eae612615	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
612f7949-060a-4906-af4c-e3d3fd3dd2eb	244485a5ca	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
0cbb426d-a4da-4353-997b-8b42c6b26b7f	4264520aab	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
41616a4c-0d8d-4609-a4d1-b2c1b4dfe8d3	14fecaf968	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
7d43557d-4a53-4e20-9fb8-9ec6f4579a71	f204f04cad	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
42ce828c-7ac8-4917-a7a3-26246b78e82c	b4098b1f91	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
7647d1c0-91ba-4015-858d-fb8871408a76	4d0b6ea1a6	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
fc2d3c8a-ff38-49e8-b0ff-d841b9e0d4bb	588057222f	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
1692f68c-ddd5-482a-a779-ab6c56360f30	6ea0422647	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
32dc8830-1084-44e6-a3fc-61e5e0f52ceb	7fd54c3729	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
fd0af273-f091-4369-b56b-9e8e2c6a800e	65e5a42274	7194bfc2-b409-45a7-a31c-1ef0726cd7b0	\N	Ticket for Stand-Up Comedy 101 with Hatton Jordan	default	available	Ticket for Stand-Up Comedy 101 with Hatton Jordan	19000	\N	\N	2018-03-01 23:30:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:28.14626+00	2018-04-01 01:39:28.14626+00
1ba67319-50b0-42e0-a11b-d6d413c190a3	ea57c6156a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
cd51f162-504c-4f5c-a653-7e35afce3e9d	064348a5d0	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
515a768d-3208-4025-b0dc-f7f77724bc80	229ac0b684	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
3d9d5eef-26f0-495b-b1c2-e80fdaebaf51	ee100b1c30	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
21f6a012-1e10-427f-9750-6dd18cbba540	16e7118a8a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0143e364-0ad7-4b66-a02c-58ff76d8a5e5	f1d5ac5c95	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
7e8eea45-cf0a-456a-9587-52d43b48d798	d0c8234c18	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
1ab6eaec-35ce-4b3e-a4ef-244d7cbaf1fa	f235ec6198	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
173bf26f-ba11-4806-b895-fe0bd9624159	cfcf36bc0f	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
b52201b8-6fb1-4077-95c0-01d16af82d72	f9b8197f4e	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
92e27b3d-3a3d-4cc8-b1b6-aceb3c2237ea	7e47c78adc	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
652ac91b-1402-4ca6-a5d3-7d791d1d8da4	89449fdc4b	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
1b850459-99d8-4c15-b7a0-78587c6de965	354da8a51a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0335f6a5-5cee-496b-b1e1-66d76741ed4b	7af27ad3dc	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
06c0afe8-b944-4489-a8ad-804c4ad487f5	24183192e8	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
370cc4f4-0a48-4819-9f0a-85c0f57679cb	7c27dd5b5d	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
d2b960f3-4511-4ea8-8367-287db5a276b3	c632540bbc	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
c94f6de3-37af-46c4-8ab9-890d6749d1c3	699a7f442c	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
8172654a-3f6a-4dca-8512-8a1ee0acc5c6	fbc31e702b	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
2ee171d9-403a-4bb2-932e-111bcdff417d	1be27b1e91	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
349f7726-b95d-477a-b49b-6d8e9aabd0ee	79d39aefd6	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
a067ea39-00a5-4588-bfda-af347f4a6ebb	71d93d3304	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
e9db246e-914a-483b-9b59-b41b23a8a930	915e5742d3	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
9474fe4e-bac2-4a10-8e4d-88985578c16d	360627da7d	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
748a4c4d-009f-4354-8a6f-e9930e4f9046	8fd1b3cf95	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
b04b5d26-f85b-48cf-9b24-76e15f1e0b0b	36ed19e7c9	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
05276a90-572a-4dfe-b49e-fc73d9fb4ee9	9a895c8877	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
012d5944-55f2-4fa4-b48c-51dce5505498	b376d4b7e1	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
72a6cf6f-e33a-4f35-9691-2fa999740398	74ac1e15bc	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
f3e2ac84-ca03-4191-bd43-7f40ca37c3c3	010fcbc522	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
373b916f-68fe-4333-981d-9c6f26ed402a	464f43fdc8	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0adf3477-1871-4ff5-8629-d58cf1a16286	afbad36dc3	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
7265f848-781e-4c03-b82a-e1f4bfa49d17	bc55df5cbf	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
2fe5efd1-9a4b-4de7-b00e-51a228c3a231	0cf9fdab89	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
007b2950-c6a8-4fe2-8f01-02939468e46d	f06139ef6f	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
c962479e-7eb5-485e-80f2-7b2549a0d966	2d05566c07	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
68e5ed1b-b07b-4d32-8522-3a0bd23313a1	c6d6ef509c	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
fead42ec-7a21-4648-8ac4-3aea42689035	41ec33f5fa	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
1e9b564e-7703-435d-a9a3-d01604d3e5e4	bc104c4963	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
33c300bb-eed9-4ca4-bfcc-5c74f305edb1	58858d9ed8	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
a8303e07-02b8-42cf-b8ea-ee51224e9735	fc805a1d46	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
e2bc7bb1-9d37-4460-b92e-1ebf45931ebe	b5df66aa21	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
dca1d104-cf35-41a0-b4b4-407df34ce028	0b2980cf56	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
68ef7abc-3e64-4ffc-bd5b-c1fe0cf670d0	9adc85d5ca	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
28e1b036-ef57-4639-82d9-3f973fc1305f	7d2b308e3b	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
ac5e5239-f877-4b01-888a-b99f5d442d85	bcb3c49918	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
5c9bdd37-d1e5-44df-a25c-fd0e98533293	705607f16c	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
05daecc0-7905-4a7d-b1d0-42849f858ca3	0b81339e91	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
99a24abb-b713-45ff-9408-9b58bc0fb8d9	0c600a0495	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
a5485405-f0bf-4011-b9be-45f96f52143c	2c8aed6048	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
4fa1757f-ed5d-47af-aa7c-ad7aad61b7ba	e12a47018f	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0f02ffe6-614a-42cb-9fce-aed0c078031d	6827958ee4	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
7e44820e-ab0c-442d-9bcc-c4b2a22478c2	acfed0c77a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
8da66935-07bd-454a-a8fd-50e4faf9be76	65fe9f0b0b	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
80993e22-e2e3-43d2-bcaf-0fe59276860b	24b2afdbb7	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
e8a3b446-c2c8-400d-9bac-edea49c56cbd	8f691d6b11	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
5ceac249-db03-41cb-a840-e6db2b67452f	40abc53afa	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
43991e11-8e9f-4d95-866b-9bb776d13e8e	b40232543e	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
e7a34c2b-6292-4415-9edb-72f26b070183	9c1fc8161a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
fcbb23bb-3881-49af-84ea-c1547f839e84	2f814214db	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
b85a572f-1953-4439-bee5-409b3d738c91	106a4642c4	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
a19f1d25-8be2-49b6-91af-804d162f9d5e	2e18e2ca45	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
cb17a5b7-3e19-4dbf-9cbf-6f8f62a28f77	ce9ce8fa58	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
4299839c-8f41-4aaf-93a0-6888fc5fe5cb	8bac376649	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
c5032860-77b7-4029-a2fe-5e496aa37fd2	60ca5d4937	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
e62aead7-5ed6-4a25-8f88-c1805c892a38	f0276dce31	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
6e8d8707-3500-4083-ae1e-ffdf5809cfbe	f0ac815050	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
56f63fd0-eb68-4a86-8e07-e01e520aa0b0	7d03fbc584	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0564d6fb-993a-47eb-a004-98ac4bd96796	0827ba11a9	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
95b0e43a-a8b1-47c3-af88-d348527ab620	009e6785ca	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
d015cd6a-9a3b-47af-a69e-0873a86d9988	61fd2336a5	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
9130e056-98f4-4d3d-a77a-6727f78ac7d8	3927dbf61e	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
50f9303b-ac3b-46fd-91fe-3884b905f90b	62c120453e	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
be8a7705-bf15-47b3-9758-bec44ae095be	6115fe95d7	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
61c5c615-b8ff-4ecb-9621-f86fe2fdfde4	44d80e5959	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
feac766f-e0a3-44df-8812-b48d9067df8d	bd09b696f1	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
47b37df5-b63d-439c-a7fe-e829e84ee731	2f855f6d76	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
3df0b191-8f97-4e08-a3bb-b743b2eff443	2b9cdf5021	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
0b71e596-5bc7-4862-954b-13d710af901a	f3b5ccf781	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
8ce8fa7d-92a6-4ecc-bb0c-15d6e73379d3	439a572d81	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
3404940e-b896-4e51-aeb7-494c3387548c	231d3eca13	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
3bf93fb7-6388-4211-ae3d-f07a5303f99c	9a091b2c4a	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
a51de1ac-16e8-4ecb-8518-eab948129d69	6ddc4a8748	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
3586fa9d-9a5c-4aa0-9df0-c233ef64adf5	d2003acc56	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
bfd656fd-cb4e-4e83-91c0-e0ac3f5e16c7	62340f22d7	567f1b19-e440-42d6-bb5e-3e693fa240fa	\N	Ticket for Couples Therapy	default	available	Ticket for Couples Therapy	500	\N	\N	2018-03-25 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:30.773193+00	2018-04-01 01:39:30.773193+00
8ef6fed8-8cbf-4c53-a376-7e174d279343	83b96a6b89	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
2daf4176-5c6e-48b2-be7b-b3111a7fe8ff	0b6a0fac56	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
ad22f55b-dabd-450b-ad9b-eea0444eca8d	9e9bb72a65	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
214aa9c4-961b-478e-a616-ed42d4ef3844	a3cc6e1711	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
09c57550-d459-4ebc-bb04-1f2880cd77cf	0c5c28b41d	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
4c835917-69e3-47fe-bf9c-fe8f5935bbf7	05fafc9d44	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
0dec8019-0e4e-4e58-ba0e-b1c323e095e6	a9e2757f2e	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
29eef037-88cc-4c90-959a-414db0b67221	2a15532cc1	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
5f9329f9-9e99-4deb-a1c3-5ac56a5025db	7f0e118d6f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
d211fa3b-ba24-4879-a396-29f2c44a5e25	c5b75f60f5	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
8b1c0b10-efeb-4323-b1ea-175bbcefe109	dfefbe5fce	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1df30076-c781-4d6b-a675-d8ff8eb4b943	81e83f3547	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
c30f0ee4-a1b5-4015-8d8c-c30a2b4cf48c	643fd390ca	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
53a5406b-8fbf-4ef4-963f-546ea81af910	c2f557a114	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
cb393372-19ef-4f03-9cb3-112eb107a49e	475bd89873	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
5c05b2b0-0918-4207-b06b-8546b8d5a8aa	8437ac0b5b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
e8b4ef77-bcf7-4f68-9dd6-b6515616bf3a	240858505d	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f536af04-656b-4eb0-af94-0151689c1079	0ce72a141f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
644d0ee3-2730-43b3-8eac-c2272d7c37eb	2ec730d5a9	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
8e6d055e-62ba-48a9-b07d-496d88679942	c9fba75ed1	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
555c0d16-a855-4a9c-9a1a-0206ef513efa	8ba0a1d934	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f47c5581-1296-4f08-9df8-bf9b82952bd4	33c50480f8	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
23df7635-e94f-4cba-b3d0-8c8e3fb92212	3146c7b6c2	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
40592ad1-384c-411a-ba66-c3f89406494e	e61e87c5fd	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
9e0de00d-80d8-4009-8cc0-b1aabe087ac8	6e435e8117	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
25913097-5f5e-475b-86fd-a6dbc3305607	8d3d6c75b0	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1f8e3296-dbf5-4ad7-96e0-57d11d21d9e7	1d6b1b7bad	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
89a52682-081c-4758-9b8c-7a9311a56525	27fd6aef7f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
71410d2a-539a-481b-9635-f0489e438c47	245f70bd40	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
89c473d7-2561-4830-a283-3e0217fa8a63	e68e363e2b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
6ae4fb37-24a0-424a-88fc-80a6041ac013	a973c4badb	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
3e7bf728-241b-410c-b9a4-4d256d131c27	89c297248f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
60a12c95-4f60-425e-ae71-01a3b1c27f7a	37df103697	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
a76596da-8b8d-4c5d-8d10-0408e1f42967	6ab023d485	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
7d39b7cd-903d-4d56-b82c-13acada119df	0922370ede	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
37f6d894-1aea-4021-9696-9e10de61d036	bcaa56aad6	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
aa418e15-e13b-433b-b111-0fc4fd59063e	5d1dda2010	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1594bac5-eeb7-4fdd-8bc0-4f6d8fbd7b4e	98e9a7c911	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
3b2cdfbf-d6c1-478a-b109-961a59e4a6a0	1fa9dbc9d1	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
04a83ecc-265d-4081-ad99-08a8c44fa8a1	1387a7e4ae	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
99c27020-8264-4d48-97f2-bcd323a69fd1	0e35751134	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
4330d2de-a577-4f28-95ef-e1e5fe11bdb6	52b25e928b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
9d06d110-1e20-4ede-a76d-727b6759f0a5	f531c3de94	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
bb871423-ee9e-4e4c-9687-44c79e99d831	8cc98d4d48	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
7fe560c5-ed3d-474e-be84-67147aec2681	f85437d97b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
ab17c2f3-2916-4b05-b586-9017ffe3b8af	00843a02c3	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f523183b-12ea-48f0-80f1-c59059ef64af	4e8ddc59e2	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
6def2985-636c-4119-ac75-8e849b2021e1	2703a39ef5	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
5358dc17-4169-4289-bb5e-2b55f7fb38a8	3a6480a5b6	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
c66afbe7-422e-497a-b299-a0427adffe1c	f4055c583b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
9d5c7fc6-d8e9-4fdc-b085-f66be474d8bb	271135f63b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
6529500e-26bc-40c3-82a4-ad7d8f4b6476	c4d4c7680b	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
86af86d1-d7d9-4ffd-83df-1f390f01a977	0ca0b75f50	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f04e3b88-8b42-4a27-9d97-ca03dc27a249	5363817eab	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
27cf9875-bcee-42cd-a50f-b5df67774636	89a72b7b7f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
782acd31-b65c-4297-99e6-6ccc44e4f29c	911728206d	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
4c728127-dbc7-436c-a3a5-157e6bbea10b	1e9d8ef219	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1914c421-16c5-4063-ab74-d30500e9117a	5f2cb4fd56	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f88cbaa7-074a-48bd-baa5-2e7db379eb32	04e2460374	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1931ba90-93b0-4bf4-8a99-729c73deb809	903184962d	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
af2160c5-0e17-4b8d-a65e-a7e3a787f38a	dadfecc573	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
b3c01660-d55b-4fe2-bdc4-890e6811d532	41a9f7a65f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
7f60b94b-677d-444c-bcc7-cbadf14b3c78	60d59c4362	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
ce83335e-cb81-41f2-b460-caf5bd324e3d	2bb849b52d	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
718d0fba-2781-46a9-8c14-63bf132e4eda	8351bbc09c	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
920e2890-8401-4b43-a1de-6bdf826fc46f	814b9125f8	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
13c774b3-96b0-4fbd-bf19-da77d52f4008	a85f2014c7	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
17e0d4ab-b00d-4e93-97f0-dd6df5b8292d	e1e8089384	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
d7455500-fd7e-4bf8-ae42-b0709beba48c	f1d97d18a7	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
bb99743b-b87b-40fd-a158-c68c0e715fbe	c9d8288739	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
6916dbf8-0fb8-400b-b5fc-338139e01b34	aa002266ca	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
0a656ef1-d703-40f8-8053-60edc83b3212	427d7d3bed	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
b428b661-2c8e-4752-97ab-0270b3cb7904	1a75750fd9	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
0077da4e-0ce7-43e3-9bff-ee11ccb9d6bc	6c59a2ba7e	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
4b1ea7ac-71e9-4aee-baf0-e7b36079f5f2	e68837d2ab	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
e0e6d33f-f6ac-42ab-a6e0-2b778258e6e6	4d7a85fd4e	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
f88d643b-2af6-4c49-bfa9-ebf769f2bfe6	7713fa405f	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
ccfbe7bc-6ae4-4688-a783-71071e294b64	0d925d311a	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
5e73f05a-7830-4b28-ad96-14293b1d03e1	d35dae460c	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
cb471b04-9bc3-408b-9f26-049fa47cb8d2	19d7a634ff	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
1c694ad6-2828-4ace-acff-67da46c78e12	0ee936da64	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
b35953fe-773e-49f2-989a-cc388df355cd	a877b22563	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
83ce222e-e42e-4a85-b239-ceb22a189256	d298bb4970	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
afe8d26b-4527-4d1e-b3eb-708f7bad5e09	b566cc1a99	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
fbc0c018-9991-4c48-ab97-06be2646e792	1c90a49969	018cbd58-059f-4cff-adcd-a1b2452d5a47	\N	Ticket for Date Night: With Brad McMurran and Alba Woolard	default	available	Ticket for Date Night: With Brad McMurran and Alba Woolard	500	\N	\N	2018-03-31 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:33.43352+00	2018-04-01 01:39:33.43352+00
e6e4b360-7229-448c-929f-ba04eafd72a2	838d5164de	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
f728965a-e99a-4423-b70a-eda1d25f9917	c559102118	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
e58c472f-5540-4cfc-86af-46b3b3368f63	4b8979fdc6	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
4284310c-799c-4e63-8d8f-39539a4be245	6f1099469c	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
89e237a2-e807-431d-8cf7-d9afb9dd1d25	e5e8cd16f5	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
ae2b1829-5e98-4e02-9c2e-593efabd3efb	88832d40e8	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
7072ebd2-6517-4595-8cd8-df6e9a44f624	7abafd20b4	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
9ba299a1-db7d-4a45-883d-e09770f95e79	e83e3e1994	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
12083bf7-2779-448f-97e4-0c66b7af201c	097a0f8cda	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
7664ce4a-77c7-4147-9222-2829ffeb1168	faed9bb501	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
0311e9e1-54ee-479a-b1c9-956dd3d329df	ded015fdc7	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
c5017458-695c-4cd9-8a78-e038fd6f360d	adee4a0c46	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
f379ae1a-d60f-4dd7-a254-115afcd9b842	21be323460	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
627b9d5c-b2a9-4df1-b44c-ea8504b510b6	ff257277f6	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
a4adf910-0ff0-407b-8fe1-1844dd076b49	de218c2863	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
af9f12a7-084c-40fa-a2e7-b908bba66d10	ca06a29331	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
ae986603-8b2e-4aa4-bd5f-a1a3a1f9fd5e	77f73a9e41	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
ce6faf9f-fda7-4905-83fa-bb5ab9777559	4f4fde1475	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
49cdb5f5-35b5-4955-8e80-ebfb742a20a0	0ccbfe702b	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
b88deb0b-5d70-4947-ba9e-a5042f792c05	d0d91e4cc6	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
c5077e71-da85-46ab-96a6-b00f37c1f577	019aacb300	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
65eba749-0161-47ea-8431-bfcfa84b333a	5ff8751b0d	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
416b71d6-1db9-43a7-b157-1fbf855f255a	0f5ee7a89e	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
6c95a024-e007-4bdd-ad83-4013ca49c29b	f1e63b2489	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
9503e510-e549-4a82-9572-c1c5b9a5558f	65ee796bb5	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
bf6be4ac-52dd-4c9b-8415-a51176fb760d	72c480cc67	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
6ab8565b-68d8-4d52-bf9f-723b4a2fac39	44f21cf9a3	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
f52dc926-8917-403b-a60a-c436c9459a58	d9baa27e3e	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
d6abefc1-bdfd-4c92-a77d-9045dd43afbe	4c5bc5d3d0	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
4ef50077-65b0-49d1-b418-d2986cebdf6d	19c21752b4	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
b74cbfe1-7d74-4cd7-82b6-ae4517113ff3	1356b90392	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
327d2f34-2c5d-4210-9cde-11ea642340e4	f78a2d2cd5	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
1bf8cdd7-cf6d-4a5d-af24-b67ac37f5834	f98b9bfb12	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
9c87f401-401c-45f8-bc8e-5b0222250130	5e43a5242d	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
bcdfbff2-0a16-435a-bcac-a0d3a723475c	5fde49b9ed	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
49265ab4-11a3-47f8-b6f2-8e1cf543a541	add35ba9c1	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
1518b8b0-bcd5-47d2-8099-7f22b285862e	7292e53871	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
dbaaba65-5280-4399-bbae-2220628f4242	751819dc4d	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
ee8f9d92-763c-47bc-8b9c-f4c3045c1c4f	60faaa63ec	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
1036928f-4b21-4ecc-ba3a-cdae79bb5a20	79a0e93390	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
9d05b074-5d1b-4597-b26d-b6555a6a42d4	e3925aef68	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
71601b5c-0267-4b78-a23c-76a66b5bd8be	866e814d0e	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
849f6b87-340e-40dc-8797-44120d74bc86	bb87ea4e40	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
90adce8b-8d46-4fce-b30f-18fd75b4e58a	e798860414	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
e2dfaae5-3460-47f4-ae6a-5310d91ee60b	62945e4faa	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
84d12634-fe63-4a61-aed6-215a14360782	a4ea360abb	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
d1ac32d1-05b7-4c24-96b3-4bc294c5af14	a071751d6c	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
2c291ff5-53b1-492a-bfa0-3290ada20a04	73cacdb993	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
ad0b7226-2c2f-4d25-9b61-3050838aad86	d2009e50c8	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
895efad1-c298-45a9-a221-9ed1c6f79997	f483bc0193	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
2f0e01c0-3c49-48b1-8207-0a68ced62e16	80b0a5fd4d	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
14aa8f06-08f2-413a-9f27-b568ee39d43b	b872c7c1e2	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
527634c7-0b11-4380-88a5-ad0687956d13	2a2b0496f7	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
7213c321-2a4c-431f-a55d-1fe0f70b0a6d	b363224195	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
a2e10b93-d716-41c1-81f2-605fe3d37775	f1b91b1cf9	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
814e34ea-d9d9-4280-9a59-a6e9ac8d1af2	dfec637181	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
fad65874-6505-44cf-a652-927e8f7c8533	c43d0d490c	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
df824909-f6c4-4265-ab62-8fcc756be2e4	ee36806257	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
981f242e-c64f-40a9-886a-b0eb30a18e02	5587309608	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
d6899e21-0c05-4875-874d-d3326bc42b6c	aa3df8dee9	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
f563dca8-640c-43bd-bf29-d76a1063368a	e04929547c	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
04e3977b-66f1-461e-ad66-af55c1c687ea	6ee16e8d91	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
f62cc5a5-ee44-4f0f-b610-9afb03e7fc9e	7a7da7b9fc	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
90545be6-279e-4bc8-b3cf-96adf910ffe3	c44abd6c5e	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
434e0206-8597-4484-b2a9-efe1b14c0ed6	195aa5a8a6	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
b77307ac-d406-4c05-8c3e-5dbea7080b91	9ac976c3b0	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
fb88253e-89cd-4199-9e56-2a6a112c700f	ad2933e7da	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
3722887b-1a1e-45d1-9573-3ab16bbbb4a0	8d1eae3428	9561f75e-d647-4310-9365-dd021f48efbf	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	500	\N	\N	2017-11-18 03:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:36.077641+00	2018-04-01 01:39:36.077641+00
9960c918-146c-417a-9823-669237f53886	e91025f363	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
cc4659f6-38f9-4f6f-b86c-037cbbba2ec9	79baa75b60	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
1a3c674a-b939-4724-91ba-84339b299c2c	d089124f5a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
eb1d91d3-04ff-4e40-9c5a-44d0f2b7429c	21198ddf76	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
fcf6a292-2ffc-445d-84c4-cd3217cd1b8e	4c379568bc	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
333afe23-d2be-46a2-b5af-79eb6e0f3d96	8aa090d608	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
7c46993c-13ae-4a69-ae51-d55f8695152b	7fc46d0762	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
f2cb8d99-10ae-4c54-bdfe-99618c550861	49259d0b9b	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e3969997-fa62-4f9b-920e-6c1bb8ac1f86	806e7f152c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
1d4ddcad-5da4-407c-b478-f2c0c26ccb72	afcae72839	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
dcd92dc7-0b45-4fe7-9258-1de7f96f9c36	3c2be6b29d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
95268d62-a2cd-4a2d-8997-377cb8a5d19a	1913115e3a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
b17a1f8c-20f9-4b3c-854b-753254b744d4	836e2c2501	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
7f930fd9-2eac-4493-81cc-202999714e80	1a653eefd2	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
7e7c1306-7ca1-4dcc-8b00-fe4e1de73c87	cfcae4a90d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
26b476ea-5611-4b0f-9a8e-691c886cbb6c	6da553017f	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
804d66eb-2a30-4885-9137-9268b0cf4a70	0b23073c06	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
851bac22-e605-444a-8731-5d7a9b8fda02	6dfa2b7272	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
9d811d73-80fa-4b3c-bfa4-2f6a420b6f7d	8f04ecf598	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
1007ec41-4684-4f35-94ac-f375156c0660	42c5582d45	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
4db20465-f693-45e9-934f-6c4c484e1bc1	d0f067f0bd	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
0582733e-30f5-4c14-be0a-e08f7b88ef2b	fb9f6d984d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
01fdbc1e-44b0-41a0-934f-5116a8158869	3173f1178c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
40dde647-3637-4671-ba31-fe3d38bf5113	c409856c39	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
cd13aaf8-ad98-48c4-87d9-e8c5bdc364f7	b89c6607b2	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
ca32c15b-6b3c-40f2-8b3b-6435d6d4fb36	4d71703038	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
34359a59-82fc-414e-a075-583ef1ae72ff	2fe7c9f72d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
aadb82b8-e2f2-45d4-8d09-f0cced651ca4	25dcfed96f	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
0f2971d3-f492-4c76-8a05-d3d60b3bece4	6855911d3d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
bafc1069-fb29-4ef8-b15a-7b8387e80d67	b32ecdb9a8	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
7587fc33-b54f-47e0-a059-b2ca0324b2cb	25bf8bb70c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
8bd299d2-517a-4e5d-9c2b-98d3a6131ffe	65e96ea70a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
86032b8d-c4c0-442d-bce1-9d9df45cb5c1	8822b8d9b6	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
3421a211-2f2b-409e-bf5d-3204bf680a70	781448e917	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
58389d9a-1f33-45cc-9e48-09fd14473a6c	043b52053f	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
34e34373-7f77-4fb8-b858-a8c64ad92f8f	7ed3750159	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
feb72a53-82ee-4f59-bb97-aa8197e2995e	060c93bf54	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
c555c6c0-d7a2-451f-bd79-a9d53c77e93d	6c878aafd5	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
8e4c688c-15d8-4528-9f83-3cf8e301e128	91c93cc023	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
b5ab6d0d-9592-4fc3-9d3f-9a00214663ba	e09f1c23b3	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
2157a559-6bd1-413c-85a1-d26968bc9ce9	8264e47b9b	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
7e58433f-0ee0-484f-8871-cf36ff6ed267	0943f690c8	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
8d592639-e28a-4d55-8751-7652c274fe45	9cb44e9056	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
85bfe032-8574-491b-b1c0-27420b49390f	1a163a114b	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
06a607bf-34d4-4616-81a3-fdfec8ab5125	e0615a053d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
c13ddf88-963e-49e5-8aea-a5b6d582b3d8	e789ff721a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
76fa9782-d91f-4584-863e-36f68ec25915	de8417e961	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
fa451cde-5232-403b-aedc-3bc747db7a1d	e16f14e88e	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
9ecc1a6b-f6f1-4d45-bf5b-1a1924e6837c	c855efe019	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
2f28b323-c2d8-47f4-9f78-75f545e5b69e	1ff37ed15e	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
b11ca47e-3492-4664-bda6-4045a7b6dbd4	ce9932a03c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
b6af090a-a551-4c17-8826-7744e60bf6c9	19f0f02592	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
9996343c-af4f-4d31-be30-4b1074e40218	ed30cfe72c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
71bceb6e-c381-49e2-a00b-a9155bfd3df5	5e76f8eb96	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e5e47dc2-9a2a-4feb-a796-c1f2a5f9183a	453361a83e	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
2c9aced6-9c93-4881-930e-790d6e754ba1	66266111c6	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
966ef6b2-6113-4ecf-9fc6-d59f7ec2aab3	cd99fa0e04	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e81e4524-c3cf-491a-803b-7890e2e43464	519ceda03b	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
ec68c7c4-bb98-4931-8faa-b8f552daa246	cf7b93b8f9	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
11bcb145-1e95-44da-aba0-fa217455bf22	ba7344a61b	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
f63aef94-011a-4c26-94f3-52e41b4ef30e	7b0c2be04a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
a70679c9-dd9d-4c8c-92a8-a264437c0d8e	a327a2645d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
cf99937a-0c4a-4cce-92db-e75df6689339	210338aeb3	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
1362f46c-abac-45ee-8f5b-319477f13e0e	03fdba2b8c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e210791b-d8d2-4371-9ca1-ca1d1be63a0a	cbbdd04a28	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
fd7c770e-acf0-4087-a9b9-bc85ffc88b6e	bf96bde51d	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
ffc51a84-8ff3-4d0b-949b-ead291565b1e	e2bee09baa	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
83e7b9ab-1fea-48ea-90ee-7250fd0791fe	97dded8584	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e6692332-fe28-4041-bea6-018e984acc3a	95401518e2	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
f24fc304-8fa7-42f6-bd95-c63f05c5256e	b675f72cc8	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
5256dc9b-cd79-4a8f-a3d5-027d73a1841f	bee6213bbd	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
87d14ffb-7789-42c3-972b-d8cfa0d59590	15ca9a2635	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
cb8428c4-c46e-46fe-8e3f-e289ca75ebe3	6346a5dcd2	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
47d00ee8-b64d-4d3e-b0a0-a12b3cd51ac9	eb4b9ab965	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e335f25b-41b0-446e-9fd5-02bf536ee15b	4f637edb07	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
729999ff-faeb-4d6c-ac59-0f62f20f4e89	dd18fe918c	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e8a8f49e-530a-4c86-ab39-1eb906677150	d3cc1c7e5a	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
32f3d295-f7be-4bc0-ac3e-7a0b0c1ab232	a5602eecea	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
dc52824b-0676-4049-b8cb-ac44905f0de7	3e8b678f25	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
e4a7bc8f-663d-4c94-9363-05f6fc83ab4a	80ec44cabb	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
49a66289-06aa-4de5-b090-40b40a9d0129	877521c442	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
9aaef51f-4dbe-469d-906f-f5f9f6cc8397	266e0b1bf3	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
169cfffe-b10a-41d5-9ecd-e9d08e18b9d8	c81ba0994e	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
8705d824-d0de-4b27-83ed-4e6d94ead9ec	4f73cde4d7	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
5354ae28-a9e0-49b3-b3e2-2e0138cd0f44	a0b0a44a59	31de5df4-da98-42bc-b075-297489ff970d	\N	Ticket for The Unusual Suspects (formerly Who Dunnit)	default	available	Ticket for The Unusual Suspects (formerly Who Dunnit)	1500	\N	\N	2018-04-01 01:39:36.190283+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:38.795699+00	2018-04-01 01:39:38.795699+00
24a3df4d-c512-4ce3-a685-44a31f76755f	2f2b104bb4	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
d95c5196-9a46-4916-a137-8f2680560b04	b0bf4517e2	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
43670a8d-e077-4189-a05b-46f549535bed	f856ee84aa	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
c7c684ab-3ab5-4880-bcbb-81ef58df01cf	694cbfe204	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
3c7f2aff-6222-4717-86b1-7ed90ed8897b	72232ab13f	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
389dafd5-fad3-4f14-933f-044c37c70778	68152da5fe	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
67507970-3c41-4c66-889b-07365ae705eb	9d839399c3	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
374226f6-6efc-4677-9e9f-32ab7af0d6b1	035c43445c	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
542dff97-0eb7-4169-a188-3523b6bd8153	25be292171	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
a4f93c2b-1b90-4791-880c-180a41a6ac95	e6bd391f36	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
e1f98c11-3ec8-459d-b85b-e7c539643099	dc067dbb05	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
987cc56b-d1c3-41cf-a176-f08ed7277bb2	fbc5bfd995	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
860b0a59-6c89-47ab-b9a1-e7de1dbcf9d7	b9e70d1555	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
d48e6e1e-81ef-4e9c-bb2e-544d4b3f9b08	5219aa333d	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
e9a01835-d84a-4526-baea-87a8d3424d21	1bdd8b7cfa	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
d7ce93d3-ef77-4ea5-b7b2-7f3da3e42c33	da5dff4e4b	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
92bd40d9-245a-47c0-b5de-6dc312f192ef	09852ccffa	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
275e65ea-191c-45e6-a2ce-1bb035fe6368	081266e320	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
59629f48-b55e-450c-87fc-f50fec4e8dbe	4808ae0c87	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
440892d7-0abd-4234-8aa5-b5f9e6446b62	fb2f8ee805	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
f9b38eff-e742-4bc1-b76e-57d220a30715	8b8a4183f0	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
35c2d18d-5356-4a13-bc28-5f298f25d7bb	f22eb1ba7d	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
8e39b448-e1b9-4f9b-8c00-c9f49be3f5a7	a64c0cab39	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
43ab5e00-d792-420f-9881-3735925c0be5	8f31bec76c	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
1cd4154f-c3c0-4bc1-ad89-f5e62a91496e	21bdb1192f	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
aefe85ed-5567-44bf-a9d6-193630c6ebd7	61768cdd7d	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
ab98916d-16c6-45b0-8388-88b3cd8c75e6	a182fd07fd	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
45d37ef2-4d46-487b-ab43-5673b3e4ff95	1148e1130e	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
23f44032-614f-45c9-87d2-888209a64f76	ee29718f92	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
f7f0cbe6-28fb-4878-b6e2-f961daeed582	04b82b2d60	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
d29e88eb-e763-4095-b536-d50103667e92	3b548a684f	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
861ab8b7-d674-49ee-9f2f-ab93ddcfecc0	68748fbf14	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
1867bb8b-3ccf-41bf-9cc9-b616f0d818c0	17bb9c2bf9	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
8e16070a-6764-452b-ac76-0fb05570acb2	45864ed24c	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
1907b4f7-b0b6-4c1f-97a7-6e43f161428d	3f73bf65bc	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
3e7351f5-8c6d-4eda-897b-6cfe8a788811	84ac6e9e83	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
ed024ec9-d975-4696-b45c-27dbad54469f	ef20045062	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
f9762939-b0af-4ca2-b90a-f68105c25f92	d1e656dc02	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
cc447955-a48a-43db-a4f7-2d493cb9bbe1	b174ed1a19	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
3036f03b-21e1-493b-ac8f-c5921734c2c4	bf67c41e12	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
59942535-a24b-4201-9f53-1dda2e622e4a	6281e11e92	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
75c425e9-66b4-4f2d-bccc-3efb9df3201b	55985be784	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
23abf917-145e-45e4-8b85-a6e4e3acd730	479ffcba54	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
bc77254b-e8ae-4ddf-b6b5-544805ddbc8b	638aa4741a	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
507647fc-aa3d-4666-bc19-d409786c46e7	072ef58b17	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0dc795b2-070f-4d8f-b530-60959cf16b47	c56d51a812	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
88586ee2-76a1-441a-a3f0-23adcaba9b50	c4682f8fa1	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
374e905d-2763-453d-b06d-c412dca90dfd	45672d7ab8	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
fdcc78dd-ba0f-4860-93c2-a3ec1b78f84f	168dbd9ae1	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
e6c177d2-5f73-411b-aeb9-8c42c395da1f	1e2f5a7ef9	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
1f086ba6-0319-47a6-ad52-73839b5ed2f6	d60853292c	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0dde8075-7bb4-41be-9d4e-7bfecc347ba5	146e550d00	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
f011261e-c5b6-4812-83cc-27715cc16fcc	91bdf8ad16	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
74c2d09e-fa7f-4f8d-b7d3-92cb153ee58d	d583ebeaf5	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
885ecf92-2c13-4aeb-85c5-398e37e40ba0	e57c82239b	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
6d082b04-32c9-4cfb-b388-e353914dff2f	2bb4d41f48	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
e23b0295-1795-45e3-8861-bc3ab82eca0e	9c1395e04a	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
75a7d00c-413a-4ecb-8831-71a313ff29a5	ac89dd084a	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
aebf2770-fe8e-413f-9032-f0514fa74a34	b73845ea6d	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0e64bd64-8820-4cfe-ab08-4dae57f20fdb	40a4657d53	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
88782d5a-0f71-41d1-8299-570a5e197e6d	5423420344	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
fa1984b2-0511-4be5-9132-85511cc2a435	77c4ae9421	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
8350bf13-ec7a-468c-9941-85f3315d7897	b960138a4f	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
119c518d-5e27-4e62-809f-9676e91c1e32	bb97ad8310	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0cb5be00-cf6b-4246-998d-322b9d3935ca	c51b38034e	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
376f5e6d-f969-4d47-b587-bab6e58b155c	c8ee4bcb03	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
01c604a4-bb8f-456e-afa6-a8b5370025d7	3f053e71bb	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
c33632d9-5f6c-4d84-9b5c-bc3fe9bd5d8b	761231a5b5	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
6c065133-5245-4c72-b561-ae7723e29a38	2c7c9d978e	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
d55a99bd-d038-4aa8-80e6-b3c3ff3266ac	0b184ca28a	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
c4db05fd-ed8b-49eb-9788-6ee219f3201b	70e017030f	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
5e3ea4c1-2b32-45bb-8d64-52fc813104dd	9beb256823	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
85b1a7e5-b0a2-4e5a-b622-54f687042f16	bc2a5062b4	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
cbe87a68-24cb-4fcb-8a9c-2af4daed64cf	00597a3d99	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0aba4fbd-0822-4304-9c8c-0f9714182b2e	f9ccf72c29	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
edeccf54-7058-4418-8f85-4488c42d53e0	af275752b9	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
0006fc72-14af-4544-9829-9f3aec699c2a	b89d111bad	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
32207a6b-347d-4147-b3ee-682c282d3ba7	bdd814e999	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
e00e7029-4f0b-4272-92d5-a6ab074d8aeb	3d8f71e5a8	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
87ae6f9c-6762-4888-b225-110970c01b09	10cab06fdf	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
842816dc-25aa-4bb8-9ec5-84028ae3a19c	6a1d180589	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
6d6dd608-f3f2-4dce-a4db-1bd3edfd6a49	63bafb4bd6	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
f1105a2c-e30f-452c-954c-922686f0c6f1	96cf7a3e9e	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
8a5f61fd-6eba-4645-b579-ff7c7486c309	27e22be9ac	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
61fc333c-87ac-4aec-af7f-870bfe34e880	74ecbde892	b811cf87-408a-4bcb-970e-f942c45dde92	\N	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	default	available	Ticket for SKETCHMAGEDDON: The Ultimate Sketch Comedy Competition	500	\N	\N	2018-04-01 01:39:38.897665+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:41.37917+00	2018-04-01 01:39:41.37917+00
32d860f6-2042-495a-9f8e-47aa2289a0fd	117efc53c5	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
0b68aebd-29ea-4a42-beba-57409298237b	32965a01b2	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
189873e8-bbdf-411e-94ac-8211d8b253fc	9db24cba0a	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
1c3f3f51-1f3a-4cac-9fa1-efdbdf6f69fd	108bb7a639	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
505d4485-6cd1-417e-be34-4f915059fe58	b03193ab42	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
4ecaf6ec-3f6e-4965-8a66-4d28db3af14c	fd6a0ab711	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
565cff5e-6968-4bc2-b628-f5a75d635785	f757e3bead	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
60fc7fcd-e77c-42ba-9fba-cebfb5d7dd4e	d6f6ccac9d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
a1438904-96c0-4bbe-ba93-23d338ec7cb6	1160800715	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
72a21c42-214a-4b15-aa23-4e60f73455b6	4af5e239e0	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
5046d600-e235-4829-bde0-f3a873fcd719	efd38adaa3	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
63519431-5f70-4e5d-96a9-442de1521137	68f9cd8ba6	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
6c99fb54-e17c-4775-8c84-fc1372227219	4496e22284	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
31b1c767-fe86-49b3-a4f6-1f7a4b6f90d5	e0d6905d5c	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
f0763f1f-64d1-4600-8bd8-d143502d57ab	0700aa3d60	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
62746672-5a25-433b-8b57-0703d313d8fe	361c88742d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
63e1d5ae-31d5-4557-add3-5559f3e324c3	ba052d3958	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
b1df414e-b33c-43ae-86b0-fcf0a0679745	81bb47e747	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
cfbe4fe0-4af2-410d-ae9f-4122943c858d	fc31929a21	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
8c56cb1f-66d1-421d-99bd-d960bf42a61e	969a30ef13	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
194e8058-53b0-4019-bd13-85a1a54d123c	7d792a15ea	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
29b20d21-c767-4a16-9187-27253b8af0c7	9915014cac	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
c9f441bc-1956-4d16-82d4-99ce3003afe4	261430838f	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
60430d9d-fd9c-4495-b45b-4b4ec8c7439d	d5db2346a3	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
0c385cfb-a850-43e4-82d5-9308cc18a315	4c0fcd3513	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
917be1a0-1201-4ae5-943e-076d756cd749	abecafcc0d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
21685b59-12d7-4520-bd71-c5149eea270d	7dec12cbba	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
cd04f3ee-46cf-475b-b5e8-97ec07064368	9582eb7ab2	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
1ee0120a-f883-467e-9e9c-0b2abd638a3c	96cb567cc1	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
31e42d20-e043-4020-a75e-f02ba212f745	b4f7259150	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
144ddad7-95c4-4e21-9e3b-ca5dcbc26063	541bcc7c2d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
58a09d95-f209-47e8-a434-ed8e77f49f96	79830b0eca	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
d35c74cb-142d-4186-92cb-75f076d740d9	bdc7de45ad	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
b38dda12-fa11-4d8e-93a2-1af1af339ad0	d65eafb925	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
c1e7e781-1cf1-4157-9c4d-669156bec9ee	506fdcbacd	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
5c29bb95-4dda-40c5-9c79-6fb5ec25e44b	8346c8feda	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
f14ff1ca-9de5-4c2b-9864-20c8ffcd0049	1dc3b48517	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
58298a83-75e4-4b31-9372-7aa56d7640cd	6236b6d2d1	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
75da123f-261a-4eb0-b07b-5e6a47dfe57d	2aa20eb84a	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
7386e0f6-b10b-4c30-81e3-1ca86819403d	003c2f11db	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
97074991-c05c-41bd-8334-881ec6b279f0	6bf9b3341c	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
81b33470-e94c-470e-a398-e1407ba490b1	7dfc1b0558	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
0f1c44a9-3765-4e8d-be6a-afcddc4a1b6b	4c24bda215	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
cd72c906-d3c7-4143-98a8-f5574534c232	f60deb33e7	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
6e9561de-63f4-457d-8a0e-64f73cde65e5	9ff551781a	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
85c6f56a-3ce0-4ebf-97bb-ac49ddbfedb4	f46fda40f9	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
12613f6a-7b44-41e1-9df6-901bacbb1fa0	872fc4667b	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
a44d43b3-07c7-406c-a85d-0f6705341cb6	bf7974f249	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
a0ebc840-c094-427b-a895-25fa3dd5465a	2f16853c97	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
cce351a5-79ca-4239-b2ea-e6144b6e4116	fbe1248836	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
3818e4aa-380e-4cfb-9b5f-402719c1d319	a407b2681e	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
c7e432c7-9c41-4552-8fee-1f8816530ca4	c2bab6d6b5	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
5b7b83f8-bb35-4caa-8e07-b7790c420cc5	dbaf2828ba	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
2ae924ba-a001-4ba2-8645-750b0ab355bb	f5061a23de	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
b889131d-1553-428a-a6d8-7c432994352c	7ab09165ff	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
bb76f3ee-357c-4188-b24f-2fc9704507f5	c1784a16dd	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
045de687-73f2-4a6a-987c-038dc298e92a	09a4c30d38	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
c187abb8-7064-4f4b-be1c-0d94414fbb98	4b7a35161e	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
307d9a75-39fc-40ce-8d37-c48d6a099dc1	d165f1749b	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
ea670de7-f429-4226-9cd1-20db0fa26400	94a1cb9613	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
f661c921-c3e9-41b0-84f9-1a97ef4224e1	d6a0fe444d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
8a38cb2a-b2a8-4816-aa0b-8fa8469e0530	bc24df7594	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
ce9c90d8-15ec-4f96-8721-024fc786d888	ae6460f3c9	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
eda908ea-4eaf-41ba-b7f0-f681a75e1ac4	5a0a1e0bd6	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
60c351a3-a4c7-4122-bfec-4d16ffba27c3	f3d93a3826	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
b5313028-5660-4765-9043-6c670803fed5	acce0924ff	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
a3d40f36-ae5a-4ba4-8c81-f45e871c1c0f	ba47131758	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
1f2a8823-9541-4bee-8433-2a75bdf94cc0	7e50ffed60	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
de1fc1ea-c0f3-41d2-9d67-5f2a53972128	206a724433	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
63cec786-0beb-4f20-9a6b-22dbcd1ed27f	c1494e5a16	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
cf349cc4-f567-4575-ba3a-a3e461ff8944	2d1b0c5d21	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
f354dd41-878f-4a95-9d14-beee70919719	13eae61b96	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
61dc7487-b2b4-406b-b5d5-c3a2415c1bab	29400061eb	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
1145643a-11de-4fb8-b72d-76a400b298f3	1227403f7d	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
bae166b5-e1d2-4cc1-aab1-a91333788e71	488a9a962c	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
35fff37c-b37a-45fd-8d55-33948825945d	0c642aa039	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
29c25128-f914-4d40-958c-0641b683a63d	c1fdd598f5	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
7d3fd687-7ee3-4ad6-8035-c3f117f0f12e	76f2442293	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
5189df04-048b-44c9-b608-28a624aa995e	9c6527efa8	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
2d030a98-76ec-44fb-8f3b-02f8423e30ba	d323f81827	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
751c0f91-7844-4310-8458-f914db88125b	3c05b0c8d2	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
b2c9cf78-1718-4e80-8308-74c4580222ee	f4f385d824	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
79666d54-78d7-4c4c-867b-42bd82041ed8	0f5aa47ffb	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
599b62eb-df3c-4f65-aeb4-d8ce80579647	42f8df651b	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
54a050ad-cade-4793-a01d-4e034e851ef2	44a52a2838	d7fac07f-d066-4cda-8ae2-3d4ba1076ba5	\N	Ticket for Harold Night	default	available	Ticket for Harold Night	0	\N	\N	2018-04-01 01:39:41.481435+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:43.892313+00	2018-04-01 01:39:43.892313+00
4f4c2e04-fd94-4657-b1ba-fb80b4fc370e	d88d2340e2	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
e70b8995-7349-4768-a0a6-997aca855b4f	a0b61da0aa	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
5ee44db9-d8f4-4ca2-bd2a-7fe36817d5a1	2f502a7853	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
0fbbffc5-74e5-4285-a2a9-b869c9939352	21a03fbcaa	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
171eaf28-e962-480b-b10c-0f9f174ae8d3	1f5985cbeb	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
9059bd39-08c2-42bb-ba7d-b8b269c8e61a	e2d59c3412	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
e61388b7-e524-4b65-8309-0fbef26a10a6	a6bd5dad3f	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
768f68f1-a16f-46fa-a076-ee832325262e	0a863a561b	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
179f0fd3-8697-4bd9-9c00-78e11dbafd94	6092c5585d	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
802fe06e-bf71-4311-9bfe-a0ef50dabcd1	7bfd0f6503	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
360f32bc-68c7-4a0f-a35a-4126880b8e56	76bb0d9584	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
3c18cc7d-aec4-47b8-8c3a-7ff0f206b03f	f70334a950	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1d9440bc-7817-4483-a559-cfc2456e60d2	bf23daa692	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
4a243c5f-b293-4347-987f-25daa89e5757	4897cf6f5d	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
9df8a3a5-1c7b-4103-adcb-83c316156d5f	787cb56d97	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
b3286255-0f32-4b18-9a3a-cf6b599a4d0e	aca4507b77	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
a10d6424-05b8-45f0-89cd-da7b48ee638a	533d163ba9	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
38154530-97c6-40b1-8558-19c5e3e6c4ce	cd6eedb639	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
229f7405-37db-49f5-9ad6-b8496fc699c2	f9ef602f2c	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
c5ee40c1-8956-43fe-8698-99a0b12f1623	d0748cd815	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
44cce535-8f90-4f6d-bf85-f9577a2770d8	064aa4c309	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
547d04a6-8946-4da6-bef6-2ec5b76c3d40	c1f3149c06	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
8b22687a-f8c5-4b9d-b77c-c0e2b1362ac3	9cfba1dba2	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
c00b1206-0d89-40ad-8af1-cdced4cf76fd	efe9f51ea1	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
71bdf57f-0f56-47a2-a8e0-7c7101f2988c	307c338110	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
eac523df-4d8e-47f1-94dc-6dcda7238792	4f4276a437	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
012fc7dd-1ae0-499d-9a82-6bd819b53437	ba35325d01	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
fc7b5759-6f81-4662-a9db-45de7ea5351e	5d40a4e831	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
b241b29a-12c0-4a2e-bf15-4b9847a5ec01	3a73f04042	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
d8408ef4-fc2c-41c9-90b7-8b3e0f082dda	b6b94ef460	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
7dac36b8-a5a2-4375-8a56-20256f2283dc	5a2c0638d4	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
37212597-44b2-4a37-b1c2-e22a5ace5a41	3298ba8033	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
7d2d1277-0e85-44d0-94e3-d37b309dbcbd	646f72c7a5	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1f815918-7089-4b4c-af5f-4bfcdc68300c	0a94829391	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
5911ba44-1890-40c5-910f-6c85e3e6460f	5935ee76a0	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
4e4ee49b-99d2-495f-b731-6daab1627197	4c21b8a625	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1e32b556-37bf-43e1-87af-f81fb5366553	ea4311106c	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
54a853b0-d020-4524-b161-5329cbf5fb44	2bebb086da	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
b32a4340-1962-4580-8289-bb38c34688ec	51aaf769cb	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
ad9b46c4-0d53-4f95-82e3-cfbd33e04f2e	6131507de0	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
744db310-3e9d-4d22-81c4-2afc256b4d4d	c51c96a0b2	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
6a718287-8905-46d5-9f58-e5a0269998f6	ce4276c16b	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
a4949e8c-c88a-4106-a64c-6775d405d6e0	cd2a3f39fb	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
222a93c9-bc31-47d8-a876-ec4f2e8159b2	1b188fd467	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
17331a80-30af-44c2-ad30-47f93d3ec7a0	43d09573fd	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
eed3b298-1692-44d8-aadc-23b14724cdfa	1ff935dec3	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
fa0ebacc-273b-4dce-bf53-228a3d67d38b	c7f3120db2	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
8b02d420-8cfe-4e86-9e55-6ae8fb06851b	da1a614536	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
c3fe1689-4722-48d7-9467-eff2f9b84bc2	6ac5e2a5d4	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
27480ad3-592c-4a20-8dd6-c21d385c6c21	61766a956e	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
339445eb-d073-4b6b-8703-dc3294123be8	6a2753a0d1	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1104d47d-2e6b-4820-8b4c-0aab945b27ff	fe92de39e9	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
ca0dbe09-7cea-4d88-9e8f-a31284f1e246	85bda11b36	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
fcfafb16-1bf9-451c-9e8b-99c03ab6b8e5	72b8eae5dc	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
c9babd10-ce8f-4633-ab59-e0235c219ee8	454e6d7377	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
17859ba3-d647-454d-80c0-77b0a4a65b9c	448e94c78c	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
d097b9a6-0d20-4ecc-8fb1-fc54c7e5616d	88f7959948	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
fdead995-9951-4ce7-a54c-549e9a25b208	6289064fe0	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
7f919d1f-eff7-46fa-8a32-eeb06099df66	fe1fe3abcf	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
4311b30c-a2d0-4658-bab4-24cbb26a89c5	323faec623	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
6c077440-bad7-4335-9fca-6b461abae30e	668f5b2cdd	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
df680d92-4369-40fa-99f2-79d0732f7dc2	3b2169ae07	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
75853199-1472-40d3-86d5-2fedac43111a	35673c84df	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
0965bbad-0df9-448f-a2a2-78516713d8a2	e3ca6ed080	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
0f29ceb8-e42d-4c90-8c78-cf99d4c421f5	988f98ed30	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
5dfb0ebb-7a9a-40c6-8254-353bd4ac1f97	589e9c923b	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
003f6a57-d465-48c9-afd3-1901df241708	b4a805a087	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1131ef2d-be4a-40d2-adc3-db99cfcb7ffe	6b61ab4704	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
a00e71f5-224e-4f89-ad4b-77b434dcbb5d	ad3735de50	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
495dba4e-b265-4729-bffe-67aa9f6740bd	1757b981e5	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
d6c7f5d2-e9e8-41c0-a3d3-86b26b65b5ad	0edf949ab7	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
66299e95-e530-44c2-ba9f-41e1c26266c2	f55bc08e74	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
ee15f743-c9fc-41a0-b70c-ff5dc5442b05	471e9b2377	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
79e687ac-65e7-4f3f-af17-b2fa6b3f0bd0	f4fee75215	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1d208f26-b66e-4441-b96d-a8d029e3c8ef	d01788bd77	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
ccb4dc47-dd5d-40b5-a62b-a9337b48e5a9	ca29d3853c	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
d9fe3227-95b3-4ebb-9eca-b08fadb68257	3200267888	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
d538dbd1-096f-47cb-bad7-c9de4d62b378	e530e5398d	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1f1032b9-ea82-4717-971e-ad48a9f3deb3	1e325cf3a2	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
99069d41-a1c9-4f41-8483-f7714c94dd5e	c06fc7fcd4	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
176c8b25-dc8c-4d5f-a0bf-ebd6231fc400	4d29e7c895	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
b96c50fa-8395-4660-a258-173b2b8ebf3c	4552263e2d	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
cc04a176-1fd2-4fc9-89f7-4f4184a13677	4b2a85214d	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
05907f97-7ee7-488c-a13a-b5557d1b74dd	7d6d5f59cb	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
1da5f511-d053-4ca5-801b-c18ebfaa2a76	814d62161b	688a2d63-3a9d-42cd-8a0a-655204b87d69	\N	Ticket for Monocle: The Improvised One-Act Play!	default	available	Ticket for Monocle: The Improvised One-Act Play!	500	\N	\N	2018-03-31 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:46.544288+00	2018-04-01 01:39:46.544288+00
2dbc9c50-af94-48e8-a395-72eed87aaa7e	fd3d4600d4	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
ae69523e-77ec-4f79-8422-ca4f0ab2511c	7ea329c2b9	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
fe758004-18c7-4ed6-ac51-f3d663539b16	d8b04b490b	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
81584827-dab5-49f1-a9ca-c49afd40c041	5bd1cd16f8	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
d669785d-d7cf-4e07-973c-942b89464309	4c3045217e	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
5ff7e731-ea1e-449b-bb9f-ff1d1828a64f	a6989f6f91	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
1471dfbe-624d-41ec-8448-ee15ebcc15ff	627066548d	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
402d0396-ae13-42ad-a27a-0735a8a29c18	6272d43446	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
cf959b98-ac67-4834-aee7-a0b297829313	7bccfba437	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
fd49fc4f-9bad-4a6e-9369-c1890a926149	497a74764e	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
a50bf61e-5bb7-4289-bb84-cf32cee6834c	e927b9e1f2	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
ab279be5-8a41-4254-b8f4-03c946f8860c	6ae8a1623f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
8047900b-e82f-4da9-a2a4-141c337b826a	5c507d0316	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
149c13d6-b2e6-40cd-8909-b1aa0924b7ba	e112a720e8	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
21c1f021-a3d3-43bc-b3d3-057259420017	d147a26918	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
56b51291-61b4-4635-90b1-2b6e3093aa2b	2bfd7bda24	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
0323ef7a-0777-40aa-b73c-9a1ea92437f1	2d651a522c	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
e3f1750b-6b0f-4d76-8385-cc548c412df6	21fe27a96d	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
ee383eb9-a3ab-4e92-8595-330b8bd93dca	9fd3dbb314	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
b6c01deb-8a85-42b7-acf1-2ebd01fbc941	a6c13390db	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
8e7c45f3-de72-46e5-99bf-db295719f8d7	c3c2f1ae0f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
3b1a311e-ff05-4b23-97cd-4ed8d89ac711	90419dc622	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
4e4fe40a-e5a0-4de2-bfcf-2791ab5a6e02	723f48eb0d	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
ecaf4f81-36c5-4a87-ab1a-f424841848f3	ee1c7e02e1	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
64aab6f9-e374-4194-8bb0-4ee0810de635	247d0afb4f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
87aa75e5-83b1-465f-b6c2-fe1d32374156	802d8c9a0f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
38d3c6cd-57d3-4618-87ba-daea92fc9901	f6be938f09	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
b02b7c81-00e0-4a5e-9dec-bffc9601c6e5	60567cb87b	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
c4beae77-da42-4db3-bef3-ced0ee507a1e	5d40a89811	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
733b0a16-e360-423c-b1d6-3ea257ba145b	aa0802e3d6	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
2e926c83-b854-41e8-8d14-0dae34534181	f0b53ea639	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
2c7c1a7b-2bfd-4c84-9279-85df3d1b0f2d	7ceeff9e85	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
37f2bc68-341c-4d9c-9243-6c1ea6d64765	911c8a841e	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
c6f553f9-509e-4d67-9312-2a5b6bcc478b	3875d44e33	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
4e506f21-3f2d-470d-b46c-fc5ba0fb2a85	b08550b5b6	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
dc0f7c08-aaef-4d17-be4b-ce55bbb935b6	e5c5cea31b	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
1f3f042c-932f-4852-8d0e-fb2355e6a297	224a0c2d22	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
6cbdc3a0-cc42-41bb-9110-1136a6a8dbf0	6f1e8a9425	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
8710dfe4-d260-490a-8d45-86642513a796	441276b3d3	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
9e933825-a755-415d-8cf0-a402ba7673bc	b32b7a0dc4	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
6151418e-828b-4b0e-b730-34ebc2a3a5c5	15b6baae0f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
7b4df624-c600-442f-9b01-2a850d7fab9b	e89548c5fd	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
790e7ea3-c71b-41c4-80fa-dda7dc6ffb96	8594d63850	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
fe369498-5b22-441b-b7c8-6977a4757181	1b96bcf72d	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
49ee52d6-d80d-4187-8b25-86605085cce9	91fdc0e393	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
0e9fd725-9ec0-4ce5-b245-5ab178b81f22	e16bbc3bdc	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
e384a1bf-ff08-45b4-aa9c-6c7dd4fc8fe9	c57cd76b22	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
6834b9fb-7b1e-499f-8046-fb31be86e660	971a32d899	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
bdbd7a33-253c-4c0a-a9a5-ba914d71e994	bf0a00e4a2	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
34929b48-e8c0-49e8-a883-f8747c93da35	19cfe90460	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
3bea8d59-8e8c-49c5-a337-78e2df7aae55	09e368e855	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
c9dc9338-3abd-48ef-9f84-feb76b96ae01	a030955692	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
d9eab3fe-1592-4a8d-b548-a18f19ea567b	b95fd95fae	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
7ba8980b-9537-417a-87e5-217ad7623790	bb841b645f	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
dd877e5d-ab97-47b1-b865-b579e9d7773c	f441c8584a	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
91bba9e0-30fb-4ce1-8b8f-3bb4a4479518	7d29fd9233	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
fc54d310-b045-48b5-8170-95dbf8557a12	e0c0dd35db	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
7bc02eeb-7815-40c6-b9f5-9d7cbcd61898	1132e0e615	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
3da97172-a1ca-4280-b576-fed6a62e73c3	ec1294a667	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
0b1cd9dc-ef62-4431-b12a-d879bc4bbb98	44e4a64386	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
746d0f1a-8637-4a1b-a31f-95a2efc6c7ad	1f17d0d979	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
2386951b-5acf-44df-a12f-4d80fa64eeb3	fccbf4519a	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
757fe285-dc17-42d3-aebb-dddcaae46c02	84dd70db26	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
eafb55e5-027c-4fd8-bb84-e6c75db59562	9e834f4837	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
068b4a69-38b5-4c33-b6c1-051a6b1d2dde	0b6c806842	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
ce881ee3-f7d1-4a80-b0a6-8328a0e9d5d4	19b72fd6a7	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
e14142ba-63f7-4f4f-89a7-38fa57ae3427	f37ab5f126	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
90e9285f-ffa1-41f2-bbca-8ca3967bba35	50e1184bc3	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
2e0bd625-81ec-44c7-b46c-886803dd3e89	b4f5326c70	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
55581874-81ab-4341-80b4-bce4088fbf78	8803618d99	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
606a92a3-fc31-40b8-87ab-158eb5f48141	30b50a79fd	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
702db1e8-36be-4c8c-a581-eca2223a5596	fc24ef12d9	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
1780b0e6-27a2-4fff-82f1-82f1ed5151ff	06fc37b230	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
57da4fc0-36f7-4190-ab66-b783ab3fa267	8850d273d3	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
2e7c5fb0-83d6-4ad0-9aac-3b8a831bb44e	742217aa53	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
8ba3b6f8-a551-41e0-8241-6f807611d541	1003a85883	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
581c67ad-347d-4e80-9479-ada0272ddffe	fa36fb8988	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
9a747c1b-e60f-4020-b00b-7321dabdb865	2c4ca72917	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
54766d4b-74b5-48ce-820b-5cbde18749e1	51a4bd5e2a	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
c2b69935-33eb-4677-91af-68db57c6dfc8	34d056ca2c	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
16ea0f79-85d5-4777-8147-42c252cccef1	246c378d89	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
25df14b6-beb2-43d7-ac87-91847a385786	5ee2d594a3	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
d1670279-ead3-4ecc-aeca-a97964c0caf5	3d1abfb427	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
712ddcfb-46d4-4622-9118-6dadd88d2e28	14d2c711e4	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
adf54848-f981-432f-9fc9-f20e7560b528	ca215d48b8	d87fd59f-5faa-44ad-9b2a-ce67603e9ba6	\N	Ticket for Good Talk: The Brad McMurran Show	default	available	Ticket for Good Talk: The Brad McMurran Show	1200	\N	\N	2018-04-01 01:39:46.659782+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:49.17099+00	2018-04-01 01:39:49.17099+00
bd053377-0971-454b-820a-7f5d68934e76	09c54ebd2c	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
6c804476-ea2c-481b-a906-333fda5385eb	8d40addbe5	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
08f0ccab-3d91-4e33-ba2c-e27837d235cc	5d0f7bd0d8	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
95b4a027-172e-4f72-909d-65a993ca2f28	3e0cb5aa0b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
b3907bd4-715c-494d-b666-00230860b470	a02536d2a3	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8deb0a36-d702-4d4d-9302-6c4d21ca3112	09d6489e29	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
adfeadf7-35dd-4168-8966-106d6fa8557c	a0e055ab09	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
f125548c-6957-40f3-b21b-46ba8fc16c47	01598792bc	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
bd3ad69a-04f4-4f8b-b3ca-6c8489ddc1ed	48f4f9cd52	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
f9a3f86b-275a-48e6-85f1-d453e31c7a3d	e769360f51	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
ba2f8906-e13a-4016-aaa8-d13575a01ac5	acf9b162c1	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
3adc7d44-3067-41f9-b2ca-3ded60f00770	1b44ecbf05	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
2f15373c-5698-4af7-8125-4d453fb7e287	eade4252f3	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
331a34b0-3f64-409f-ba1f-dac0b4eac401	f0f6ff0785	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
5a102504-71f5-440e-9fa8-b6f890bbdc8f	1ef9a124e2	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
c5706b18-7171-4e9d-a07f-4dc7f0c184ec	570f3d3064	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
a189fcd9-893b-404a-9165-79a226a3cffa	68552cfc8b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8e542d87-acc6-444c-aedf-b764223012b4	ff84e21019	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
3d5fe9c8-d646-4693-ac72-c37f59a31729	01115c0c7a	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
30e65211-dee3-4660-b47b-ab307a6d165c	3c201b6ccf	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
f5e3bb33-6920-4063-ae85-1dd74f18650a	e23cc8bd06	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
521134e9-63d3-4a30-8cec-545d2fa378e1	0f76943462	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
5647dd35-4fb4-4a55-8c9a-70cb05f48c4a	ffe7cf9c3e	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
3c36e1af-ecf5-4322-bc9a-50eaae5610be	505356ed9a	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
cc253bdd-f487-4238-b61f-ce0728efe01f	e003b5ce19	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
e1c5c83a-8836-4b16-a0d9-9a21ea057551	1449c671a4	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
12b4e7a9-03d0-4502-b3b7-b0ccc7803aa7	789daf2317	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
99307487-5da8-4835-88f6-c672df6d0587	1c81c18b35	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
7af92518-2618-4a5b-b3c5-23d990a5cf7b	74c8f921a5	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8f40a296-473b-4ce8-9b6f-79aad808e864	68afa96243	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8346dda2-0c6a-43f3-9958-764d5d3320f7	2efe4d7286	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
4705e550-45f6-43f1-bb73-a2d4490634c3	e4cbcaec70	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
e7cef761-8ba2-401a-9234-e2c23c3651fa	55bf2cb436	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
e93991b8-8ad2-4d25-a4d1-d9731baf0c66	15f0edfcd1	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
2f7dd797-5d10-4482-9d2c-aa03eb2dc46d	3c3997a97d	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
0b5d405a-de87-49a8-80ac-efe9d92f0929	3959f4182c	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
84d7aeaf-5e6b-4acf-8b41-12ac72eca42f	d24b80702e	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
dacdab9b-6807-4a1c-b210-413281722172	263b10fbe2	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8dad48fc-7c2a-437b-bd4f-a59044aefbde	46b91011d0	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
aeec0dd4-3a90-4a85-948b-d137d1d2d94b	11cf5482dd	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
77bc3e94-d16e-47da-b925-2a71ad405a0a	178e80050a	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
578ffeac-0235-4ff3-86a9-7c2fe590f12d	4db161fb7c	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
78d3684c-57f6-4bb9-8931-74d3f2db0e7b	92310e702f	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
c4f88e18-182b-4311-8b38-ff007428f780	649a2ea451	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7d8bc9ef-658c-47c6-bfcf-e4fe68821d19	b6cf511bb1	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
c9732320-578b-4203-a1a5-e946cd348d6d	99785a0fc9	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
fec3fa68-4268-43a1-8879-28670cbb45b7	5587c710c3	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
29398134-6101-4c63-bb1d-301aab5cd2ed	fb067ca485	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
eaebfc21-ae1d-4a9b-a886-a0666cd05f93	2e6904244b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
0d06d6c7-d334-424c-9ddc-4ae5828f7bbf	c8e154afb7	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
bd8d7f7f-fa53-4d76-b38b-9704e50bad37	a3835f0b1e	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
77f1c24e-5412-4df5-b8b2-c44a818fe627	642276fcaa	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
74e42772-bae6-4842-ba2b-04a72b7d04e2	b7aedc84c1	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
42b6fc3f-8499-416f-8caa-69a0ae5609ba	52b425bb8c	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
e8f26120-da62-4815-965f-37b434113022	2a4ba0833f	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
b4c39a03-5d93-448e-9959-a6c812a4e472	e85a09601d	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
734a5af6-3b37-445c-bb21-756c074ae219	d4740ce3a5	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
43dfa044-16d8-41e7-b197-8e90c85a80db	4db143c69a	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
cb01ecfa-9724-4f35-b37b-461e5fa2f9cf	5c28476fd2	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
221a2e00-ebc7-4ff1-adcf-230b94560642	30c3868656	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
d6a6fc84-795f-489e-a426-c42886a97b34	b257cbb031	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
237c1785-e1f9-4030-98ab-7fba27aea959	7a6ba5c975	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
e523bea9-3be2-4913-932a-4dad995b75b2	72e113d51e	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
223e65c8-9678-472b-8984-dafdbf956bcf	fd496db9b6	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
322d5d85-b548-4a0f-9e9d-56147fa822c9	f15702e3c6	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
32254cc3-b5f6-4073-b4c3-49c264515971	df86894ee0	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7a7e6759-6f6d-4d21-91b2-691b511eaa41	4548f59830	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
6ffcbc38-fc00-46cb-9b6a-a4fe3be253d1	168668d97b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
ae96f4aa-9b12-4fca-a9c5-9a7b802b29ba	7182f60771	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7a1445be-5ab7-4d1d-9939-9f9df9c7dfb5	f35d4796a1	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
d05dcda9-71ae-4a34-99fb-58caf6691745	f03ebd7a25	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
4faf509b-f904-4a33-a23a-211126a4fd86	e892a8339c	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
24145e32-2bc2-4336-9bc7-829fa94a589e	f8cd537122	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
e9fe9d05-3dff-408b-a671-c25f55120f50	1d4a7bad7e	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
9f010a3d-f17f-4d92-8975-758631affdfb	283f20667e	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
2f72b379-d925-486c-8dd4-5ee5086b8a76	cdcafbf478	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
01b55f2c-dda3-4c65-932f-fa88a98ddd2d	6565309b12	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
59c2aa66-8230-43f8-b73f-9fb98924b420	d08516be27	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
6265af5b-582e-49ef-9374-9e4c4462fd62	7a90c7e1a4	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
204e9124-d513-4ace-a55e-e6b2676162bb	2406825fee	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
5979f286-7a52-4992-9cce-50df6eac4023	267dc112d9	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
d4dd9cb4-35f3-4b14-b440-5b931cb296bd	692ec5d058	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
0452e978-957d-4f15-ba89-6f6e92c247f6	3ae0a8233b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
38dee253-1f37-447d-ba07-92b20e17e47a	2f710df14d	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
701125d5-b1b9-4894-a89f-1827324bbafc	e17cd752cf	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
859c8595-9701-47f5-9167-78339f4d68c3	1907c055be	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
df537bd8-e755-413a-af73-03156214d384	ba1c3ac7b7	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
74746fc1-050a-4e37-b850-e2b12f26e0e7	c971c11627	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
e0a08181-8d45-4ea3-aba5-2b59fd394b98	638b85e95f	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
3309dae1-a2e1-4a1c-8e5e-cd17f397f7be	dd11957d7b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
cb866d1a-5b8d-49fe-8ca1-cf38aaeb729e	10e380978d	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
53c369bc-68dd-4193-a539-63b9f2b488a8	d705c192f4	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
9d4a951f-c95f-4d67-a20b-f96d815d8edc	33b2e571c6	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
2da8bb1e-9ddc-401e-88f1-df79f1a74e33	3f72765400	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
05900d5e-a966-491a-ace0-9573ac96b57c	67770f623b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
4b376624-1462-4bb3-a4c4-f189d302ad22	bf480369bd	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
5aa9810c-f254-49e7-ab3a-d0a2c9e15545	b92470acb1	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
89ea4c68-498a-41f3-9777-2615357fdfa5	b7376c220b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
fb5b59ba-35d9-4fcf-9015-3257a96faf20	9f7cc67fa1	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
5c568e54-f57e-4672-91b2-cace865e0686	bbd2d6bb0c	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
2e01ae8f-29ac-47f3-902c-c4df57fd9c11	d11d85fc42	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
10b30ebf-6001-4675-8518-3fb0691c475b	0ca0a33581	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
5a66d920-e696-470a-a430-82a938a9c44f	bc0578874c	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
0e082434-ecb6-4310-ab8d-2dd4b8aac83d	cbf046256e	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
354fda9c-1851-472c-b8a7-91ee7427baf0	56f3737f04	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
215251a1-05fc-413f-a0ab-4f7cad348be2	ab3a83f77f	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
4bfe5800-9253-4d7c-a744-b49556ffd6a7	9133730baf	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
43314a81-f8ce-4c77-987c-e7dbefe74942	b4566ad1de	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
dab0f4b9-bbb8-4d56-9fbf-f914e6623a24	a6448db110	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
3b4508c3-3aa5-4e97-88a7-d68ee889764f	5f03d34da0	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7f7854fb-4307-4fd5-8193-6f60ed2a42fb	bb9c98c7f2	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
31ed02db-f2f4-41c3-9e0d-12c2cbbddfba	6bfed07c86	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
1b78d48e-6769-4b46-aef6-8e0c3999228d	859d11e4e9	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
0bb095f6-bbb4-4a7e-93e7-ae8e92178d94	425fe74f64	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
95b8b7bf-a55b-4a7f-b466-08aa9c8b28f7	dae57ea2db	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7bac8f51-54b5-4849-9bbc-fb59a967a633	fe910e7ce4	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
9f5ce1e0-7156-4e9c-805b-b6ca1a8d40ce	a258fa927a	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
9bb1978a-b3f3-4b19-b34c-eed4fc460492	ce7f4daa2a	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
92e32245-2f0b-4dcf-89ca-57775575a92d	3c5c97005d	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
919494f6-2851-489c-8a04-a84b02f9585c	b22f8f5359	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
35a16162-7f4f-4b30-bee7-d9df10d9895c	603095424d	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
6868bf80-e3c2-453f-b1e0-e3a95fd6ac34	ec2f0a6e1a	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
7e9798e7-6a16-424c-8258-57237af78b12	24bd255fe0	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
82a93a32-18c5-4cce-80db-6267d087de0c	31d12ca049	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
bffef143-956a-412f-9b14-fb965ae7d664	ebc54bc74b	447c468c-75f1-49c8-a212-a2a753e693f5	\N	Ticket for Tales from the Campfire: The Improvised Ghost Story	default	available	Ticket for Tales from the Campfire: The Improvised Ghost Story	500	\N	\N	2018-04-01 00:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:51.85051+00	2018-04-01 01:39:51.85051+00
a54e2463-afbf-4971-9c31-3da84ef758a8	eccab25228	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0d1ea61c-e925-4b48-8721-d02b3372be6a	c507267c4b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
8eb14050-3036-4645-9f61-cec3eab71039	a34527dd77	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
2800c825-c369-4586-a355-03079f9ac67a	2c9117591c	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
1c10f5d1-f974-4a98-a576-218aba2d1831	53c93c0f68	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d0f0862a-7fb3-4987-9f4b-7f6191449121	3b9ea45972	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
271cdf2c-bb36-45b7-abd5-9eeb48043ecf	db210a922d	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
7e8e58fd-0383-4612-b8df-ccf8983d0ce8	f2552dc124	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d947f1f5-2556-4843-8782-7c61fc3b2612	564fc7471e	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d3305969-8632-44be-8945-16da9489a2e7	82a2a2c916	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
1dd4df50-d25f-49fa-ac1a-61b4584c8d3d	8c3f41c5b9	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
b2436cd2-ae58-4a07-8f1c-32a5a824a8fe	81121f97b0	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
35193abf-861d-4acf-b7d2-29c0b8951844	53fb2dca0c	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d0857d89-456e-474a-9621-257175a10657	82be641db1	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
bd44a0fa-b99b-4609-9210-cd7065e258a1	64773da52c	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
b4349159-fd1b-4997-b55f-5799481cb7f1	e8989d104f	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
cb84f978-d53a-4602-bb5a-5a89e4f9e273	6de7200853	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0318c260-01db-4cb9-af6a-88440def31b9	4bc11e6dc0	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
56aa259b-ae08-4f32-a208-c1de2a5946b4	51bcf20fc8	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0d50627f-651e-40fd-b081-6ab491fc9e0c	18d0ee2ff9	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
1fc4325c-8571-4c03-96de-dfb4484a7964	4fd86facc4	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d6f08ade-39bc-4a1f-a9ef-29e914a62946	fbc78a6e6e	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0601d1b8-23a9-496a-ace3-6b7e522511de	8a7785ff6f	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
49bed320-7ea0-42ef-8a1a-3d6f1f46e977	0d0c3e58f4	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
e2f5c6ea-97dc-4aaf-b003-ae7706a07a9f	9879fcc69c	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
3230d907-2efe-4ecc-9b1b-da83b8b7ae04	98833041fc	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
e98d8e49-c730-4e20-aa55-b2bb076174d7	552784261b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
63ed0a03-0e50-49a4-9565-0bd93e56431a	fee2292c7a	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
99b299a5-0449-40a5-b156-0e47f5aa9825	14aac87cf9	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
fffd6041-43a0-432c-ba78-522e75a3d87c	4d2b59f78b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
77f52116-a512-4c8f-a2db-7413c386405a	a35acc09c6	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d5184da3-84d3-498f-a062-292abfcc1997	daa7f4c9a4	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
fe99f623-79e7-4360-8285-9a05baa27631	cae1977007	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
98fa0047-c5f4-4e32-b77c-d71f0074ab65	0576463d4b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
47962dc5-c4aa-418b-bbd1-8f97e4876e1a	370703ed62	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
50ddd58f-8304-4ebb-86ca-4d57587d8062	722bf35b26	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
36b552a3-137d-4152-9602-9ccf1cb95345	2efec355c1	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
6f7c885b-86d7-4d9f-b4f7-c7068af191d9	30d5bdd8db	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
ee5e5888-8f1b-4845-af5e-2d797b2e1bfd	e98d2e3d7e	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
64dce365-340b-40a6-8edc-6819d989eb8f	870dd08977	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0c6684a4-59ea-4ad0-8602-2f95dbc2a9de	af67b703d2	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d27c3bc7-2e8f-470e-99a6-ef134a525270	7b7b53ebfd	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
a8654789-726d-4294-af38-41e1dc49627c	862ed578cd	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
e93cc7fa-df2f-4b42-8e19-f03a9bf7de63	e6adba4606	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
e37f1ead-0940-4c3c-b9e7-a5213a138748	3f7437fabd	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
6e89062e-090b-4287-9e5d-42420da24063	6689ceec8b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
250a829f-b7ad-4c2d-9918-4312f4373942	455897aa47	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
7b6dc655-75b8-45fe-9dc8-af01eeb5015a	49e2d50fa6	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
3e41fce9-8dc7-4d9e-993c-a9c80d95758a	65593b5673	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
c491742c-bc48-4157-a55a-6064423d9a57	4ba68b3c78	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
4321b601-842f-42e6-a113-438ae13ad5f5	4180fb3b8b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
3cd03a26-b2d1-4682-99d2-779c891c2914	8a6005ac9e	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
ec6fc0bd-4b4b-40f7-a737-d669fb05d082	3eecdd1325	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
6b47683d-e22a-40ae-9544-e0892b2c46e4	8283378da6	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
da2a7a46-c4fb-4976-8bc9-a97c35794c21	232cdceeae	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
769d57c3-d24c-459a-b652-6f9dbc3c43cf	bf1093efb7	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
785ad5e8-2f05-4f76-bb02-63a72bbecf58	e49ba52bac	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
239b1fc8-424e-4fc7-bead-8b0d86459fbb	ab301a74e3	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
fbcc79f1-bfb2-4a62-86de-08477f37239e	8d4d07761b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
f49ac225-46fa-4c8a-a191-c8f292f84974	8879986970	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
595241f0-0e3b-4923-bbde-2c828a75b2aa	e21aaa917f	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
22acc646-cd5b-453d-986b-d74244f85cc5	4eed431d86	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
2e599740-6d59-4786-ae30-464134a5f0d4	dc7cd93322	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
70bdb2e0-f089-41da-8871-0bfc035bf005	6476ddde13	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
efd0ba17-2579-4c78-8ea1-f1ec5f92f7eb	39a1362e23	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
175d9223-4a62-4393-9f97-295345f625b9	282c57efce	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
b56b7142-76b6-4a7b-a6f1-66bc18e7d4a4	0277b0f761	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
80a06972-c5e5-4709-9775-847a49b58c3b	115b1c18e5	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
c9e1a898-3aa2-4db6-94d3-09e7acb99c6d	626443c1e3	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
816a7c85-edb1-4375-9a7b-a387271e73ea	f14d9be5c7	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
d0c02d70-b4c2-4091-a4da-8f527de82bdc	fd385e74e2	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
e0fc6178-71e3-4716-83b4-737eb3f210f4	c5fbb42a4c	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
815ae258-554f-416a-98a7-0ea255772626	483cd3a749	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
eb8e49ba-49cd-47b7-a7a6-41d15f95d831	63c62ef4ff	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
5b1f6589-27a9-43b5-ab37-182d1802df3e	8056b27d12	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
037c194a-2487-493c-8fd8-69ec39a24db2	d0762623c8	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0d348c55-bce1-4030-8e01-dd3f9b6831e8	547d4fe121	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0ee16bac-9aff-4162-a8ea-380a3af5a612	7efef696da	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
63eb9ad7-5f7a-4a35-9dc5-a985d7b42655	dd5f4d2ea1	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
0a436615-43eb-4b08-9645-06f7cf148cef	6c3f06d08a	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
aefe9862-da98-4626-a046-7947584b3f19	5794d44945	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
18e5837e-251b-4486-99f0-3fbd369565bf	afbb03298b	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
8f159584-045e-4ff4-8af9-604f67f16bb3	100f13048a	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
c22ff770-2821-429a-a150-b037b1366e98	f715c21d7e	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
5c38618a-38e4-408d-8235-299e83867c0e	cd1a334679	d07a5b96-0a39-4277-9e4a-e0737f2b8bec	\N	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	default	available	Ticket for IMPROVAGEDDON: THE ULTIMATE IMPROV COMPETITION	500	\N	\N	2018-03-25 02:00:00+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:54.532819+00	2018-04-01 01:39:54.532819+00
727cbef8-6620-43e5-9104-eadd453a6ece	198f162456	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
44c4411e-8aaf-4dbb-8d81-ce616572a9c0	e7a5772ba3	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ba949695-d476-46cf-b52c-33debd7ce0aa	0822ec9dee	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
646ee8c5-4272-43ad-8c02-4d9b68da8b22	38791f0f4f	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ce10a0fa-44d5-4790-861e-d2e01ee6558c	6331b3a809	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
baa80ae1-241c-4e06-b005-d7b8b7a056f3	6a4b87d205	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
63ff3b55-c8d2-4f91-b82a-7337518b2609	9439057dbb	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
7d1a6812-a8d3-4963-91c5-5f33f3f699fb	bb9a727a7c	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
3644b38e-fc39-4015-8d63-9853a41a0dbc	815b09f535	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
d71cfd98-4bde-4055-a288-ce818eef29c2	adb49018de	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
f10a15f2-3ceb-4d0e-a871-f3165e7a842e	4dad14fa06	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ce542e06-bfb8-4be3-9098-871cf2c6249f	0afc61f768	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
8cc3ebb1-f96e-4720-8198-37a6e2d12c7c	5389ce5b7f	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ece51e21-02cf-4ef4-9fdf-089822e8835e	6d89b129a0	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
b4132d23-35ea-4052-9f69-af95ef2fc892	47795332d4	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
47812bbb-c080-4dab-b342-7a38daaca222	f4b5098b6d	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
5033117d-c1a1-45c9-a07e-6adfb6d92f43	4c91a8f93a	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
6719942e-3243-4dcf-a2b3-dcaaacadf364	7ed5ed8767	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
08d56a8b-62d1-4fdd-b911-a1eab7baa064	a4fb4fc938	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
5381e4f3-3a12-4a29-bcd0-db746729a42f	1c3adadabf	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
d39d0ef2-d845-454f-be90-c57560be3e6e	1e25cf12bf	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
3bb8bddc-61f1-40e5-be1a-ecfb521232c0	4cf82d99d7	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
72f70dec-a4be-4ac1-9b31-eb16044e109e	dd80facd3a	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
8986e432-65b4-42ad-8497-f1dda835411a	6204fec7a7	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
e436fbac-e6ce-488f-9f47-ced3da4f8d2d	71d889e97d	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
cc6ebac2-7ebc-4203-99ef-c1ee1a2f3d7c	479fd0d472	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
75b4b1c3-a42b-44df-b7da-1e708dd9a1e8	55433374bd	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
50eae0c6-b226-4d9a-9046-b751074c0b86	83ae517406	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
38312f63-548e-4129-bfef-8223e8bf3eb1	123db59401	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
7b7068b3-a01e-4619-81d0-99079e112739	2d91679f8c	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
24c478e0-8acc-463c-84ae-0a75bc716cb8	71ebbb4373	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
dbaaa48a-6083-4c93-a253-b8d9e8d64b66	e418b5d7c4	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
1faa502a-f392-4882-9833-93dfbfefd6d1	6457251772	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
68115a5c-59a0-40f1-b24f-5d8f1c332802	8b12036780	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
75501ed5-f166-401f-9ef0-7e01ae51e7b2	e4544dbb2a	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
ad46dbd2-f64f-4a12-b192-ad0fa00df012	9afdaf85a3	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
91927630-41a7-4b64-9211-dd09e5caf021	55bab8ad79	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
9f0372c5-be16-4fc5-b0df-00ca73bb5e70	072e76bbe5	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
28b7dde4-cca4-4d13-be3a-9ef42f0bba0a	33b01ff996	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
5481f977-21ac-475b-bcfb-3bdc7492bf05	68df6dc215	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
a5ba14c8-47d1-4b10-b411-c4e4519361aa	0f2876b21b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
db215e14-c67e-46ef-bdd3-2cae15a9b34a	8405ba84a2	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
9bc81f52-31b1-4ee5-9a9a-e05c8fb4497c	c44027cbdf	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
cd2e254b-a1a3-4d1c-940e-67e4a006bced	d42d1c080b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
68c305d3-ee73-42ac-a491-c847bf2681b5	ee860dd8bf	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
dada3468-60d3-44ee-a0a7-6d5d45f0c1c7	a610f93c04	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
43554583-72de-4264-afdf-8950562396a8	e7895bd81b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
4f7b051e-2f9d-4804-807b-cdc2646d6414	0b77464898	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
def286e3-ac25-40da-ac61-54ae81c513cc	da91e1dd3b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
b4cd7551-7eba-46c4-9131-7c312fc850f5	c6b4629bca	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
ab948d17-b8e9-469a-8a91-10c5ac8c2dad	e5e53a8603	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
d9f5e5d3-c67a-4d1e-ab98-726a0838ea2c	5473d8dac4	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
7ea8fd71-6394-402c-ad67-1de028b8ff18	643e022618	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
bf275fca-7334-43be-89fa-419cc7f93df5	8350bdf9cb	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
58739080-60b0-4dd1-926a-e963108b77a2	6c794a31b4	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
4eaec4fc-a4e6-4c88-976a-ce1a714603de	8d7f70525c	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
7d25434d-2203-4d26-9d5f-c643ea5582b3	555e571793	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
5e112e60-7f38-44cc-bee5-25409e6b5202	88690c0997	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
cca1b925-aae7-487f-a29e-97bbcf20769a	5e1414d646	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
fb9ecf39-cc1c-4c54-9cb5-051be0fd3425	399696bbb2	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
24d9f3db-f3de-4c44-bbbc-7554014042f4	5e611e0f1b	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
3f5679fe-516f-49c9-8251-07070ccd561f	0210c31bab	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
130cf19b-871d-4251-9258-a42946107376	26fc51d038	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
03e4cb06-7429-46e4-b71b-b501387a277d	1389c9bf7f	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
a6c7f1a4-0cac-4c67-87b9-930a1420e9cc	3b967229ee	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
c61f7ad6-acd4-4435-aebd-c81de5c6cd20	682ac25ac0	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
333432f2-0deb-4546-a1c6-6b59073771fc	05583bc3b1	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
b1848063-e814-4ed0-9692-ad5c72134d86	57a3f2460e	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
1c365749-a6e6-483c-acc4-43b45fe68eee	93547ff790	159faf63-a294-4a86-ae8f-ec4e572c5470	\N	Ticket for Workshop: Scenework DNA	default	available	Ticket for Workshop: Scenework DNA	4000	\N	\N	2018-04-01 01:39:54.639163+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:57.128601+00	2018-04-01 01:39:57.128601+00
8daacb4a-4211-4208-b338-1c5822ae3914	1d67e4f74e	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
7f29df6d-baa6-4bdf-b08d-7e0a32fbd0ef	7cc74664b3	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
bf3afb7b-990b-471c-aa14-b433fe496c1b	4e142e2741	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
a5dad601-a08d-45c5-b322-5cc3acee4fe0	8d54ffa0af	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
a9ce1b82-d8a6-40fc-be7a-58ad991ad0be	895a509598	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
75347b1f-7675-49ad-b53c-9216aa3a4465	6c7aed24ef	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
af8f71f0-e211-4d2c-b7ed-767d831a9084	a93ce0ba82	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ce380790-76a1-4a2f-8da8-38c1311a959e	5d40920464	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
0025bcf7-68c5-4aa5-87a7-5d654ddd9fac	44ab75763a	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
3eb1faad-5657-494b-8ad7-b65e224dd8de	bef9f7e689	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
dd2a4354-c9b7-4a63-bf1e-be9b4b5f34c8	9125626436	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
6002e09b-433c-4ed4-85c9-2ec577018f63	40ef166d11	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
86eca330-ac4a-4b7f-8aa8-0e1e68b75352	cff50baa37	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
f5b2610f-242d-4256-9aae-5943c0362e0c	42a82ddc7c	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
b46492c6-e0b9-4b09-aa2f-a161e8cfdf9f	dc811c078e	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
989866d9-5751-4bf4-8bfb-1a772c873ce2	c8d7d2c8ce	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
bf97af29-b77b-4741-8f53-de3c8cb37d36	357c2b3d60	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
7ba063db-b84e-4b9e-95f3-9cae6167b3f0	6c0578476e	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ab457ce9-f9dc-4a26-ad6c-561b5334f0cc	a905f327d0	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
47783ab4-4410-49d5-bab3-c9eec19c453b	acac2257a8	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
95f572d4-ae8d-421b-a4ff-bb6c3edc676e	023a73bc58	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
720055c2-1e02-4178-9e2a-7806ebaf9ef7	f78e9d145c	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
15c932dc-1814-401c-b684-e54ca55550f1	1f631486d9	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
e096cb78-43d6-47c4-bfbf-d2b27b6049fe	75b2ed52a1	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
009a25a0-9393-4135-b655-b49169346c7e	c65d6f2e10	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ae8fa018-64db-4fee-9c74-f20e228c3cd5	254988ba9d	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
a13f956d-b7d8-4293-af41-79a1aa224618	67591eebdb	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
b9c0f946-3819-4f74-b6f9-9beff5b84500	256004f068	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
4e436c1c-965c-4840-b14d-eab3ad79075f	d6fb199935	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
72b5ccf0-2c7d-4991-a1e9-b6d8d239b9ee	c3b45f59b2	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
756f4fb5-6972-4c86-924e-2b3076ead71e	e0cacdf6a4	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
90806cb0-fd97-442a-ba38-7040c97bc82a	79d613afea	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
97365677-4e87-48c0-960e-80b2541eeef5	8e8a706e08	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
2d7535ff-a509-40f6-b633-6e9965ff90d0	000a31662b	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
2682cbf4-073b-41c0-897e-9c64c4711d9b	04d705a7e2	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
8b575ef0-2963-4536-8fd7-d492c36a31fa	07bc211d6b	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
98df8ca3-6f9d-424f-8e3c-fd6b4bd0d272	c72272762a	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
43799b4e-aaed-42db-acd7-09c48c204359	6d83759747	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
f3d7019a-0627-4498-a2f9-9748b2bdba3e	bdd547f8dd	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
a58c100b-9315-4d72-b9fb-c3ba495d75e7	93f01c7f66	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
b378a4d2-9ecb-42e7-bbdf-3c975eec1798	f147287614	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
aaf96680-8daf-42f4-9b01-ac8a3c7bdb38	56d9d68038	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
d0dde604-19fc-4d16-b2df-b06083c3d0f7	88a82f87c2	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
c9878a4f-786d-4718-8039-2a47f3e3ca41	af314ce719	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
073a3768-5059-4847-9097-79b749a47fd5	eccc3fe67f	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
663766e3-a598-4e77-a1b2-6398154da415	297a0b8ed0	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
c95163c9-8b53-4148-9a98-c6e061f330c2	8d701a44c5	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
4b4f97fc-ea6b-4854-b444-da80abdf7f4a	c206264f38	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
2dfa8456-769f-482e-8444-f913aa0ddd07	0170ff3ab4	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
fd7f830a-8afe-4134-9a54-b210be26d9e3	8c2db645d5	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
112a5764-a7d3-4763-990f-272a0583d076	bd8a770cd1	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
fc83fc82-4b6b-49a1-80cd-6d8f211da3ce	c041995247	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
646f8976-03ba-4699-bc09-b904cdba0782	1d5c6c24ee	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
36723d9c-462d-4e01-8ddf-f4df133cf686	f5a68c2e4f	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
309065f8-87fb-493c-89cb-76ea797b371c	6a719d4cb7	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
083facdf-b863-437c-89a6-88ac3657d78b	a514139d75	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
e326cff7-4e9e-44a3-a225-b185f2c9ec6f	38963134a8	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
f3d7ddab-4ffb-4f81-9996-73752fcf6e8d	852cfac655	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
a81dc943-f17c-4316-bea0-6fdf035b5e71	f1050cfbe0	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
dbb583c5-d2b1-495c-bad9-13311367152d	5a7ad20a03	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
ee594ea2-cddc-421d-9679-0070f4678387	d4943dc95f	8fdd9346-b136-43e6-b6db-cd7e097c70f1	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 2)	20000	\N	\N	2018-04-01 01:39:57.238972+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:39:59.727208+00	2018-04-01 01:39:59.727208+00
9e74a3b5-ad6c-4069-8927-06ce124cfce9	ec68946d5e	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6164e5f4-86af-4a3f-bab2-a99d39b54e37	5e1c286ff5	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c1317152-8251-4539-8057-5c9bb859f58b	5c95da93dd	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
34b6f983-ca92-49de-8045-9141207bea3e	d6c6721464	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
7d79665d-b893-48d1-bbb1-23c6289d0336	584ad67840	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
8a83691f-6be8-498c-aeab-fbc4402cf8bf	6bce55bf3a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
b6b17650-a097-425a-9f7b-59224aa0fefb	0b842a7b34	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f0dc751e-857f-40ee-b35d-ace9c7390ecd	1ec359ee4f	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
3ca29cf5-1664-47c2-ae1f-79e852cf6530	4d0f49f22e	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
0cf26e60-a387-4c2b-ae8e-8906810ec32e	5b033202cd	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
d7b6d40f-152e-41d6-8b61-1da107857147	64b4c5765e	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
1ab47e38-2d0c-4734-83cb-29676dd9cc77	af5ff840cd	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
9ed7f696-be34-44ac-8039-87b9755cfe85	d615b7db94	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
84ad9846-eabe-4998-b08c-04591560b48a	b9de28a3f8	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
cc1ad615-c544-43cf-aaae-b164cea1e0f9	082dd2de4d	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
45cccb9e-fa0b-4c6d-8668-9d23f84cf112	236a366182	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
ca467278-1b78-4dab-a37b-d4c6fc9846cd	e44c9d6b66	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
e7eec277-021e-488c-af8c-c8bf08f786a1	6791110d47	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
fc51f0c9-4aa8-4f40-81db-d64b95a48786	4fe3940b28	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
466f4e6d-8e08-4b66-a4e5-b41c869fcbf3	7b9a44b5b6	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
0d06fe6c-7ec0-44bd-bea7-dac214f0bdb5	41d0719c17	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f0c35431-dbbf-4c09-92a7-afb61f1e8132	a21cef8d52	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
0478b806-8591-42b9-85d6-5fc7d5c7a4e7	cc050258c8	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
939c25ed-4731-4b60-bdff-508b82f8383d	6bcbd41025	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
1537c24b-d60e-4f2b-8bff-e945560e15f4	b386b784b4	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f063422e-af2b-4923-b60e-d4c84f7831f3	6271b098e9	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
c204c10f-1525-4285-98e8-57513d7995b9	d6f7a79f9a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f3bbb483-2771-4073-8dad-c7162f60e673	edbb8b3ded	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
4bfb59f5-2814-4124-b3c4-149eface5bb3	94cea8a483	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
6ee30e51-072b-46ec-b909-caa459568fc2	7fd38b1fc5	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
0e68df89-2705-4b3c-acc8-505f8c0d019a	93ad758336	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
8078891e-d42b-48f3-9a65-3aeff18e4a01	5dcbd983c0	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
ecd37192-a72c-4fb7-a65f-7d0040b72d6d	f9ad092830	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
20769688-55ab-4c03-977c-820f880ae6ec	45bd6a12bf	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
eea7cac4-6e68-40d9-9c21-8083f1815f2f	02caf4d93d	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
30a3b2f3-1bcf-4423-b769-32e828d8cb7e	c6b5e263f3	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
e6a0a064-b585-402b-a2eb-e384117685e4	9068774127	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
27291883-f101-4af3-886e-7770a1a5b334	e76cf07120	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
6e987148-5b12-48c3-a68c-9fbfc9a7b4d0	b5e72ad321	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
14f29213-2b2c-4239-b701-d4b7bfd093b9	15688cd208	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
e4014934-e340-4054-9263-c6d7a9cd54f8	a3e3dff61a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
662cf7c5-1858-4de7-8476-59586202618a	03b7f535ac	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
5a37d1d1-db70-40f5-8340-f0a5350509c3	014b3a03f0	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
c19958a5-e8f7-4fcc-bf84-492bba79a74f	f260606408	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
492c325b-a7d4-4e3a-b13a-501e5dfaa5e3	d3d824f6bc	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
1dad379e-119b-496c-ac48-d5125520bd96	344346a1ea	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
c45dcad3-bc75-4427-80ef-f6d70afd52d7	94ec103a24	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
05ff6543-ccd2-4e41-9e4b-8a69fcbfea76	392ea2cc2e	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
aa9a3bf7-cb91-4a7b-9105-247df3f64ce5	9cd1641f9d	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
4f64cb47-4d31-42eb-bacd-c2021f1261f4	3fccab19a9	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
baf09cf7-3c3e-4d59-b027-59a6ccaee4ce	cd866970b9	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
829e016d-cc69-4d73-9aec-878b5004ce82	4156075cdc	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
8ece4eb7-0daa-4d76-a6e3-9630f1bc568f	6345c84467	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
b2e3fa06-4240-429b-9e27-569bde94da92	464bdf24e5	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
ee90d3ab-695d-4e9c-aea3-1a860df59565	4ccc485304	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
7319610b-a125-4322-921c-668afa5d717e	1928b299e5	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
204c952e-055f-4d70-859f-568a64db9ff8	e73b540c43	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f7ac0786-5a49-4548-a9d3-707b1d2fdf51	2e0b13eee8	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
4e847370-c6de-4c29-95c6-fd0418bb229b	bcc258f66a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
d9c0af05-a303-4ca1-9799-0c84d0896f28	e0b38a856f	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
ba4d329e-50ac-40ef-952f-2c6d824c63b0	f4dc2a0f8c	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
9275e001-22ce-4662-8e98-22980ebb5cb5	91b7455701	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
89324468-098e-47a3-a1f1-0cfa869abad9	98ef53a0a1	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
e2cde58b-7549-467b-a081-9d51a0838454	92e5b023c3	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
e6e01f7f-14f4-4546-87e6-4c2b6365f6a1	414e87652e	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
2ff1adfb-884d-4828-9600-6be26ac1f826	ac12bff8c2	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f13a2788-25dd-49e5-8100-0fa9517ecdfb	868f3665b3	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
898408b9-a186-4d85-b581-06f9ed4b8c93	c0c8e01ee5	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
da736329-543c-409f-8dcf-094c2a526731	897a0c960c	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
6716bb5e-794d-474f-8e61-730a977cdefc	48d0bbab69	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
a474f2b9-b5a3-40b3-b29b-cbc0300e7506	6468f40d75	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
236fe3c8-9b4f-4d5a-aee3-bd7c82427efe	fddc6d840e	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
86511e4c-099b-41b5-a623-4a75451fa491	757899c061	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
d7100314-413c-4a4a-a35c-7241ae3d6f60	500791dd60	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
dff2c65b-fc1d-4b60-b38c-360dc2510eb4	5a12f31692	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f705b63d-b878-419e-82f5-5c438a0214b6	0922bba9fa	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
30600592-cea5-4b14-ab34-87986ca83ccb	27b17606b6	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
a1bb361a-17a0-43b0-b6a3-a7edd7bfbe31	6a53dfd6f5	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
47f66585-2235-4e14-b622-bc7db86ac159	50b26a8b62	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
d11478c9-3796-4094-8d57-5c03764a09a8	2da78ee8c0	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
7ac0dc21-58cb-4ada-a692-35d0502f788e	507dc0b8a7	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
bc86dc3f-d491-4173-bdbe-7ea40f690301	1cbdd2af74	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
aa93be47-0d95-4a7b-b545-96d10c86c1c5	30c794ae8b	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
4566befd-154b-4dfd-ae66-1ac9f76d81c6	00b39ee980	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
23853ef3-15c0-41ee-9357-8fe6830f5d9c	292b9b3575	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
482114b8-e43a-48f7-8543-afb11cbc983c	5e0816b88a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
46c8cf0a-ed8c-4eaa-8082-033a32891a79	2a4f2b522a	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
d5c10cd7-39ba-4e3a-981b-984fb6edcad0	8a4e37bff7	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
f36a5d83-1f96-4cef-a16c-f8d01eea8b4d	52558665bf	73c11902-a9ed-4325-bcc7-9132e1b34d3c	\N	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	default	available	Ticket for Teen Improv and Sketch Comedy Summer Camp (Session 1)	20000	\N	\N	2018-04-01 01:39:59.83391+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:02.325247+00	2018-04-01 01:40:02.325247+00
90a457b9-8627-43d9-b720-956f816972b0	b7a1eb0be0	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
39978d1e-0a32-4f4f-83a2-8cd7bd6a99fa	4b6a03c953	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
5ab272ec-c886-4ca9-b380-9fd94288a3c3	6f4c49c1df	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
82657487-7156-478b-8c91-4e4e209cab89	cd02397ce2	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
b68b1791-e727-42b3-8734-45c8a75b0dad	d67b4f02a9	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
1d6c0f6b-0c59-4822-aa49-0baf01ce7bbe	02bb678d16	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
13a743e4-aabd-47c8-971f-a4a2cac55552	5a00e3a53d	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
3d12a5ec-d068-468a-9067-db7843e5384d	3b27c165b4	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
02d20c4d-578b-489a-9cec-ba6877b396ed	2c00acfaac	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
ecda5b38-d3ad-41e4-b490-96a8be195e60	13f8f5b73c	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
33b8c041-b968-49fe-8c42-e7feb472a72f	93b24ce337	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
d48edd37-ff01-4e37-aac1-f7753729ebad	c889b040e2	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
24f56f2f-4125-4b18-97b4-cb1ff8161e0f	84ad00eff4	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
991e9855-c7c1-4793-93a7-2651620b29a4	ffdaa62d3b	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
8c43e9cc-c61b-455d-b541-9346dd44dba3	4b90e4c846	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
7b0ad992-de8d-4b94-8a84-47485f0e6c96	a45a8c4af8	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
dbd9c4d6-b907-487a-a2fb-40199d70f284	258b2fa515	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
0ba640bc-d590-4b3b-b3cc-16d5f7c85375	5eb9eb451f	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
fe98cb59-54da-463e-92d6-dd835374e089	3bdee767f6	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
9de100fd-9117-4fb4-bbb6-6895d5552988	4485a08921	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
af7f54c4-4a13-4d58-81a2-ae620ba0ed32	ac295b28cf	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
d4701b1e-4568-486e-a80e-867a18fc9ac5	bcdbdcb973	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
4d040446-452d-4758-aaf2-226ae19db2dd	9619a8ceaf	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
d213896d-ba3b-4f68-91f2-c4ab97356bf7	3a65319479	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
60c22e10-46ca-41dd-8c09-79df87daf271	8da939d97a	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6aa01328-cb08-4211-badd-c14c93587e61	725b6e3a73	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
8fd88438-8017-4a27-9571-a709b45c5746	8750ccd9b6	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6bd69f5a-4528-4f29-a9b0-cac731ad12f1	33f3a73daa	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
462c49fd-b779-47db-99e2-3042d47d6c53	e383745b87	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
9f420aaa-795a-47c8-8e12-8fc890c72f49	6a0098b981	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
21184e03-04ff-419b-a648-cc4bf9c957bb	144c8102e1	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6a5ff9bc-e18c-45e9-8991-5ff3ead39b51	a76e694a49	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6392f75f-c95e-45fd-a22c-2c315ce10149	919060c570	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
3a329cef-c2d9-43c9-a9cf-2384ba7209d2	a226fdbe34	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c2f3c455-bd87-413e-9abc-cf07aadba5bc	5065c190ef	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
274d4084-8ed1-476b-b54a-41d8ba1cdd83	b40d6cc35f	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
1afffb06-cef6-4445-9581-d772daafd615	b67386e692	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
8b0543ce-93c7-44a4-96de-f341830ca385	a74c0f0e92	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c10f8f99-4b41-441e-b57e-6c481590fba6	da9abbabee	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
fb033a03-3e6a-4570-9eae-bd5705da841c	9d6ef57845	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
52516f9d-2a9b-4881-883c-ab9d0df6e08e	d2ffed2510	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6f4df48d-1f12-4d4c-9e3c-c50a9e335590	acd89a9836	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
03750c7c-bf37-46c9-b579-c0b46362a499	b55bd4eae5	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
83da4bc0-2fc0-4319-923b-5063e2b00255	a3c43c7dae	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
b8d5c45c-9eeb-435e-a300-d9cbe6be22f2	4eb57bbd44	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
ed5d06e9-ff94-4dc6-aac7-7924a96d4f74	d00eb766e5	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
198b41d3-8893-4309-ae3b-c2c3e63363a8	2f5a7d9057	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
f41bd879-a268-46fa-8c71-1f2cf0aa471a	7b82c50ea3	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
ce541398-deaf-4fb5-b1f3-fafdf6a854d4	b6f05bbc55	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c44138b3-b986-471c-a407-39d81239c688	8ea67e5a9e	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
cc1c794c-6ecb-44b7-bbe7-ac5d51041338	3d464a32bf	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
db0c1660-74c6-4aff-b7ed-a5c801f4d7ce	83e21ac897	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
8c576ce0-f3d6-405d-9b51-79a6f739dc41	67fb671e6d	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
dfdd563c-d55a-401e-b598-91a7eeb5417e	d6ade90aba	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
935a0a7f-b8be-425e-bc5a-d858d3ccb52f	5f18bba4ff	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
e1b12d34-81b9-4507-a84e-66d2809fe00f	991686ae70	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
4eac8679-79d0-46eb-bcf0-da5b76af085f	3610e7be35	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
d71369d2-3112-42b8-a427-0c5e08fe3aef	81f6520864	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
9238b09f-2b9e-4ac0-9042-980dd42cd6f8	d4eec7c9d6	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
4c85b6f8-09b5-467e-a5b2-6ccaaedd25cf	d0b4b1e569	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c283c2b7-c48e-4281-9a41-22e4a69466a4	ad32025ff8	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
2daa8f5e-8e3c-422d-a20e-afe80ea0b228	b3dc38ab2e	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
75399ab5-e51c-41fa-8096-ae5a5dc9c04d	96da6204e2	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6f4638bc-06c8-44b7-b0c4-57293fc2937c	8f33fd2c81	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
ed4c433e-394c-42b3-ba41-c7e48c895881	d1b06584e0	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
c3ce12a7-eb68-4667-a8be-649dddf4bb70	197ded813c	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
155ac884-5e81-4a54-9c18-87c01768b779	3aa91439f6	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
1f801da5-576e-43b0-8e8d-bdef574154b7	a03cf16a37	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
87e349e4-4056-4135-bc32-f18fe54bc459	abed41f4fe	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
08d668df-465c-41f3-84dc-726d7fa40d0e	f5c01fd4d5	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
58dfca5a-0faf-42a4-baf2-025aacac6a13	b26f0d8cf1	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
f4bd79e7-2e32-440c-bfe5-98c208b9da21	4ab8ac4194	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
7adda8d5-ac7c-45fb-9e3b-af9072cd4128	1de9b3f120	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
9ec2ce93-626e-498a-91d8-d0c63510e9a1	99b7f2f074	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
6c28fcd4-72ab-45b6-af63-d06f0d710763	1f026a8d7b	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
ea491bd5-a1cd-402b-bdc5-3ed714a089d4	5676fbe707	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
e7093121-e67b-4615-8899-f7ae7ce7e4a8	4951160610	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
1893445d-857a-4782-9287-be4c3f1e7f4e	e01f404b54	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
dcdd0154-734f-4983-8f09-3ead9a6cb55c	9b2f25947c	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
eee71124-04d4-465d-9735-d9d464ceb159	9a91571950	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
eb4c838e-8ddc-430b-9ea9-ec77d08bf2bf	f5ee4894e6	9fd41ae1-26d8-4b49-a3fc-15207fb34620	\N	Ticket for Pre-Teen Improv Camp (session 2)	default	available	Ticket for Pre-Teen Improv Camp (session 2)	20000	\N	\N	2018-04-01 01:40:02.430911+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:04.98551+00	2018-04-01 01:40:04.98551+00
b7740a3f-f8c3-4dfa-bfa2-0a10d69608c0	ac0ae8ad72	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
38cd3b08-4244-481a-9cc7-4839c802d5ee	f6f241522b	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
65eb3e12-af74-4395-b4e5-0f0cbadc8a8c	c7f7c3e0ca	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
2060ee25-63b7-4d5d-a9d8-670a71bfd91e	a2b88956f2	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
c150dff0-1908-49ea-8938-3f23349ddb8f	b512f78033	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
879bcbd4-043f-4da3-a9a4-5f5558e01b48	09f14ba3b4	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
911e0aaf-ea87-4b1f-a608-adbf60220e37	fc4f58f183	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
f157b415-a750-4895-8687-8c7911c5849c	f2b9346fa1	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
9394e79c-94f0-43fc-b4e6-70375737bf17	f878be264e	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
af95b632-a9f5-4763-b587-dfcc4e971f3c	e5d52bc4de	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
f77507b8-fb2b-4870-93ad-72e19a0ae802	990a11c21a	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
535f163b-64c7-4188-95f1-0a1745159f8c	70552a3ca5	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
4d568bf2-0f8a-432d-bcfb-0f52605df318	352a98c169	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
9d0f84ad-707d-4232-8a32-8601e0693725	fd84066f5e	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
55898981-27c2-4d9c-8bfd-d90ceb40a025	299c137fce	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
82bfe4ca-2a58-4b98-9ba6-fed4415c830f	22a02f05aa	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
bfdd3231-9eb4-4ebb-81a1-c3e2cc0caba7	aeae3437be	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
a7172dcd-d561-42d5-b87d-0e7a3a0046e2	2e9c97f427	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
e4f8b2e8-dc31-4faf-9ea0-b0e8f528793d	9cbf0f5bd5	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
ca7eacd1-b972-419c-ae7e-e3f33cd5fabe	e5bcfd6533	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
89b33eb7-01b7-4f36-a5c6-584a8bbcc9f5	73ef43d30d	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
4202ef62-a7ec-49cd-9f0f-63312466c336	a875feab2c	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
edeace09-9396-4e7c-816d-aec9dbded9c6	a54cdeca5b	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
a97ca769-5af7-4f7b-bb7a-5dfae5ec8a20	bd3b993501	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
7d3df43b-fe09-4d34-a121-4d9fd5230912	9d596e053a	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
6ebfc449-09c4-402d-8aab-e913541d0de4	8bd9416f30	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
b0c2699d-b373-4611-b8b8-09498295bd7f	051d1aae34	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
3b55010b-15b7-4957-a145-3f114dd634f7	053e370512	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d0cd6a19-eaa0-4be5-bd16-c9d5259c3a5d	20b1824c93	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
725f791f-3cc4-433f-beee-abe9fcad2a20	c0c5f5c680	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
682670b8-8897-4af2-8db7-a39323ada319	fcdf483668	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d972fee2-d409-48a9-b02f-b58dc6e6f723	4dd9fce319	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
987e2a65-ffa5-478b-9ec7-3631dcbc3cfa	810c931963	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
edd5bd7a-5c49-4912-acbe-923c849c2f2f	c3ae91d814	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
1af068a7-62de-4db3-93cb-8598ad78beac	53782ea754	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
33267960-0de6-4b0b-bc8c-cbc372a8dbee	56b7589f92	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d5a7e455-a5ec-45bc-bcef-ae160741c1df	c624f8294a	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
0c91a22d-7cef-4e43-a6ed-dee9a93c666b	44caa8ab74	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
f971730d-391b-4a99-a9f9-389adbd4e78c	7f78f0d8aa	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
7966f899-e419-4d47-a115-5ac2cbdc08fc	4649e717f1	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
ca122871-0f97-4302-a9c0-8b6c8fe2c3e2	3c78f21451	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
331d0d91-b20d-4e1a-a968-1361adaa5248	4a722dfdb5	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
dbc2d0ce-0880-4ec6-9301-32670ccb24fd	0468c89e97	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
0333d924-8df2-43c2-971f-ca45042821b0	78d457e1a3	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
8f29ea60-25c4-45f5-aaad-60740d8afed8	73612c8d04	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
6e79a75b-47cd-4d37-a0ca-f2b15fe9c00e	2cf0066574	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
8d48e99b-4382-41f3-8716-133b5f2cb626	4e0c7edaff	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
e7aaa938-9d58-4515-88cd-0314aea62e3f	73073922c1	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
271f952f-50b9-4dcc-b405-bef7b01df4d3	8de475cb67	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
db1846c0-54f5-4bf8-a824-7b5bebaaa916	f9a9d6c5bd	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
32490e33-1167-4cac-bbd1-9595cc67597a	c4873ee21f	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
fc7d6a23-0feb-4e3a-80d2-657347480d3d	ae6b98bedf	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
620afc39-9392-4fea-bf21-18caa4ad6891	7f341bc78c	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d25abe3f-585e-4b27-9692-a0c564ad95d7	0f8ae060d6	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
68eb4105-9819-48a1-b0e9-5870691050bc	143c0d93ed	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
479c20da-ccac-4f3b-84a0-d2101f084bb7	1592a13581	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
79f40884-60a9-402b-b89c-c9ae7f87fa9c	7628e73cef	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d942a71a-62ea-40b4-87b1-dfb974c09827	2eaf691280	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
01c55f4d-2a31-4662-9b44-625cf9fe67f5	9313d10000	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
f1e29952-4f42-4bcb-a3c5-8eb8cb78abf0	60d6da7724	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
92b6bd95-62ed-430a-a55e-dbba9c48c22a	3352b4e5d3	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
320d9e00-5428-41a0-a73e-d5ee52b96eaa	7a02812a02	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
95379664-185d-4432-9409-713b279fcdb8	3471f063cd	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
c4633fe5-c067-4f62-ab42-ad21824911c3	d277e8c419	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
b0fe3bcf-45e4-4cb5-936c-ef773ce4657b	d7c9371e68	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
c1e82921-c641-4374-af85-69e18ecc5490	605544be00	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
02015916-baf0-4566-b048-ccd2b1cb0382	9f63ac2fed	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
d4a2a6fb-68c4-48f5-8330-cf6ed2ff54c4	761daaf7bb	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
1dd07934-0024-4910-b422-4b4ecba892ed	0555e220ba	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
1913484c-b728-4bed-af24-cc148f9a5136	d51fbdb75f	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
51dda3a6-2e05-43b9-8aad-b029b07cdbc4	c7d6e98280	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
7603673c-3731-4fce-bc64-4bb0f46ef829	16866263d7	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
ef586aa2-d657-4f68-a264-47f00a1df794	5950dbb04b	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
a100be1e-2d34-4ee9-ade4-39b87a25821d	93be768706	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
a916546b-c536-4ce0-918e-4f340909ba42	24c22743b5	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
e9e33232-8a0b-4f29-b207-d80ebc6fd684	d944345c4e	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
fc7f6b09-ab76-4099-a636-67e1e534f998	3bf50fd736	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
54ec9215-fbb7-4762-825f-c77e81466487	609bb8b4f0	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
41cf9a7f-aa4c-499a-8a23-c33ed94192a9	adfb956e84	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
02322f9b-129b-41db-9ba9-be151b29da6c	5ef19bf466	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
3e379473-d825-45fa-8fca-11c41d72c034	da701cade3	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
82701055-6ae3-449c-9217-28713cb45014	2ed5c0ab92	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
5647089a-e8d5-4378-9429-ae6fb75e5152	9e6f8df64e	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
75c14c99-94c9-4228-9d95-10be4b13f957	07ac0abc10	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
53b1b727-f645-40e1-b348-4870512cb25e	15362fd52a	ae5321e2-e447-4ffa-872b-159623ffbbc9	\N	Ticket for Pre-Teen Improv Camp (session 1)	default	available	Ticket for Pre-Teen Improv Camp (session 1)	20000	\N	\N	2018-04-01 01:40:05.102503+00	\N	\N	\N	\N	\N	\N	2018-04-01 01:40:07.656398+00	2018-04-01 01:40:07.656398+00
\.


--
-- Data for Name: user_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_credentials (id, user_id, provider, token, secret, extra_details, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, name, email, password_hash, reset_password_token, reset_password_sent_at, failed_attempts, locked_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, unlock_token, stripe_customer_id, one_time_token, one_time_token_at, inserted_at, updated_at, account_id, role) FROM stdin;
952c3e0f-0886-4248-97d4-8f56d01a037c	Patrick Veverka	patrick@pushcomedytheater.com	$2b$12$syDbeg6EsgH.6Xlzd4y3/eTr9J3I1GQjv0ogTH5AAIa9Sneoheoka	\N	\N	0	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	2018-04-01 01:36:38+00	2018-04-01 01:36:38+00	3601266a-808d-4153-be01-ff1577831f5d	admin
4fed3926-fd19-437c-897e-959af61db9d8	Patrick Veverka	concierge@veverka.net	$2b$12$edmiVWIEG5NwGvvCOwuYo.qCY6AjwsNVebz/8F/sJ7yp7EeuNDXTK	\N	\N	0	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	2018-04-01 01:36:38+00	2018-04-01 01:36:38+00	3601266a-808d-4153-be01-ff1577831f5d	concierge
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY versions (id, event, item_type, item_id, item_changes, originator_id, origin, meta, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: waitlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY waitlists (id, listing_id, class_id, user_id, name, email_address, admin_notified, message_sent_at, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webhook_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY webhook_details (id, source, request, inserted_at, updated_at) FROM stdin;
\.


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: credit_cards credit_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY credit_cards
    ADD CONSTRAINT credit_cards_pkey PRIMARY KEY (id);


--
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: user_credentials user_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: waitlists waitlists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_pkey PRIMARY KEY (id);


--
-- Name: webhook_details webhook_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY webhook_details
    ADD CONSTRAINT webhook_details_pkey PRIMARY KEY (id);


--
-- Name: accounts_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX accounts_name_index ON accounts USING btree (name);


--
-- Name: available_tickets; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX available_tickets ON tickets USING btree (listing_id, sale_start) WHERE ((status = 'available'::ticket_status) AND (locked_until IS NULL));


--
-- Name: classes_prerequisite_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classes_prerequisite_id_index ON classes USING btree (prerequisite_id);


--
-- Name: classes_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX classes_slug_index ON classes USING btree (slug);


--
-- Name: classes_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classes_type_index ON classes USING btree (type);


--
-- Name: credit_cards_stripe_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX credit_cards_stripe_id_index ON credit_cards USING btree (stripe_id);


--
-- Name: credit_cards_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX credit_cards_type_index ON credit_cards USING btree (type);


--
-- Name: credit_cards_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX credit_cards_user_id_index ON credit_cards USING btree (user_id);


--
-- Name: events_account_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_account_id_index ON events USING btree (account_id);


--
-- Name: events_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX events_slug_index ON events USING btree (slug);


--
-- Name: events_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_user_id_index ON events USING btree (user_id);


--
-- Name: index_locked_tickets_by_locked_until; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_locked_tickets_by_locked_until ON tickets USING btree (locked_until) WHERE (status = 'locked'::ticket_status);


--
-- Name: listings_class_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX listings_class_id_index ON listings USING btree (class_id);


--
-- Name: listings_end_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX listings_end_at_index ON listings USING btree (end_at);


--
-- Name: listings_event_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX listings_event_id_index ON listings USING btree (event_id);


--
-- Name: listings_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX listings_slug_index ON listings USING btree (slug);


--
-- Name: listings_start_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX listings_start_at_index ON listings USING btree (start_at);


--
-- Name: listings_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX listings_user_id_index ON listings USING btree (user_id);


--
-- Name: order_details_charge_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_details_charge_id_index ON order_details USING btree (charge_id);


--
-- Name: order_details_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_details_order_id_index ON order_details USING btree (order_id);


--
-- Name: order_details_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_details_status_index ON order_details USING btree (status);


--
-- Name: orders_credit_card_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_credit_card_id_index ON orders USING btree (credit_card_id);


--
-- Name: orders_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orders_slug_index ON orders USING btree (slug);


--
-- Name: orders_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_status_index ON orders USING btree (status);


--
-- Name: orders_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_user_id_index ON orders USING btree (user_id);


--
-- Name: teachers_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX teachers_slug_index ON teachers USING btree (slug);


--
-- Name: tickets_group_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tickets_group_index ON tickets USING btree ("group");


--
-- Name: tickets_listing_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tickets_listing_id_index ON tickets USING btree (listing_id);


--
-- Name: tickets_locked_until_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tickets_locked_until_index ON tickets USING btree (locked_until);


--
-- Name: tickets_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tickets_order_id_index ON tickets USING btree (order_id);


--
-- Name: tickets_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tickets_slug_index ON tickets USING btree (slug);


--
-- Name: tickets_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tickets_status_index ON tickets USING btree (status);


--
-- Name: user_credentials_provider_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_credentials_provider_index ON user_credentials USING btree (provider);


--
-- Name: user_credentials_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_credentials_user_id_index ON user_credentials USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON users USING btree (email);


--
-- Name: users_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_name_index ON users USING btree (name);


--
-- Name: users_stripe_customer_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_stripe_customer_id_index ON users USING btree (stripe_customer_id);


--
-- Name: versions_event_item_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX versions_event_item_type_index ON versions USING btree (event, item_type);


--
-- Name: versions_item_id_item_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX versions_item_id_item_type_index ON versions USING btree (item_id, item_type);


--
-- Name: versions_item_type_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX versions_item_type_inserted_at_index ON versions USING btree (item_type, inserted_at);


--
-- Name: versions_originator_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX versions_originator_id_index ON versions USING btree (originator_id);


--
-- Name: waitlists_admin_notified_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waitlists_admin_notified_index ON waitlists USING btree (admin_notified);


--
-- Name: waitlists_class_id_email_address_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX waitlists_class_id_email_address_index ON waitlists USING btree (class_id, email_address);


--
-- Name: waitlists_class_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waitlists_class_id_index ON waitlists USING btree (class_id);


--
-- Name: waitlists_class_id_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX waitlists_class_id_user_id_index ON waitlists USING btree (class_id, user_id);


--
-- Name: waitlists_email_address_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waitlists_email_address_index ON waitlists USING btree (email_address);


--
-- Name: waitlists_listing_id_email_address_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX waitlists_listing_id_email_address_index ON waitlists USING btree (listing_id, email_address);


--
-- Name: waitlists_listing_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waitlists_listing_id_index ON waitlists USING btree (listing_id);


--
-- Name: waitlists_listing_id_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX waitlists_listing_id_user_id_index ON waitlists USING btree (listing_id, user_id);


--
-- Name: waitlists_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX waitlists_user_id_index ON waitlists USING btree (user_id);


--
-- Name: webhook_details_source_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX webhook_details_source_index ON webhook_details USING btree (source);


--
-- Name: accounts accounts_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: classes classes_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: classes classes_prerequisite_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_prerequisite_id_fkey FOREIGN KEY (prerequisite_id) REFERENCES classes(id);


--
-- Name: credit_cards credit_cards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY credit_cards
    ADD CONSTRAINT credit_cards_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: event_tags event_tags_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY event_tags
    ADD CONSTRAINT event_tags_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);


--
-- Name: events events_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: events events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: listings listings_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_class_id_fkey FOREIGN KEY (class_id) REFERENCES classes(id);


--
-- Name: listings listings_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);


--
-- Name: listings listings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: orders orders_credit_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_credit_card_id_fkey FOREIGN KEY (credit_card_id) REFERENCES credit_cards(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: tickets tickets_checked_in_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_checked_in_by_fkey FOREIGN KEY (checked_in_by) REFERENCES users(id);


--
-- Name: tickets tickets_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: user_credentials user_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users users_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: versions versions_originator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_originator_id_fkey FOREIGN KEY (originator_id) REFERENCES users(id);


--
-- Name: waitlists waitlists_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_class_id_fkey FOREIGN KEY (class_id) REFERENCES classes(id);


--
-- Name: waitlists waitlists_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id);


--
-- Name: waitlists waitlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--
