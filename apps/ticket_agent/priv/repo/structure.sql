--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.2

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


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


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
-- Name: credit_card_type; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: event_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE event_status AS ENUM (
    'hidden',
    'draft',
    'normal'
);


--
-- Name: listing_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE listing_status AS ENUM (
    'unpublished',
    'active',
    'completed',
    'canceled',
    'deleted'
);


--
-- Name: listing_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE listing_type AS ENUM (
    'class',
    'show',
    'camp'
);


--
-- Name: order_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE order_status AS ENUM (
    'started',
    'processing',
    'completed',
    'errored',
    'cancelled'
);


--
-- Name: ticket_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE ticket_status AS ENUM (
    'available',
    'locked',
    'processing',
    'purchased',
    'emailed',
    'checkedin'
);


--
-- Name: user_credential_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_credential_provider AS ENUM (
    'facebook',
    'google',
    'linkedin',
    'twitter',
    'microsoft',
    'amazon'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE user_role AS ENUM (
    'admin',
    'concierge',
    'customer',
    'oauth_customer',
    'guest'
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
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
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
    image_url text,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: credit_cards; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: event_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE event_tags (
    id uuid NOT NULL,
    event_id uuid NOT NULL,
    tag text NOT NULL,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
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
    image_url text,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
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
    type listing_type DEFAULT 'show'::listing_type,
    start_at timestamp with time zone DEFAULT now(),
    end_at timestamp with time zone,
    user_id uuid,
    event_id uuid,
    class_id uuid,
    pass_fees_to_buyer boolean DEFAULT true,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: order_details; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
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
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: -
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
    stripe_customer_id character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    one_time_token character varying(255),
    one_time_token_at timestamp without time zone,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    account_id uuid,
    role user_role DEFAULT 'customer'::user_role
);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE versions (
    id bigint NOT NULL,
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


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: waitlists; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: webhook_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE webhook_details (
    id uuid NOT NULL,
    source text,
    request jsonb,
    inserted_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


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
-- Name: credit_cards credit_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_cards
    ADD CONSTRAINT credit_cards_pkey PRIMARY KEY (id);


--
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: order_details order_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT order_details_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


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
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: waitlists waitlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_pkey PRIMARY KEY (id);


--
-- Name: webhook_details webhook_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY webhook_details
    ADD CONSTRAINT webhook_details_pkey PRIMARY KEY (id);


--
-- Name: accounts_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX accounts_name_index ON accounts USING btree (name);


--
-- Name: available_tickets; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX available_tickets ON tickets USING btree (listing_id, sale_start) WHERE ((status = 'available'::ticket_status) AND (locked_until IS NULL));


--
-- Name: classes_prerequisite_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX classes_prerequisite_id_index ON classes USING btree (prerequisite_id);


--
-- Name: classes_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX classes_slug_index ON classes USING btree (slug);


--
-- Name: classes_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX classes_type_index ON classes USING btree (type);


--
-- Name: credit_cards_stripe_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX credit_cards_stripe_id_index ON credit_cards USING btree (stripe_id);


--
-- Name: credit_cards_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX credit_cards_type_index ON credit_cards USING btree (type);


--
-- Name: credit_cards_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX credit_cards_user_id_index ON credit_cards USING btree (user_id);


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
-- Name: index_locked_tickets_by_locked_until; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locked_tickets_by_locked_until ON tickets USING btree (locked_until) WHERE (status = 'locked'::ticket_status);


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
-- Name: order_details_charge_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_details_charge_id_index ON order_details USING btree (charge_id);


--
-- Name: order_details_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_details_order_id_index ON order_details USING btree (order_id);


--
-- Name: order_details_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_details_status_index ON order_details USING btree (status);


--
-- Name: orders_credit_card_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_credit_card_id_index ON orders USING btree (credit_card_id);


--
-- Name: orders_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX orders_slug_index ON orders USING btree (slug);


--
-- Name: orders_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_status_index ON orders USING btree (status);


--
-- Name: orders_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_id_index ON orders USING btree (user_id);


--
-- Name: teachers_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX teachers_slug_index ON teachers USING btree (slug);


--
-- Name: tickets_group_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_group_index ON tickets USING btree ("group");


--
-- Name: tickets_listing_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_listing_id_index ON tickets USING btree (listing_id);


--
-- Name: tickets_locked_until_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_locked_until_index ON tickets USING btree (locked_until);


--
-- Name: tickets_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_order_id_index ON tickets USING btree (order_id);


--
-- Name: tickets_slug_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tickets_slug_index ON tickets USING btree (slug);


--
-- Name: tickets_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tickets_status_index ON tickets USING btree (status);


--
-- Name: user_credentials_provider_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_credentials_provider_index ON user_credentials USING btree (provider);


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
-- Name: users_stripe_customer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_stripe_customer_id_index ON users USING btree (stripe_customer_id);


--
-- Name: versions_event_item_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX versions_event_item_type_index ON versions USING btree (event, item_type);


--
-- Name: versions_item_id_item_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX versions_item_id_item_type_index ON versions USING btree (item_id, item_type);


--
-- Name: versions_item_type_inserted_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX versions_item_type_inserted_at_index ON versions USING btree (item_type, inserted_at);


--
-- Name: versions_originator_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX versions_originator_id_index ON versions USING btree (originator_id);


--
-- Name: waitlists_admin_notified_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX waitlists_admin_notified_index ON waitlists USING btree (admin_notified);


--
-- Name: waitlists_class_id_email_address_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX waitlists_class_id_email_address_index ON waitlists USING btree (class_id, email_address);


--
-- Name: waitlists_class_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX waitlists_class_id_index ON waitlists USING btree (class_id);


--
-- Name: waitlists_class_id_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX waitlists_class_id_user_id_index ON waitlists USING btree (class_id, user_id);


--
-- Name: waitlists_email_address_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX waitlists_email_address_index ON waitlists USING btree (email_address);


--
-- Name: waitlists_listing_id_email_address_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX waitlists_listing_id_email_address_index ON waitlists USING btree (listing_id, email_address);


--
-- Name: waitlists_listing_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX waitlists_listing_id_index ON waitlists USING btree (listing_id);


--
-- Name: waitlists_listing_id_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX waitlists_listing_id_user_id_index ON waitlists USING btree (listing_id, user_id);


--
-- Name: waitlists_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX waitlists_user_id_index ON waitlists USING btree (user_id);


--
-- Name: webhook_details_source_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX webhook_details_source_index ON webhook_details USING btree (source);


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
-- Name: credit_cards credit_cards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_cards
    ADD CONSTRAINT credit_cards_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: event_tags event_tags_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_tags
    ADD CONSTRAINT event_tags_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);


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
-- Name: order_details order_details_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_details
    ADD CONSTRAINT order_details_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: orders orders_credit_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_credit_card_id_fkey FOREIGN KEY (credit_card_id) REFERENCES credit_cards(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: tickets tickets_checked_in_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_checked_in_by_fkey FOREIGN KEY (checked_in_by) REFERENCES users(id);


--
-- Name: tickets tickets_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id);


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
-- Name: versions versions_originator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_originator_id_fkey FOREIGN KEY (originator_id) REFERENCES users(id);


--
-- Name: waitlists waitlists_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_class_id_fkey FOREIGN KEY (class_id) REFERENCES classes(id);


--
-- Name: waitlists waitlists_listing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_listing_id_fkey FOREIGN KEY (listing_id) REFERENCES listings(id);


--
-- Name: waitlists waitlists_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY waitlists
    ADD CONSTRAINT waitlists_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20170724134755), (20170724134756), (20170725134756), (20170728231040), (20170728233531), (20170806194117), (20171016234419), (20171116020407), (20171116020408), (20171116020409), (20171116020410), (20171116020412), (20171116020414), (20171208181236), (20171211141945), (20171223212910), (20180527161836);

