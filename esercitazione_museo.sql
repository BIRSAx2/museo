create database if not exists esercitazione_museo;
use esercitazione_museo;

drop table if exists acquisto;

drop table if exists biglietto;

drop table if exists categoria;

drop table if exists evento;

drop table if exists pagamento;

drop table if exists utente;
drop table if exists articolo_aggiuntivo;



create table evento
(
    id               int auto_increment,
    titolo           varchar(255),
    data_inizio      date,
    data_fine        date,
    numero_biglietti int,
    tariffa          decimal(10, 2),
    tipo             varchar(20) CHECK ( tipo IN ('ESPOSIZIONE', 'VISITA') ),
    primary key (id)
);



create table categoria
(
    id                 int auto_increment,
    descrizione        varchar(255),
    tipo_documento     varchar(255) NOT NULL,
    percentuale_sconto float        NOT NULL,
    primary key (id)
);
create table biglietto
(
    numero        int auto_increment,
    data_validita date NOT NULL,
    categoria     int,
    evento        int  NOT NULL,
    primary key (numero),
    foreign key (categoria) references categoria (id) on update cascade,
    foreign key (evento) references evento (id) on update cascade

);


create table articolo_aggiuntivo
(
    id          int auto_increment,
    costo       float,
    descrizione varchar(255),
    tipo        varchar(20) check (tipo in ('ACCESSORIO', 'SERVIZIO')),
    primary key (id)
);


create table utente
(
#     64 char (username) +  @ +  255  domain name.
    email           varchar(320),
    password        varchar(128),
    nome            varchar(50),
    cognome         varchar(50),
    telefono        varchar(14),
    via             varchar(128),
    cap             varchar(5),
    numero_civico   varchar(20),
    citta           varchar(40),
    sigla_provincia varchar(2),
    unique (via, cap, numero_civico),
    primary key (email)
);

create table pagamento
(
    id_transazione varchar(255),
    importo        decimal(10, 2) NOT NULL,
    data           datetime default NOW(),
    primary key (id_transazione)
);

create table associazione
(
    numero              int,
    articolo_aggiuntivo int,
    primary key (numero, articolo_aggiuntivo),
    foreign key (numero) references biglietto (numero),
    foreign key (articolo_aggiuntivo) references articolo_aggiuntivo (id)
);

create table acquisto
(
    utente    varchar(320),
    pagamento varchar(255),
    biglietto int,
    primary key (utente, pagamento, biglietto),
    foreign key (utente) references utente (email) on update cascade,
    foreign key (pagamento) references pagamento (id_transazione) on update cascade,
    foreign key (biglietto) references biglietto (numero) on update cascade
);


## INSERT
## INSERT
insert into evento ( titolo, data_inizio, data_fine, numero_biglietti, tariffa, tipo)
values ('Stravaganza degli anni 80', '2021-01-14', '2021-05-21', 200, 10.5, 'VISITA'),
	   ('Le avanguardie', '2021-03-21', '2021-08-26', 250, 13.5, 'VISITA'),
	   ('L\'evoluzione del menswear', '2020-09-06', '2021-01-15', 175, 12.5, 'VISITA'),
	   ('100 icone', '2020-08-14', '2021-02-25', 300, 15, 'ESPOSIZIONE'),
	   ('Martin Margiela - un rivoluzionario', '2020-11-24', '2021-04-25', 200, 12.5, 'ESPOSIZIONE'),
	   ('Le influenze dell\'Hip Hop', '2020-11-07', '2021-05-23', 200, 10.5, 'VISITA'),
	   ('Una sfilata nel passato', '2020-03-24', '2020-09-05', 250, 13, 'ESPOSIZIONE');


insert into categoria (descrizione, tipo_documento, percentuale_sconto)
values ('Bambino (-12)', 'Carta Identità', 20),
	   ('Anziano (+65)', 'Carta Identità', 25),
	   ('Studente', 'Carta Universitaria', 15);


insert into biglietto (data_validita, categoria, evento)
values ('2021-04-23', 2, 1),
	   ('2021-06-14', 3, 2),
	   ('2021-01-15', 3, 4),
	   ('2021-02-16', 2, 5),
	   ('2020-11-21', 2, 3),
	   ('2021-02-23', 3, 6),
	   ('2020-05-12', NULL, 7),
	   ('2021-06-09', NULL, 2),
	   ('2021-06-09', 1, 2),
	   ('2021-01-23', 2, 4),
	   ('2021-02-14', NULL, 5),
	   ('2021-03-17', NULL, 1),
	   ('2021-03-17', 1, 1),
	   ('2021-03-17', 2, 1),
	   ('2020-12-16', NULL, 3),
	   ('2020-12-16', NULL, 3);


insert into articolo_aggiuntivo (costo, descrizione, tipo)
values (30, 'Cappello New Era Logo', 'ACCESSORIO'),
	   (7.5, 'Tote Bag', 'ACCESSORIO'),
	   (24, 'Maglietta Logo', 'ACCESSORIO'),
	   (15, 'Tazza Since 1993', 'ACCESSORIO'),
	   (75, 'Maglia x Comme de Garcons', 'ACCESSORIO'),
	   (30, 'Visita Guidata', 'SERVIZIO'),
	   (10, 'Visita Guidata Cuffia', 'SERVIZIO'),
	   (12, 'Visita Guidata Cuffia Multilingua', 'SERVIZIO');


insert into associazione (numero, articolo_aggiuntivo)
values (1, 1),
	   (3, 2),
	   (9, 6),
	   (5, 3),
	   (5, 1),
	   (2, 8),
	   (2, 1),
	   (6, 5),
	   (7, 7),
	   (4, 1),
	   (4, 5),
	   (4, 2);


insert into utente (email, password, nome, cognome, telefono, via, cap, numero_civico, citta, sigla_provincia)
values ('nico53@example.org', '$2b$12$02dW.34ymSC2cfDydkrYre4J6WwvdolQQCGvWn5qqDq4UmuaLoTQu', 'Sebastiano', 'Pulci',
        '+39285810810', 'Incrocio Ferdinando', '16527', '9', 'Settimo Loretta sardo', 'PT'),
       ('matteotticesare@example.net', '$2b$12$DovV.TkdJZAr1i32HoeyFu/1dkWAQ4s/NCAE9gwdz2Uw0NUnd5hI.', 'Adamo',
        'Camuccini', '+39091806973', 'Viale Lolita', '90475', '5', 'Orlando salentino', 'AO'),
       ('guido38@example.com', '$2b$12$QDMrp6f4/7wRV9yPrl03K.Lwe2DPRLeNx2TiNtKdrRnIpwH5ozGjW', 'Nanni', 'Argurio',
        '+39362951390', 'Vicolo Luria', '90610', '751', 'Nedda calabro', 'BI'),
       ('ottaviobresciani@example.com', '$2b$12$i1QflNEHZHUa5SYykpKr7e0z77jCGroeUvQORcnY4NNW.Z6VzLmp2', 'Rosaria',
        'Dovara', '+39480960264', 'Stretto Etta', '84483', '15', 'Borgo Nicolò', 'MI'),
       ('ezito@example.net', '$2b$12$Fnf3.0ZSecfOaB1zqP4/lOe/8OlR/YryRT4.QJRMmXB0lyQAAcdZS', 'Ugo', 'Filangieri',
        '+39412199808', 'Contrada Lando', '78135', '7', 'Borgo Fabio calabro', 'VS'),
       ('tbriccialdi@example.com', '$2b$12$Zz35i2yHfaJmd3zX4ueSreagkrvbRZmKBWN0s1JQW2h5rHyX48JwO', 'Carla', 'Antonello',
        '+39327111372', 'Viale Venturi', '99587', '05', 'Borgo Marco', 'AV'),
       ('fulvio61@example.org', '$2b$12$Ax1F4FVIb0ouwVFUBd6nXeSkqT0LZrfUhMHKb9iOA5j5yCFjsIZu.', 'Alfredo', 'Guarneri',
        '+39774116074', 'Borgo Barillaro', '66374', '97', 'Sesto Vincenza del friuli', 'CH'),
       ('antonina84@example.org', '$2b$12$lB0dIiUP2SyXhKqXAwn4SO9hM0ACW8lKf/MnyBcujIPAkW5oR1hX6', 'Lucrezia', 'Gotti',
        '+39735985613', 'Incrocio Granatelli', '21174', '359', 'Sesto Bartolomeo', 'CS'),
       ('fornaciaricristina@example.com', '$2b$12$ci/UGkeRVzCxwUtYaTHuUeGpuwO23davY0zEzUFbSK0k7dwmHAMFa', 'Gianni',
        'Ficino', '+39117701354', 'Strada Tina', '50386', '858', 'Salvi veneto', 'BT'),
       ('dbenussi@example.net', '$2b$12$vZF4PAZWD1IueIcITL6W0eHSbxes82AP1kxPYU9ZJhx2f87irwMyW', 'Enrico', 'Calvo',
        '+39846760143', 'Borgo Gino', '28179', '02', 'Bembo ligure', 'FR'),
       ('gennaro76@example.org', '$2b$12$qkSLMw7cNjyEqgYInRwbcGjGQLcfGksrPU4C2kyrDbrOkrJbKzMt9', 'Riccardo', 'Rossi',
        '+3978926297', 'Marco Polo', '14897', '2', 'Cissone', 'CN');


insert into pagamento (id_transazione, importo,data)
values ('df47973f-8cb7-11eb-95a6-c8b29b8908ae', 73.72, '2020-11-18 16:15:48'),
       ('df47e5a7-8cb7-11eb-bd36-c8b29b8908ae', 37.87, '2021-02-15 15:33:05'),
       ('df47e5a8-8cb7-11eb-900e-c8b29b8908ae', 122.25, '2021-01-14 12:23:56'),
       ('df47e5a9-8cb7-11eb-87b9-c8b29b8908ae', 63.37, '2020-09-19 19:41:35'),
       ('df47e5aa-8cb7-11eb-a543-c8b29b8908ae', 38.92, '2021-01-01 02:06:21'),
       ('df47e5ab-8cb7-11eb-b2e8-c8b29b8908ae', 23, '2020-04-23 08:31:29'),
       ('df47e5ac-8cb7-11eb-9925-c8b29b8908ae', 54.3, '2021-05-11 21:14:13'),
       ('df47e5ad-8cb7-11eb-82cf-c8b29b8908ae', 11.25, '2020-11-13 04:50:19'),
       ('df480c02-8cb7-11eb-9975-c8b29b8908ae', 12.5, '2021-01-24 04:34:28'),
       ('df480c03-8cb7-11eb-8fb4-c8b29b8908ae', 26.77, '2021-02-23 09:00:31'),
       ('df480c03-8cb7-11eb-u6c9-c8b29b8908ae', 25, '2020-11-23 09:00:31');


insert into acquisto (utente, pagamento, biglietto)
values ('nico53@example.org', 'df47973f-8cb7-11eb-95a6-c8b29b8908ae', 2),
	   ('nico53@example.org', 'df47973f-8cb7-11eb-95a6-c8b29b8908ae', 3),
	   ('matteotticesare@example.net', 'df47e5a7-8cb7-11eb-bd36-c8b29b8908ae', 1),
	   ('guido38@example.com', 'df47e5a8-8cb7-11eb-900e-c8b29b8908ae', 4),
	   ('ottaviobresciani@example.com', 'df47e5a9-8cb7-11eb-87b9-c8b29b8908ae', 5),
	   ('ezito@example.net', 'df47e5aa-8cb7-11eb-a543-c8b29b8908ae', 6),
	   ('tbriccialdi@example.com', 'df47e5ab-8cb7-11eb-b2e8-c8b29b8908ae', 7),
	   ('fulvio61@example.org', 'df47e5ac-8cb7-11eb-9925-c8b29b8908ae', 8),
	   ('fulvio61@example.org', 'df47e5ac-8cb7-11eb-9925-c8b29b8908ae', 9),
	   ('antonina84@example.org', 'df47e5ad-8cb7-11eb-82cf-c8b29b8908ae', 10),
	   ('fornaciaricristina@example.com', 'df480c02-8cb7-11eb-9975-c8b29b8908ae', 11),
	   ('dbenussi@example.net', 'df480c03-8cb7-11eb-8fb4-c8b29b8908ae', 12),
	   ('dbenussi@example.net', 'df480c03-8cb7-11eb-8fb4-c8b29b8908ae', 13),
	   ('dbenussi@example.net', 'df480c03-8cb7-11eb-8fb4-c8b29b8908ae', 14),
	   ('gennaro76@example.org', 'df480c03-8cb7-11eb-u6c9-c8b29b8908ae', 15),
	   ('gennaro76@example.org', 'df480c03-8cb7-11eb-u6c9-c8b29b8908ae', 16);


# I titoli e le date delle esposizioni tematiche che sono state tenute dal 1 gennaio al 31 dicembre di un determinato anno.

select titolo, data_inizio, data_fine
from evento
where tipo = 'ESPOSIZIONE'
  and year(evento.data_inizio) = 2020
  and year(evento.data_fine) = 2020;

# Numero di biglietti emessi (venduti) per una determinata esposizione

select count(b.numero)
from evento as e,
     biglietto as b,
     acquisto as a
where e.titolo = "titolo evento"
  and b.evento = e.id
  and a.biglietto = b.numero;

# Ricavato della vendita dei biglietti per una determinata esposizione

select sum(p.importo)
from evento as e,
     biglietto as b,
     acquisto as a,
     pagamento as p
where e.titolo = 'NOME EVENTO'
  and e.tipo = 'ESPOSIZIONE'
  and b.evento = e.id
  and a.biglietto = b.numero
  and p.id_transazione = a.pagamento;
