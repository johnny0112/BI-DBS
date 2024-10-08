-- smazání všech záznamů z tabulek

CREATE OR REPLACE FUNCTION clean_tables() RETURNS void AS
$$
DECLARE
    l_stmt text;
BEGIN
    SELECT 'truncate ' || STRING_AGG(FORMAT('%I.%I', schemaname, tablename), ',')
    INTO l_stmt
    FROM pg_tables
    WHERE schemaname IN ('public');

    EXECUTE l_stmt || ' cascade';
END;
$$ LANGUAGE plpgsql;
SELECT clean_tables();

-- reset sekvenci

CREATE OR REPLACE FUNCTION restart_sequences() RETURNS void AS
$$
DECLARE
    i TEXT;
BEGIN
    FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
        LOOP
            EXECUTE 'ALTER SEQUENCE' || ' ' || SUBSTRING(SUBSTRING(i FROM '''[a-z_]*') FROM '[a-z_]+') || ' ' ||
                    ' RESTART 1;';
        END LOOP;
END
$$ LANGUAGE plpgsql;
SELECT restart_sequences();
-- konec resetu

-- konec mazání
-- mohli bchom použít i jednotlivé příkazy truncate na každo tabulku

INSERT INTO Zakaznik (id_zakaznika, jmeno, prijmeni, telefonni_cislo, email) VALUES
(1, 'Marek', 'Novák', '777123456', 'marek.novak@example.com'),
(2, 'Jana', 'Svobodová', NULL, 'jana.s@example.com'),
(3, 'Petr', 'Kříž', '605123789', NULL),
(4, 'Lucie', 'Horáková', NULL, NULL),
(5, 'Michal', 'Beneš', '603456123', 'michal.b@example.com'),
(6, 'Kristýna', 'Zelená', NULL, 'kristyna.z@example.com'),
(7, 'Jakub', 'Dvořák', '777654321', NULL),
(8, 'Veronika', 'Marešová', NULL, NULL),
(9, 'David', 'Černý', '702123456', 'david.cerny@example.com'),
(10, 'Eva', 'Pospíšilová', NULL, 'eva.p@example.com'),
(11, 'Radek', 'Jandák', '777223344', NULL),
(12, 'Tereza', 'Kopecká', NULL, NULL),
(13, 'Jan', 'Bartoš', '778123456', 'jan.bartos@example.com'),
(14, 'Anna', 'Krejčí', NULL, 'anna.k@example.com'),
(15, 'Tomáš', 'Vlček', '777456789', NULL),
(16, 'Barbora', 'Navrátilová', NULL, NULL),
(17, 'Josef', 'Konečný', '608123456', 'josef.k@example.com'),
(18, 'Marie', 'Stejskalová', NULL, 'marie.s@example.com'),
(19, 'Martin', 'Veselý', '777987654', NULL),
(20, 'Hana', 'Sýkorová', NULL, NULL),
(21, 'Karel', 'Hruška', '775123456', 'karel.h@example.com'),
(22, 'Lenka', 'Procházková', NULL, 'lenka.p@example.com'),
(23, 'Milan', 'Urban', '777456123', NULL),
(24, 'Olga', 'Němcová', NULL, NULL),
(25, 'Pavel', 'Holý', '608765432', 'pavel.h@example.com'),
(26, 'Simona', 'Bláhová', NULL, 'simona.b@example.com'),
(27, 'Ondřej', 'Vojtěch', '776543210', NULL),
(28, 'Alena', 'Kučerová', NULL, NULL),
(29, 'Filip', 'Havel', '775678901', 'filip.h@example.com'),
(30, 'Petra', 'Novotná', NULL, 'petra.n@example.com'),
(31, 'Václav', 'Mach', '777321654', NULL),
(32, 'Kateřina', 'Bílá', NULL, NULL),
(33, 'Roman', 'Čech', '773456789', 'roman.cech@example.com'),
(34, 'Iva', 'Dostálová', NULL, 'iva.d@example.com'),
(35, 'Lukáš', 'Jiránek', '777654888', 'lukas.j@example.com');

SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Zakaznik', 'id_zakaznika'), 35);

INSERT INTO Jidlo (id_jidla, cena, nazev_jidla, id_provozovny)
VALUES
(1, 150, 'Velký kebab v boxu', 1),
(2, 100, 'Malý kebab v boxu', 2),
(3, 120, 'Shawarma s kuřecím masem', 3),
(4, 140, 'Shawarma s hovězím masem', 4),
(5, 90, 'Falafel v pita chlebu', 5),
(6, 130, 'Tabbouleh', 6),
(7, 110, 'Hummus s olivovým olejem', 7),
(8, 95, 'Baba Ganoush', 8),
(9, 85, 'Mujaddara', 9),
(10, 160, 'Kuře Mandi', 10),
(11, 170, 'Kebab s jehněčím masem', 11),
(12, 110, 'Fattoush', 12),
(13, 105, 'Kofta kebab', 13),
(14, 120, 'Arabský masový wrap', 14),
(15, 135, 'Lahmacun', 15),
(16, 150, 'Arabské jehněčí kofty', 16),
(17, 160, 'Mansaf', 17),
(18, 90, 'Sfiha', 18),
(19, 180, 'Kuře Sumak', 19),
(20, 80, 'Gyros s rýží', 20),
(21, 155, 'Velký kebab v boxu', 15),
(22, 105, 'Malý kebab v boxu', 13),
(23, 125, 'Shawarma s kuřecím masem', 4),
(24, 145, 'Shawarma s hovězím masem', 3),
(25, 95, 'Falafel v pita chlebu', 6),
(26, 135, 'Tabbouleh', 5),
(27, 115, 'Hummus s olivovým olejem', 8),
(28, 100, 'Baba Ganoush', 7),
(29, 90, 'Mujaddara', 10),
(30, 165, 'Kuře Mandi', 9),
(31, 175, 'Kebab s jehněčím masem', 12),
(32, 115, 'Fattoush', 11),
(33, 110, 'Kofta kebab', 14),
(34, 125, 'Arabský masový wrap', 13),
(35, 140, 'Lahmacun', 16),
(36, 155, 'Arabské jehněčí kofty', 15),
(37, 165, 'Mansaf', 18),
(38, 95, 'Sfiha', 17),
(39, 185, 'Kuře Sumak', 20),
(40, 85, 'Gyros s rýží', 19),
(41, 160, 'Velký kebab v boxu', 7),
(42, 110, 'Malý kebab v boxu', 3),
(43, 130, 'Shawarma s kuřecím masem', 9),
(44, 150, 'Shawarma s hovězím masem', 12),
(45, 100, 'Falafel v pita chlebu', 17),
(46, 140, 'Tabbouleh', 18),
(47, 120, 'Hummus s olivovým olejem', 19),
(48, 105, 'Baba Ganoush', 20),
(49, 95, 'Mujaddara', 2),
(50, 170, 'Kuře Mandi', 20);

SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Jidlo', 'id_jidla'), 50);

INSERT INTO Vlastnik (id_vlastnika, ico, email, telefonni_cislo) VALUES
(1, 12345678, 'info@kebabpalace.cz', '224 001 122'),
(2, 87654321, NULL, '224 002 123'),
(3, 23456789, 'contact@shawarmaking.cz', NULL),
(4, 98765432, NULL, NULL),
(5, 34567890, 'support@hummushome.cz', '224 003 124'),
(6, 65432198, NULL, '224 004 125'),
(7, 45678901, 'hello@grillkebab.cz', NULL),
(8, 10987654, NULL, NULL),
(9, 56789012, 'sales@quickkebab.cz', '224 005 126'),
(10, 21098765, NULL, NULL),
(11, 67890123, 'info@falafelspot.cz', '224 006 127'),
(12, 32109876, NULL, '224 007 128'),
(13, 78901234, 'office@babaganoushbistro.cz', NULL),
(14, 43210987, NULL, NULL),
(15, 89012345, 'contact@arabiandelight.cz', '224 008 129');

SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Vlastnik', 'id_vlastnika'), 15);

INSERT INTO Zamestnanec (id_zamestnance, jmeno, prijmeni, datum_narozeni, datum_nastupu_do_zamestnani) VALUES
(1, 'Ahmad', 'Ali', '1985-04-01', '2020-01-10'),
(2, 'Sami', 'Khan', '1988-09-15', '2020-05-20'),
(3, 'Layla', 'Haddad', '1990-07-03', '2021-05-20'),
(4, 'Zainab', 'Farah', '1990-07-03', '2019-11-01'),
(5, 'Omar', 'Said', '1992-01-12', '2018-02-15'),
(6, 'Nour', 'Al Din', '1983-03-22', '2018-06-15'),
(7, 'Hana', 'Najjar', '1991-08-14', '2022-02-01'),
(8, 'Rania', 'Masri', '1975-08-30', '2017-03-05'),
(9, 'Youssef', 'Najem', '1980-12-05', '2017-07-23'),
(10, 'Karim', 'Jabbar', '1986-09-10', '2020-09-10'),
(11, 'Aisha', 'Boutros', '1993-05-16', '2021-06-01'),
(12, 'Tarek', 'Abbas', '1987-11-11', '2016-03-17'),
(13, 'Soraya', 'Fadel', '1989-04-23', '2019-10-15'),
(14, 'Mounir', 'Fahmy', '1984-06-09', '2015-08-20'),
(15, 'Fatima', 'Ghazal', '1981-02-25', '2021-01-05'),
(16, 'Isra', 'Mourad', '1989-11-01', '2020-04-22'),
(17, 'Saleh', 'Daoud', '1979-09-19', '2019-10-31'),
(18, 'Reem', 'Qasim', '1988-04-30', '2018-11-30'),
(19, 'Jalal', 'Hamdan', '1983-06-20', '2017-06-20'),
(20, 'Maya', 'Nassar', '1990-03-18', '2019-04-15'),
(21, 'Fadi', 'Makram', '1974-01-14', '2015-05-09'),
(22, 'Saba', 'Al Akhras', '1988-07-13', '2021-07-13'),
(23, 'Ibrahim', 'Quraishi', '1985-11-23', '2018-03-11'),
(24, 'Nadine', 'Sulaiman', '1992-08-08', '2019-12-01'),
(25, 'Ahmad', 'Chalek', '1986-04-01', '2021-01-10'),
(26, 'Reem', 'Nassar', '1996-04-01', '2022-01-10');


SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Zamestnanec', 'id_zamestnance'), 26);


insert into objednavka (id_objednavky, id_zamestnance, datum) values (1, 4, '2021-11-03');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (2, 5, '2023-02-03');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (3, 6, '2022-10-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (4, 4, '2021-12-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (5, 12, '2021-12-31');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (6, 19, '2023-02-10');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (7, 3, '2023-11-14');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (8, 12, '2022-03-10');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (9, 8, '2022-12-25');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (10, 5, '2022-01-10');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (11, 20, '2021-05-27');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (12, 9, '2022-10-30');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (13, 4, '2024-01-24');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (14, 10, '2023-08-24');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (15, 12, '2023-05-06');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (16, 18, '2021-09-22');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (17, 6, '2022-10-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (18, 17, '2021-07-05');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (19, 15, '2022-05-01');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (20, 12, '2021-07-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (21, 11, '2023-01-25');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (22, 7, '2023-07-22');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (23, 5, '2023-07-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (24, 12, '2021-05-14');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (25, 3, '2024-03-15');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (26, 8, '2024-01-13');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (27, 10, '2024-03-26');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (28, 8, '2023-11-19');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (29, 3, '2021-10-01');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (30, 8, '2021-07-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (31, 16, '2023-08-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (32, 16, '2021-10-24');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (33, 21, '2023-03-07');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (34, 19, '2023-11-03');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (35, 4, '2023-12-23');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (36, 2, '2021-10-13');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (37, 21, '2023-02-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (38, 8, '2023-03-13');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (39, 7, '2022-01-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (40, 19, '2023-08-25');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (41, 7, '2022-10-12');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (42, 16, '2022-01-31');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (43, 16, '2023-06-10');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (44, 14, '2023-11-03');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (45, 5, '2024-04-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (46, 7, '2024-03-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (47, 9, '2021-06-29');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (48, 22, '2023-07-30');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (49, 4, '2023-08-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (50, 21, '2022-07-19');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (51, 16, '2023-01-27');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (52, 3, '2023-09-16');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (53, 2, '2023-04-24');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (54, 8, '2024-02-19');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (55, 6, '2024-01-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (56, 10, '2021-09-18');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (57, 12, '2024-03-16');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (58, 11, '2024-01-27');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (59, 18, '2023-11-29');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (60, 4, '2022-06-07');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (61, 15, '2023-09-30');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (62, 14, '2021-05-30');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (63, 12, '2023-05-24');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (64, 19, '2021-07-25');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (65, 7, '2023-05-01');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (66, 2, '2022-09-29');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (67, 19, '2022-05-22');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (68, 10, '2022-04-26');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (69, 8, '2023-10-11');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (70, 14, '2023-08-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (71, 15, '2021-08-01');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (72, 21, '2023-07-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (73, 14, '2022-08-09');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (74, 21, '2022-12-30');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (75, 17, '2023-07-12');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (76, 22, '2022-03-20');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (77, 10, '2023-04-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (78, 2, '2023-07-09');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (79, 12, '2023-11-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (80, 21, '2022-01-22');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (81, 6, '2021-06-01');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (82, 7, '2022-07-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (83, 11, '2022-05-05');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (84, 7, '2022-11-22');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (85, 4, '2022-04-10');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (86, 7, '2021-07-27');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (87, 1, '2023-01-29');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (88, 1, '2022-01-16');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (89, 22, '2021-07-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (90, 22, '2021-12-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (91, 10, '2024-04-02');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (92, 16, '2022-05-16');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (93, 21, '2022-04-20');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (94, 17, '2023-06-05');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (95, 15, '2024-02-13');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (96, 16, '2021-08-21');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (97, 13, '2023-04-03');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (98, 8, '2023-08-27');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (99, 13, '2023-03-08');
insert into objednavka (id_objednavky, id_zamestnance, datum) values (100, 2, '2022-06-13');

SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Objednavka', 'id_objednavky'), 100);

INSERT INTO Provozovna (id_provozovny, id_vlastnika, adresa, nazev, telefonni_cislo, web) VALUES
(1, 1, 'Na Příkopě 23, 110 00 Praha 1', 'Kebab Palace', '224 001 122', 'www.kebabpalace.cz'),
(2, 2, 'Václavské náměstí 45, 110 00 Praha 1', 'Shawarma King', NULL, 'www.shawarmaking.cz'),
(3, 3, 'Jindřišská 16, 110 00 Praha 1', 'Falafel Queen', '224 002 123', NULL),
(4, 4, 'Opletalova 19, 110 00 Praha 1', 'Arabian Bites', NULL, NULL),
(5, 5, 'Dlouhá 29, 110 00 Praha 1', 'Hummus Home', '224 003 124', 'www.hummushome.cz'),
(6, 6, 'Národní 33, 110 00 Praha 1', 'Pita Pan', '224 004 125', NULL),
(7, 7, 'Karlova 12, 110 00 Praha 1', 'Grill & Kebab', NULL, 'www.grillkebab.cz'),
(8, 8, 'Panská 2, 110 00 Praha 1', 'Meat & Eat', NULL, NULL),
(9, 9, 'Rytířská 10, 110 00 Praha 1', 'Quick Kebab', '224 005 126', 'www.quickkebab.cz'),
(10, 10, 'Revoluční 8, 110 00 Praha 1', 'Kebab Corner', NULL, NULL),
(11, 11, 'Platnéřská 9, 110 00 Praha 1', 'Falafel Spot', '224 006 127', 'www.falafelspot.cz'),
(12, 12, 'Bílkova 19, 110 00 Praha 1', 'Spicy Kebab', NULL, 'www.spicykebab.cz'),
(13, 13, 'Elisky Krasnohorske 10, 110 00 Praha 1', 'Baba Ganoush Bistro', '224 007 128', NULL),
(14, 14, 'Kozi 9, 110 00 Praha 1', 'The Kebab House', NULL, NULL),
(15, 15, 'U Obecního dvora 4, 110 00 Praha 1', 'Arabian Delight', '224 008 129', 'www.arabiandelight.cz'),
(16, 1, 'Křižíkova 101, 186 00 Praha 8', 'Desert Oasis', '224 009 130', 'www.desertoasis.cz'),
(17, 2, 'Náměstí Republiky 7, 110 00 Praha 1', 'Eastern Delights', '224 010 131', 'www.easterndelights.cz'),
(18, 3, 'Na Florenci 2116/15, 110 00 Praha 1', 'Sahara Snacks', '224 011 132', 'www.saharasnacks.cz'),
(19, 4, 'Náměstí Míru 820/9, 120 00 Praha 2', 'Camel Cuisine', '224 012 133', 'www.camelcuisine.cz'),
(20, 5, 'Vinohradská 1511/230, 130 00 Praha 3', 'Bedouin Bites', '224 013 134', 'www.bedouinbites.cz');


SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('Provozovna', 'id_provozovny'), 20);

insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (1, 1);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (2, 2);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (3, 3);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (4, 4);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (5, 5);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (6, 6);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (7, 7);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (8, 8);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (9, 9);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (10, 10);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (11, 11);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (12, 12);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (13, 13);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (14, 14);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (15, 15);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (16, 16);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (17, 17);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (18, 18);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (19, 19);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (20, 20);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (21, 8);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (22, 6);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (23, 3);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (24, 11);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (1, 11);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (25, 11);
insert into zamestnanec_provozovna (id_zamestnance, id_provozovny) values (25, 1);



insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (1, 17, 29, '2022-11-12', 5, 'Google recenze');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (2, 17, 35, '2023-04-06', 5, 'Foodora');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (3, 15, 32, '2023-07-17', 2, 'Wolt');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (4, 5, 27, '2022-06-15', 5, 'Bolt Food');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (5, 17, 15, '2023-07-11', 3, 'Google recenze');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (6, 5, 25, '2022-06-02', 3, 'Foodora');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (7, 2, 21, '2022-11-26', 4, 'Bolt Food');
insert into recenze (id_recenze, id_provozovny, id_zakaznika, datum, hodnoceni, platforma) values (8, 5, 7, '2022-08-21', 3, 'Wolt');



SELECT SETVAL(PG_GET_SERIAL_SEQUENCE('recenze', 'id_recenze'), 8);

INSERT INTO fyzicka_osoba(id_vlastnika, jmeno, prijmeni, datum_narozeni) VALUES
(1, 'Youssef', 'Al-Mansoori', '1985-04-15'),
(2, 'Aya', 'Al-Hassan', '1990-08-23'),
(3, 'Karim', 'Al-Farouk', '1982-11-02'),
(4, 'Layla', 'Al-Mahdi', '1976-06-30'),
(5, 'Nasser', 'Al-Farsi', '1988-03-17'),
(6, 'Sanaa', 'Al-Hajjar', '1995-01-11'),
(7, 'Amir', 'Al-Ahmed', '1980-09-05'),
(8, 'Safia', 'Al-Abadi', '1973-12-28'),
(9, 'Omar', 'Al-Saleh', '1993-07-20'),
(10, 'Lina', 'Al-Khatib', '1979-05-09'),
(11, 'Hassan', 'Al-Ghazali', '1987-10-14');

INSERT INTO pravnicka_osoba(ID_VLASTNIKA, NAZEV_SPOLECNOSTI, SPOLEHLIVOST) VALUES
(12,'Donner Kebab s.r.o.',54),
(13,'Kebab Star a.s.',NULL),
(14,'Turkisch Paradise s.r.o.',96),
(15,'Cheap food for students s.r.o.',7);

insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (4, 1, 17, 5);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (49, 2, 17, 26);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (3, 3, 17, 5);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (50, 4, 16, 6);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (19, 5, 13, 25);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (42, 6, 10, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (24, 7, 3, 32);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (9, 8, 12, 29);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (8, 9, 9, 33);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (44, 10, 18, 8);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (23, 11, 8, 22);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (14, 12, 3, 27);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (28, 13, 7, 10);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (46, 14, 10, 15);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (24, 15, 2, 11);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (41, 16, 7, 23);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (47, 17, 6, 6);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (35, 18, 8, 19);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (40, 19, 18, 34);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (40, 20, 10, 3);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (44, 21, 5, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (15, 22, 20, 12);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (20, 23, 3, 35);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (26, 24, 17, 26);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (20, 25, 14, 23);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (9, 26, 18, 14);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (3, 27, 11, 22);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (15, 28, 18, 3);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (38, 29, 9, 24);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (36, 30, 9, 11);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (7, 31, 20, 16);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (28, 32, 6, 24);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (14, 33, 3, 13);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (28, 34, 7, 29);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (32, 35, 9, 13);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (7, 36, 7, 13);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (34, 37, 17, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (26, 38, 18, 12);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (3, 39, 4, 3);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (29, 40, 1, 22);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (33, 41, 12, 11);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (2, 42, 10, 28);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (33, 43, 12, 25);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (3, 44, 10, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (22, 45, 20, 9);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (8, 46, 19, 32);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (46, 47, 6, 2);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (32, 48, 13, 28);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (4, 49, 12, 34);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (39, 50, 11, 10);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (40, 51, 14, 18);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (39, 52, 20, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (5, 53, 16, 2);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (37, 54, 15, 5);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (42, 55, 11, 13);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (12, 56, 9, 32);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (2, 57, 10, 33);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (18, 58, 5, 27);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (30, 59, 5, 14);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (19, 60, 2, 35);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (45, 61, 8, 11);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (13, 62, 19, 15);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (17, 63, 14, 12);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (20, 64, 18, 27);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (34, 65, 12, 18);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (48, 66, 4, 30);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (28, 67, 20, 28);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (49, 68, 14, 6);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (34, 69, 8, 1);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (2, 70, 13, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (14, 71, 8, 8);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (40, 72, 9, 19);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (48, 73, 12, 3);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (42, 74, 3, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (36, 75, 14, 18);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (44, 76, 19, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (25, 77, 17, 6);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (20, 78, 19, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (16, 79, 4, 31);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (9, 80, 8, 1);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (43, 81, 14, 5);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (6, 82, 11, 19);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (4, 83, 2, 30);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (38, 84, 9, 24);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (39, 85, 3, 27);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (50, 86, 10, 14);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (9, 87, 11, 9);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (43, 88, 9, 35);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (46, 89, 11, 33);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (13, 90, 8, 12);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (39, 91, 6, 18);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (47, 92, 17, 35);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (25, 93, 9, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (1, 94, 13, 28);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (46, 95, 14, 20);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (31, 96, 5, 9);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (44, 97, 3, 13);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (19, 98, 17, 9);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (33, 99, 8, 17);
insert into id_objednavky (id_jidla, id_objednavky, id_provozovny, id_zakaznika) values (34, 100, 20, 22);



