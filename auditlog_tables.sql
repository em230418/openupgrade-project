--
-- PostgreSQL database dump
--

-- Dumped from database version 11.12 (Debian 11.12-0+deb10u1)
-- Dumped by pg_dump version 11.12 (Debian 11.12-0+deb10u1)

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

SET default_with_oids = false;

--
-- Name: auditlog_log; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auditlog_log (
    id integer NOT NULL,
    name character varying(64),
    model_id integer,
    res_id integer,
    user_id integer,
    method character varying(64),
    http_session_id integer,
    http_request_id integer,
    log_type character varying,
    create_uid integer,
    create_date timestamp without time zone,
    write_uid integer,
    write_date timestamp without time zone
);


ALTER TABLE public.auditlog_log OWNER TO odoo;

--
-- Name: TABLE auditlog_log; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auditlog_log IS 'Auditlog - Log';


--
-- Name: COLUMN auditlog_log.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.name IS 'Resource Name';


--
-- Name: COLUMN auditlog_log.model_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.model_id IS 'Model';


--
-- Name: COLUMN auditlog_log.res_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.res_id IS 'Resource ID';


--
-- Name: COLUMN auditlog_log.user_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.user_id IS 'User';


--
-- Name: COLUMN auditlog_log.method; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.method IS 'Method';


--
-- Name: COLUMN auditlog_log.http_session_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.http_session_id IS 'Session';


--
-- Name: COLUMN auditlog_log.http_request_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.http_request_id IS 'HTTP Request';


--
-- Name: COLUMN auditlog_log.log_type; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.log_type IS 'Type';


--
-- Name: COLUMN auditlog_log.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.create_uid IS 'Created by';


--
-- Name: COLUMN auditlog_log.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.create_date IS 'Created on';


--
-- Name: COLUMN auditlog_log.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auditlog_log.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log.write_date IS 'Last Updated on';


--
-- Name: auditlog_log_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auditlog_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditlog_log_id_seq OWNER TO odoo;

--
-- Name: auditlog_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auditlog_log_id_seq OWNED BY public.auditlog_log.id;


--
-- Name: auditlog_log_line; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auditlog_log_line (
    id integer NOT NULL,
    field_id integer NOT NULL,
    log_id integer,
    old_value text,
    new_value text,
    old_value_text text,
    new_value_text text,
    create_uid integer,
    create_date timestamp without time zone,
    write_uid integer,
    write_date timestamp without time zone
);


ALTER TABLE public.auditlog_log_line OWNER TO odoo;

--
-- Name: TABLE auditlog_log_line; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auditlog_log_line IS 'Auditlog - Log details (fields updated)';


--
-- Name: COLUMN auditlog_log_line.field_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.field_id IS 'Field';


--
-- Name: COLUMN auditlog_log_line.log_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.log_id IS 'Log';


--
-- Name: COLUMN auditlog_log_line.old_value; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.old_value IS 'Old Value';


--
-- Name: COLUMN auditlog_log_line.new_value; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.new_value IS 'New Value';


--
-- Name: COLUMN auditlog_log_line.old_value_text; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.old_value_text IS 'Old value Text';


--
-- Name: COLUMN auditlog_log_line.new_value_text; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.new_value_text IS 'New value Text';


--
-- Name: COLUMN auditlog_log_line.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.create_uid IS 'Created by';


--
-- Name: COLUMN auditlog_log_line.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.create_date IS 'Created on';


--
-- Name: COLUMN auditlog_log_line.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auditlog_log_line.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auditlog_log_line.write_date IS 'Last Updated on';


--
-- Name: auditlog_log_line_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auditlog_log_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditlog_log_line_id_seq OWNER TO odoo;

--
-- Name: auditlog_log_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auditlog_log_line_id_seq OWNED BY public.auditlog_log_line.id;


--
-- Name: auditlog_log id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log ALTER COLUMN id SET DEFAULT nextval('public.auditlog_log_id_seq'::regclass);


--
-- Name: auditlog_log_line id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line ALTER COLUMN id SET DEFAULT nextval('public.auditlog_log_line_id_seq'::regclass);


--
-- Name: auditlog_log_line auditlog_log_line_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line
    ADD CONSTRAINT auditlog_log_line_pkey PRIMARY KEY (id);


--
-- Name: auditlog_log auditlog_log_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_pkey PRIMARY KEY (id);


--
-- Name: auditlog_log_line_log_id_index; Type: INDEX; Schema: public; Owner: odoo
--

CREATE INDEX auditlog_log_line_log_id_index ON public.auditlog_log_line USING btree (log_id);


--
-- Name: auditlog_log auditlog_log_create_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_create_uid_fkey FOREIGN KEY (create_uid) REFERENCES public.res_users(id) ON DELETE SET NULL;


--
-- Name: auditlog_log auditlog_log_http_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_http_request_id_fkey FOREIGN KEY (http_request_id) REFERENCES public.auditlog_http_request(id) ON DELETE SET NULL;


--
-- Name: auditlog_log auditlog_log_http_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_http_session_id_fkey FOREIGN KEY (http_session_id) REFERENCES public.auditlog_http_session(id) ON DELETE SET NULL;


--
-- Name: auditlog_log_line auditlog_log_line_create_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line
    ADD CONSTRAINT auditlog_log_line_create_uid_fkey FOREIGN KEY (create_uid) REFERENCES public.res_users(id) ON DELETE SET NULL;


--
-- Name: auditlog_log_line auditlog_log_line_field_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line
    ADD CONSTRAINT auditlog_log_line_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.ir_model_fields(id) ON DELETE CASCADE;


--
-- Name: auditlog_log_line auditlog_log_line_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line
    ADD CONSTRAINT auditlog_log_line_log_id_fkey FOREIGN KEY (log_id) REFERENCES public.auditlog_log(id) ON DELETE CASCADE;


--
-- Name: auditlog_log_line auditlog_log_line_write_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log_line
    ADD CONSTRAINT auditlog_log_line_write_uid_fkey FOREIGN KEY (write_uid) REFERENCES public.res_users(id) ON DELETE SET NULL;


--
-- Name: auditlog_log auditlog_log_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.ir_model(id) ON DELETE SET NULL;


--
-- Name: auditlog_log auditlog_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.res_users(id) ON DELETE SET NULL;


--
-- Name: auditlog_log auditlog_log_write_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.auditlog_log
    ADD CONSTRAINT auditlog_log_write_uid_fkey FOREIGN KEY (write_uid) REFERENCES public.res_users(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

