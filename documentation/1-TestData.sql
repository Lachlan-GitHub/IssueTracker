--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-08-21 15:11:26

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
-- TOC entry 214 (class 1259 OID 16452)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    role character varying(255),
    project_id integer
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16466)
-- Name: issues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issues (
    id integer NOT NULL,
    title character varying,
    description character varying,
    date date,
    tester_id integer,
    developer_id integer,
    project_id integer,
    status character varying,
    priority character varying,
    target_date date,
    end_date date,
    solution character varying
);


ALTER TABLE public.issues OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16459)
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying,
    start_date date,
    projected_start_date date,
    actual_end_date date,
    manager_id integer
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- TOC entry 3333 (class 0 OID 16452)
-- Dependencies: 214
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, name, email, role, project_id) FROM stdin;
0	test_employee_1	test_employee_1@email.com	manager	0
1	test_employee_2	test_employee_2@email.com	developer	0
2	test_employee_3	test_employee_3@email.com	tester	0
\.


--
-- TOC entry 3335 (class 0 OID 16466)
-- Dependencies: 216
-- Data for Name: issues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issues (id, title, description, date, tester_id, developer_id, project_id, status, priority, target_date, end_date, solution) FROM stdin;
0	issue 1	this is issue 1	2023-08-21	2	1	0	open	high	2023-08-25	\N	\N
\.


--
-- TOC entry 3334 (class 0 OID 16459)
-- Dependencies: 215
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, name, start_date, projected_start_date, actual_end_date, manager_id) FROM stdin;
0	test_project	2023-08-21	2023-08-30	\N	0
\.


--
-- TOC entry 3181 (class 2606 OID 16458)
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 3185 (class 2606 OID 16472)
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 16465)
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- TOC entry 3188 (class 2606 OID 16488)
-- Name: issues developer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT developer_id_fkey FOREIGN KEY (developer_id) REFERENCES public.employees(id) NOT VALID;


--
-- TOC entry 3187 (class 2606 OID 16478)
-- Name: projects manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.employees(id) NOT VALID;


--
-- TOC entry 3186 (class 2606 OID 16473)
-- Name: employees project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) NOT VALID;


--
-- TOC entry 3189 (class 2606 OID 16493)
-- Name: issues project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) NOT VALID;


--
-- TOC entry 3190 (class 2606 OID 16483)
-- Name: issues tester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT tester_id_fkey FOREIGN KEY (tester_id) REFERENCES public.employees(id) NOT VALID;


-- Completed on 2023-08-21 15:11:26

--
-- PostgreSQL database dump complete
--

