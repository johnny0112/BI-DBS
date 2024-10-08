-- Remove conflicting tables
DROP TABLE IF EXISTS fyzicka_osoba CASCADE;
DROP TABLE IF EXISTS id_objednavky CASCADE;
DROP TABLE IF EXISTS jidlo CASCADE;
DROP TABLE IF EXISTS objednavka CASCADE;
DROP TABLE IF EXISTS pravnicka_osoba CASCADE;
DROP TABLE IF EXISTS provozovna CASCADE;
DROP TABLE IF EXISTS recenze CASCADE;
DROP TABLE IF EXISTS vlastnik CASCADE;
DROP TABLE IF EXISTS zakaznik CASCADE;
DROP TABLE IF EXISTS zamestnanec CASCADE;
DROP TABLE IF EXISTS zamestnanec_provozovna CASCADE;
-- End of removing

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE fyzicka_osoba (
    id_vlastnika INTEGER NOT NULL,
    jmeno VARCHAR(256) NOT NULL,
    prijmeni VARCHAR(256) NOT NULL,
    datum_narozeni DATE NOT NULL
);
ALTER TABLE fyzicka_osoba ADD CONSTRAINT pk_fyzicka_osoba PRIMARY KEY (id_vlastnika);
ALTER TABLE fyzicka_osoba ADD CONSTRAINT exclude_id_vlastnika_fyzicka EXCLUDE USING gist (id_vlastnika WITH =);


CREATE TABLE id_objednavky (
    id_jidla INTEGER NOT NULL,
    id_objednavky INTEGER NOT NULL,
    id_provozovny INTEGER NOT NULL,
    id_zakaznika INTEGER NOT NULL
);
ALTER TABLE id_objednavky ADD CONSTRAINT pk_id_objednavky PRIMARY KEY (id_jidla, id_objednavky, id_provozovny, id_zakaznika);

CREATE TABLE jidlo (
    id_jidla SERIAL NOT NULL,
    cena INTEGER NOT NULL,
    nazev_jidla VARCHAR(256) NOT NULL,
    id_provozovny INTEGER NOT NULL
);
ALTER TABLE jidlo ADD CONSTRAINT pk_jidlo PRIMARY KEY (id_jidla);

CREATE TABLE objednavka (
    id_objednavky SERIAL NOT NULL,
    id_zamestnance INTEGER NOT NULL,
    datum DATE NOT NULL
);
ALTER TABLE objednavka ADD CONSTRAINT pk_objednavka PRIMARY KEY (id_objednavky);

CREATE TABLE pravnicka_osoba (
    id_vlastnika INTEGER NOT NULL,
    nazev_spolecnosti VARCHAR(256) NOT NULL,
    spolehlivost INTEGER
);
ALTER TABLE pravnicka_osoba ADD CONSTRAINT pk_pravnicka_osoba PRIMARY KEY (id_vlastnika);
ALTER TABLE pravnicka_osoba ADD CONSTRAINT ck_pravnicka_osoba_spolehlivost CHECK (spolehlivost IS NULL OR (spolehlivost >= 0 AND spolehlivost <= 100));
ALTER TABLE pravnicka_osoba ADD CONSTRAINT exclude_id_vlastnika_pravnicka EXCLUDE USING gist (id_vlastnika WITH =);


CREATE TABLE provozovna (
    id_provozovny SERIAL NOT NULL,
    id_vlastnika INTEGER NOT NULL,
    adresa VARCHAR(256) NOT NULL,
    nazev VARCHAR(256) NOT NULL,
    telefonni_cislo VARCHAR(256),
    web VARCHAR(256)
);
ALTER TABLE provozovna ADD CONSTRAINT pk_provozovna PRIMARY KEY (id_provozovny);

CREATE TABLE recenze (
    id_recenze SERIAL NOT NULL,
    id_provozovny INTEGER NOT NULL,
    id_zakaznika INTEGER NOT NULL,
    datum DATE NOT NULL,
    hodnoceni REAL NOT NULL,
    platforma VARCHAR(256) NOT NULL
);
ALTER TABLE recenze ADD CONSTRAINT pk_recenze PRIMARY KEY (id_recenze);

CREATE TABLE vlastnik (
    id_vlastnika SERIAL NOT NULL,
    ico INTEGER NOT NULL,
    email VARCHAR(256),
    telefonni_cislo VARCHAR(256)
);
ALTER TABLE vlastnik ADD CONSTRAINT pk_vlastnik PRIMARY KEY (id_vlastnika);
ALTER TABLE vlastnik ADD CONSTRAINT ck_vlastnik_ico CHECK (ico >= 10000000 AND ico <= 99999999);


CREATE TABLE zakaznik (
    id_zakaznika SERIAL NOT NULL,
    jmeno VARCHAR(256) NOT NULL,
    prijmeni VARCHAR(256) NOT NULL,
    telefonni_cislo VARCHAR(256),
    email VARCHAR(256)
    
);
ALTER TABLE zakaznik ADD CONSTRAINT pk_zakaznik PRIMARY KEY (id_zakaznika);

CREATE TABLE zamestnanec (
    id_zamestnance SERIAL NOT NULL,
    jmeno VARCHAR(256) NOT NULL,
    prijmeni VARCHAR(256) NOT NULL,
    datum_narozeni DATE NOT NULL,
    datum_nastupu_do_zamestnani DATE NOT NULL
);
ALTER TABLE zamestnanec ADD CONSTRAINT pk_zamestnanec PRIMARY KEY (id_zamestnance);

CREATE TABLE zamestnanec_provozovna (
    id_zamestnance INTEGER NOT NULL,
    id_provozovny INTEGER NOT NULL
);
ALTER TABLE zamestnanec_provozovna ADD CONSTRAINT pk_zamestnanec_provozovna PRIMARY KEY (id_zamestnance, id_provozovny);

ALTER TABLE fyzicka_osoba ADD CONSTRAINT fk_fyzicka_osoba_vlastnik FOREIGN KEY (id_vlastnika) REFERENCES vlastnik (id_vlastnika) ON DELETE CASCADE;

ALTER TABLE id_objednavky ADD CONSTRAINT fk_id_objednavky_jidlo FOREIGN KEY (id_jidla) REFERENCES jidlo (id_jidla) ON DELETE CASCADE;
ALTER TABLE id_objednavky ADD CONSTRAINT fk_id_objednavky_objednavka FOREIGN KEY (id_objednavky) REFERENCES objednavka (id_objednavky) ON DELETE CASCADE;
ALTER TABLE id_objednavky ADD CONSTRAINT fk_id_objednavky_provozovna FOREIGN KEY (id_provozovny) REFERENCES provozovna (id_provozovny) ON DELETE CASCADE;
ALTER TABLE id_objednavky ADD CONSTRAINT fk_id_objednavky_zakaznik FOREIGN KEY (id_zakaznika) REFERENCES zakaznik (id_zakaznika) ON DELETE CASCADE;

ALTER TABLE objednavka ADD CONSTRAINT fk_objednavka_zamestnanec FOREIGN KEY (id_zamestnance) REFERENCES zamestnanec (id_zamestnance) ON DELETE CASCADE;

ALTER TABLE pravnicka_osoba ADD CONSTRAINT fk_pravnicka_osoba_vlastnik FOREIGN KEY (id_vlastnika) REFERENCES vlastnik (id_vlastnika) ON DELETE CASCADE;

ALTER TABLE provozovna ADD CONSTRAINT fk_provozovna_vlastnik FOREIGN KEY (id_vlastnika) REFERENCES vlastnik (id_vlastnika) ON DELETE CASCADE;

ALTER TABLE recenze ADD CONSTRAINT fk_recenze_provozovna FOREIGN KEY (id_provozovny) REFERENCES provozovna (id_provozovny) ON DELETE CASCADE;
ALTER TABLE recenze ADD CONSTRAINT fk_recenze_zakaznik FOREIGN KEY (id_zakaznika) REFERENCES zakaznik (id_zakaznika) ON DELETE CASCADE;

ALTER TABLE zamestnanec_provozovna ADD CONSTRAINT fk_zamestnanec_provozovna_zames FOREIGN KEY (id_zamestnance) REFERENCES zamestnanec (id_zamestnance) ON DELETE CASCADE;
ALTER TABLE zamestnanec_provozovna ADD CONSTRAINT fk_zamestnanec_provozovna_provo FOREIGN KEY (id_provozovny) REFERENCES provozovna (id_provozovny) ON DELETE CASCADE;
