PGDMP     *    &    	            {            issuetracker    15.4    15.4     
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16401    issuetracker    DATABASE     �   CREATE DATABASE issuetracker WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE issuetracker;
                postgres    false            �            1259    16452 	   employees    TABLE     �   CREATE TABLE public.employees (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    role character varying(255),
    project_id integer
);
    DROP TABLE public.employees;
       public         heap    postgres    false            �            1259    16466    issues    TABLE     W  CREATE TABLE public.issues (
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
    DROP TABLE public.issues;
       public         heap    postgres    false            �            1259    16459    projects    TABLE     �   CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying,
    start_date date,
    projected_start_date date,
    actual_end_date date,
    manager_id integer
);
    DROP TABLE public.projects;
       public         heap    postgres    false                      0    16452 	   employees 
   TABLE DATA           F   COPY public.employees (id, name, email, role, project_id) FROM stdin;
    public          postgres    false    214   �                 0    16466    issues 
   TABLE DATA           �   COPY public.issues (id, title, description, date, tester_id, developer_id, project_id, status, priority, target_date, end_date, solution) FROM stdin;
    public          postgres    false    216   �                 0    16459    projects 
   TABLE DATA           k   COPY public.projects (id, name, start_date, projected_start_date, actual_end_date, manager_id) FROM stdin;
    public          postgres    false    215   �       m           2606    16458    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    214            q           2606    16472    issues issues_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.issues DROP CONSTRAINT issues_pkey;
       public            postgres    false    216            o           2606    16465    projects projects_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public            postgres    false    215            t           2606    16488    issues developer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.issues
    ADD CONSTRAINT developer_id_fkey FOREIGN KEY (developer_id) REFERENCES public.employees(id) NOT VALID;
 B   ALTER TABLE ONLY public.issues DROP CONSTRAINT developer_id_fkey;
       public          postgres    false    3181    216    214            s           2606    16478    projects manager_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.employees(id) NOT VALID;
 B   ALTER TABLE ONLY public.projects DROP CONSTRAINT manager_id_fkey;
       public          postgres    false    214    215    3181            r           2606    16473    employees project_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) NOT VALID;
 C   ALTER TABLE ONLY public.employees DROP CONSTRAINT project_id_fkey;
       public          postgres    false    215    3183    214            u           2606    16493    issues project_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.issues
    ADD CONSTRAINT project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) NOT VALID;
 @   ALTER TABLE ONLY public.issues DROP CONSTRAINT project_id_fkey;
       public          postgres    false    3183    215    216            v           2606    16483    issues tester_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.issues
    ADD CONSTRAINT tester_id_fkey FOREIGN KEY (tester_id) REFERENCES public.employees(id) NOT VALID;
 ?   ALTER TABLE ONLY public.issues DROP CONSTRAINT tester_id_fkey;
       public          postgres    false    214    216    3181               �   x����n�0E�ˏ	,��d��(�.� �-�v+K���ߗv��P���\�J�F�K�ү���o�/2p�6M0��V"
2x�ǗbM��'.�,z����㴦����}@�w,����b��Qo!�̷1��9����>��Qyu��ykR����"�����C����x�ҢU�_X�)pk']��+a��M7��εۡ�8�yCD���(         '  x��UMo�J<o~o�������h�� �ڦ��-��«]a?��ߗ\I��� r0�cr8�+��B��B��!:����/��䡬�uɇ`ג'����S���lC��8k�P�i�"�U��yqs^ݨJ��Pߞ/�w��_�����W�;�VOޭ�!�u�'�.Bh�N3���8���)( ��F�����S���R��{�Ο��7���yy=���~i����	�X�ֻ�i��u��tl�%��0V-`�X��D��С���k��G���c�#�B��
X�z�Ȭ�h���
��a>�[�2�����q��q���{@��=�裴��ϩW?���c6��p�b"iD��<�]D�9���x�y�E�,Fe����;�s��M��C��u�ǋ�!l�X�Cz��iw�_�v3�&�Z&�#J�ʻ-�y[i��"y����0���G�z!��?�����u���$y�Z�N�V���1�W�t�M����/G��ꉇ�>�M���/�+���Ț�1͠� �w�\ؚp]�-��E��2UL�,�Wy��<M�Q�;�3t�!9<�J&�5�h��\"��2�!�T;#��q��z��bz�W=|ו^�D.�þ'o�ݾ����u��� ��"�F���`2O�����@���:��G�Gu��ϓ���".��5>K}��D͈��h�	.�)�!\�eь��o��?����1��������W����[;�Z�e\�&q}Df3x!�p�b9�{�f��I=���I���2g�_c�[Q�������j��?qLXAYZ#�p|�vN�M��}qvv�n2�         ]   x�3�t��-H̫TOM*�,I�4202�5��52�3�8c�8���Jsj-�LK�ZC.#NǼ�Lݰ̢�bǂ�C#4�F\1z\\\ e� J     