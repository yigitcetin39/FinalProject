-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public."Address"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "AddressTitle_fk" integer NOT NULL,
    "Cities_fk" integer NOT NULL,
    "Street" character varying COLLATE pg_catalog."default" NOT NULL,
    "CustomerId_fk" integer NOT NULL,
    CONSTRAINT "Address_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."AddressTitle"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "AddressTitle_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."Cargo"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Cargo_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."Cities"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Cities_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."MoneyType"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "MoneyType_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."Orders"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Date" date NOT NULL,
    "AdressId_fk" integer NOT NULL,
    "PaymentId_fk" integer NOT NULL,
    "CargoId_fk" integer NOT NULL,
    CONSTRAINT "Orders_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public."Payment"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "MoneyTypeId_fk" integer NOT NULL,
    CONSTRAINT "Payment_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public.categories
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categories_pkey PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public.color_size_relations
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 70 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    colorsid integer NOT NULL,
    sizeid integer NOT NULL,
    CONSTRAINT color_size_relations_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.colors
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Colors_pkey" PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public.customers
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "FirstName" character varying COLLATE pg_catalog."default" NOT NULL,
    "LastName" character varying COLLATE pg_catalog."default" NOT NULL,
    "PhoneNumber" integer NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public.product_categories
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 33 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    categoryid_fk integer NOT NULL,
    productid_fk integer NOT NULL,
    CONSTRAINT product_categories_pkey PRIMARY KEY ("ID")
);

CREATE TABLE IF NOT EXISTS public.products
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "unitPrice" money NOT NULL,
    stock integer NOT NULL,
    colorsizeid integer NOT NULL,
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT products_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.size
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Name" character varying(4) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Size_pkey" PRIMARY KEY ("ID")
);

ALTER TABLE IF EXISTS public."Address"
    ADD CONSTRAINT "adressTitle_fk" FOREIGN KEY ("AddressTitle_fk")
    REFERENCES public."AddressTitle" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Address"
    ADD CONSTRAINT cities_fk FOREIGN KEY ("Cities_fk")
    REFERENCES public."Cities" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Address"
    ADD CONSTRAINT "customerId_fk" FOREIGN KEY ("CustomerId_fk")
    REFERENCES public.customers ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Orders"
    ADD CONSTRAINT "AddressId_fk" FOREIGN KEY ("AdressId_fk")
    REFERENCES public."Address" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Orders"
    ADD CONSTRAINT "CargoId_fk" FOREIGN KEY ("CargoId_fk")
    REFERENCES public."Cargo" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Orders"
    ADD CONSTRAINT "PaymentId_fk" FOREIGN KEY ("PaymentId_fk")
    REFERENCES public."Payment" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Payment"
    ADD CONSTRAINT "MoneyTypeId_fk" FOREIGN KEY ("MoneyTypeId_fk")
    REFERENCES public."MoneyType" ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.color_size_relations
    ADD CONSTRAINT colors_fk FOREIGN KEY (colorsid)
    REFERENCES public.colors ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.color_size_relations
    ADD CONSTRAINT size_fk FOREIGN KEY (sizeid)
    REFERENCES public.size ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_categories
    ADD CONSTRAINT categoryid_fk FOREIGN KEY (categoryid_fk)
    REFERENCES public.categories ("ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_categories
    ADD CONSTRAINT productid_fk FOREIGN KEY (productid_fk)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT color_size_id_fk FOREIGN KEY (colorsizeid)
    REFERENCES public.color_size_relations (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;