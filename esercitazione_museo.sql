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
    percentuale_sconto float       NOT NULL,
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
INSERT INTO utente
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
        '+39846760143', 'Borgo Gino', '28179', '02', 'Bembo ligure', 'FR');

INSERT INTO pagamento
values ('df47973f-8cb7-11eb-95a6-c8b29b8908ae', 1.5, '2020-01-18 16:15:48'),
       ('df47e5a7-8cb7-11eb-bd36-c8b29b8908ae', 1.9, '2020-12-30 15:33:05'),
       ('df47e5a8-8cb7-11eb-900e-c8b29b8908ae', 1.69, '2020-10-27 12:23:56'),
       ('df47e5a9-8cb7-11eb-87b9-c8b29b8908ae', 1.99, '2020-11-29 19:41:35'),
       ('df47e5aa-8cb7-11eb-a543-c8b29b8908ae', 1.77, '2020-09-01 02:06:21'),
       ('df47e5ab-8cb7-11eb-b2e8-c8b29b8908ae', 1.87, '2020-06-23 08:31:29'),
       ('df47e5ac-8cb7-11eb-9925-c8b29b8908ae', 1.71, '2020-10-11 21:14:13'),
       ('df47e5ad-8cb7-11eb-82cf-c8b29b8908ae', 1.83, '2020-09-13 04:50:19'),
       ('df480c02-8cb7-11eb-9975-c8b29b8908ae', 1.55, '2020-11-24 04:34:28'),
       ('df480c03-8cb7-11eb-8fb4-c8b29b8908ae', 1.86, '2020-11-23 09:00:31');
