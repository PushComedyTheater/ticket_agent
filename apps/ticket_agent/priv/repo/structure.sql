--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: class_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE class_type AS ENUM (
    'improvisation',
    'sketch',
    'standup',
    'acting'
);


--
-- Name: event_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE event_status AS ENUM (
    'hidden',
    'normal'
);


--
-- Name: listing_image_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE listing_image_type AS ENUM (
    'cover',
    'social',
    'additional'
);


--
-- Name: listing_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE listing_status AS ENUM (
    'unpublished',
    'active',
    'canceled',
    'deleted'
);


--
-- Name: ticket_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE ticket_status AS ENUM (
    'available',
    'locked',
    'purchased'
);


--
-- Name: user_credential_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_credential_provider AS ENUM (
    'facebook',
    'google',
    'twitter'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_role AS ENUM (
    'admin',
    'agent',
    'customer'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid NOT NULL,
    name text,
    description text,
    url text,
    enabled boolean,
    logo text,
    creator_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: classes; Type: TABLE; Schema: public; Owner: -
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
    photo_url text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE events (
    id uuid NOT NULL,
    slug text NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status event_status DEFAULT 'normal'::event_status,
    account_id uuid,
    user_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: listing_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE listing_images (
    id uuid NOT NULL,
    listing_id uuid NOT NULL,
    url text NOT NULL,
    type listing_image_type NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: listing_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE listing_tags (
    id uuid NOT NULL,
    listing_id uuid NOT NULL,
    tag text NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: listings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE listings (
    id uuid NOT NULL,
    slug text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    status listing_status DEFAULT 'unpublished'::listing_status,
    start_at timestamp without time zone DEFAULT now(),
    end_at timestamp without time zone DEFAULT now(),
    user_id uuid,
    event_id uuid,
    class_id uuid,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teachers (
    id uuid NOT NULL,
    slug character varying(255),
    name character varying(255),
    email character varying(255),
    biography text,
    social jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ticket_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ticket_registrations (
    id uuid NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    ticket_id uuid NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tickets (
    id uuid NOT NULL,
    listing_id uuid NOT NULL,
    user_id uuid,
    name text NOT NULL,
    status ticket_status DEFAULT 'available'::ticket_status,
    description text,
    price integer NOT NULL,
    sale_start timestamp without time zone,
    sale_end timestamp without time zone,
    locked_until timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_credentials (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    provider user_credential_provider NOT NULL,
    token text NOT NULL,
    secret text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
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
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    account_id uuid,
    role user_role DEFAULT 'customer'::user_role
);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: listing_images listing_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listing_images
    ADD CONSTRAINT listing_images_pkey PRIMARY KEY (id);


--
-- Name: listing_tags listing_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listing_tags
    ADD CONSTRAINT listing_tags_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: ticket_registrations ticket_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ticket_registrations
    ADD CONSTRAINT ticket_registrations_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: user_credentials user_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: accounts_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX accounts_name_index ON accounts USING btree (name);


--
-- Name: classes_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX classes_slug_index ON classes USING btree (slug);


--
-- Name: classes_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX classes_type_index ON classes USING btree (type);


--
-- Name: events_account_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_account_id_index ON events USING btree (account_id);


--
-- Name: events_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX events_slug_index ON events USING btree (slug);


--
-- Name: events_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_user_id_index ON events USING btree (user_id);


--
-- Name: listing_images_listing_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listing_images_listing_id_index ON listing_images USING btree (listing_id);


--
-- Name: listings_class_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listings_class_id_index ON listings USING btree (class_id);


--
-- Name: listings_end_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listings_end_at_index ON listings USING btree (end_at);


--
-- Name: listings_event_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listings_event_id_index ON listings USING btree (event_id);


--
-- Name: listings_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX listings_slug_index ON listings USING btree (slug);


--
-- Name: listings_start_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listings_start_at_index ON listings USING btree (start_at);


--
-- Name: listings_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX listings_user_id_index ON listings USING btree (user_id);


--
-- Name: teachers_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX teachers_slug_index ON teachers USING btree (slug);


--
-- Name: user_credentials_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_credentials_user_id_index ON user_credentials USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON users USING btree (email);


--
-- Name: users_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_name_index ON users USING btree (name);


--
-- Name: accounts accounts_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: classes classes_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: classes classes_prerequisite_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classes
    ADD CONSTRAINT classes_prerequisite_id_fkey FOREIGN KEY (prerequisite_id) REFERENCES classes(id);


--
-- Name: events events_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: events events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: listing_images listing_images_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listing_images
    ADD CONSTRAINT listing_images_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id);


--
-- Name: listing_tags listing_tags_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listing_tags
    ADD CONSTRAINT listing_tags_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id);


--
-- Name: listings listings_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_class_id_fkey FOREIGN KEY (class_id) REFERENCES classes(id);


--
-- Name: listings listings_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);


--
-- Name: listings listings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: ticket_registrations ticket_registrations_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ticket_registrations
    ADD CONSTRAINT ticket_registrations_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_credentials user_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credentials
    ADD CONSTRAINT user_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users users_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20170724134756), (20170725134756), (20170728231040), (20170728233531), (20170806194117), (20171016234419), (20171116020408), (20171116020410), (20171116020411), (20171116020412), (20171116020413), (20171116020414);

