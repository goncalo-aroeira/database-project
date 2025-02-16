drop table if exists categoria cascade;
drop table if exists categoria_simples cascade;
drop table if exists super_categoria cascade;
drop table if exists tem_outra cascade;
drop table if exists produto cascade;
drop table if exists tem_categoria cascade;
drop table if exists IVM cascade;
drop table if exists ponto_de_retalho cascade;
drop table if exists instalada_em cascade;
drop table if exists prateleira cascade;
drop table if exists planograma cascade;
drop table if exists retalhista cascade;
drop table if exists responsavel_por cascade;
drop table if exists evento_reposicao cascade;



create table categoria (
    nome_categoria varchar(100) not null,
    primary key (nome_categoria) 
);


create table categoria_simples (
    nome_categoria varchar(100) not null,

    primary key (nome_categoria),
    foreign key (nome_categoria) references categoria(nome_categoria) on delete cascade
);


create table super_categoria (
    nome_categoria varchar(100) not null,

    primary key (nome_categoria),
    foreign key (nome_categoria) references categoria on delete cascade
);

create table tem_outra (
    super_categoria varchar(100) not null,
    categoria_filha varchar(100) not null,

    primary key (categoria_filha),
    foreign key (super_categoria) references super_categoria(nome_categoria) on delete cascade,
    foreign key (categoria_filha) references categoria(nome_categoria) on delete cascade
);



create table produto (
    ean char(13) not null,
    nome_categoria varchar(100) not null,
    descr varchar(100),

    primary key (ean),
    foreign key (nome_categoria) references categoria(nome_categoria) on delete cascade 
);


create table tem_categoria (
    ean char(13) not null,
    nome_categoria varchar(100) not null,

    primary key (ean, nome_categoria),
    foreign key (ean) references produto(ean) ,
    foreign key (nome_categoria) references categoria(nome_categoria) on delete cascade
);


create table IVM (
    num_serie int not null,
    fabricante varchar(100) not null,
    primary key (num_serie, fabricante)
);


create table ponto_de_retalho (
    nome_ponto_de_retalho varchar(100) not null,
    distrito varchar(100) not null,
    concelho varchar(100) not null,
    primary key (nome_ponto_de_retalho)
);


create table instalada_em (
    num_serie int not null,
    fabricante varchar(100) not null,
    nome_ponto_de_retalho varchar(100) not null,

    primary key (num_serie, fabricante),
    foreign key (num_serie, fabricante) references IVM(num_serie, fabricante),
    foreign key (nome_ponto_de_retalho) references ponto_de_retalho(nome_ponto_de_retalho) 
);


create table prateleira ( 
    nro int not null,
    num_serie int not null,
    fabricante varchar(100) not null,
    altura numeric(5,2) not null,
    nome_categoria varchar(100) not null,

    primary key (nro, num_serie, fabricante),
    foreign key (num_serie, fabricante) references IVM(num_serie, fabricante) ,
    foreign key (nome_categoria) references categoria(nome_categoria) on delete cascade
);


create table planograma (
    ean char(13) not null,
    nro int not null,
    num_serie int not null,
    fabricante varchar(100) not null,
    faces int not null,
    unidades int not null,
    loc int not null,

    primary key (ean, nro, num_serie, fabricante),
    foreign key (ean) references produto(ean) ,
    foreign key (nro, num_serie, fabricante) references prateleira(nro, num_serie, fabricante) 
);

create table retalhista (
    tin int not null,
    nome_retalhista varchar(100) not null unique,
    primary key (tin)
);


create table responsavel_por (
    num_serie int not null,
    fabricante varchar(100) not null,
    tin int not null,
    nome_categoria varchar(100) not null,

    primary key (num_serie, fabricante),
    foreign key (num_serie, fabricante) references IVM(num_serie, fabricante),
    foreign key (tin) references retalhista(tin),
    foreign key (nome_categoria) references categoria(nome_categoria) on delete cascade
);


create table evento_reposicao(
    ean char(13) not null,
    nro int not null,
    num_serie int not null,
    fabricante varchar(100) not null,
    instante date  not null,
    unidades_repostas int not null,
    tin int not null,

    primary key (ean, nro, num_serie, fabricante, instante),
    foreign key (ean, nro, num_serie, fabricante) references planograma(ean, nro, num_serie, fabricante),
    foreign key (tin) references retalhista(tin)
);




insert into IVM values (1, 'MegaStore');
insert into IVM values (2, 'MegaStore');
insert into IVM values (3, 'MegaStore');
insert into IVM values (4, 'MegaStore');
insert into IVM values (5, 'MegaStore');
insert into IVM values (6, 'MegaStore');
insert into IVM values (7, 'MegaStore');
insert into IVM values (8, 'MegaStore');

insert into IVM values (2, 'Pingo Doce');
insert into IVM values (17633, 'MegaStore');
insert into IVM values (8469832, 'Bazar China');
insert into IVM values (12836, 'Lidl');

insert into categoria values ('Doces');
insert into categoria values ('Refrigerantes');
insert into categoria values ('Gomas');
insert into categoria values ('Gelados');
insert into categoria values ('Coca-Cola');
insert into categoria values ('Sumol');
insert into categoria values ('Vegetais');
insert into categoria values ('Bebidas');

insert into categoria_simples values ('Coca-Cola');
insert into categoria_simples values ('Sumol');
insert into categoria_simples values ('Gomas');
insert into categoria_simples values ('Gelados');
insert into categoria_simples values ('Vegetais');

insert into super_categoria values ('Bebidas');
insert into super_categoria values ('Doces');
insert into super_categoria values ('Refrigerantes');

insert into tem_outra values ('Bebidas', 'Refrigerantes');
insert into tem_outra values ('Doces', 'Gelados');
insert into tem_outra values ('Doces', 'Gomas');
insert into tem_outra values ('Refrigerantes', 'Coca-Cola');
insert into tem_outra values ('Refrigerantes', 'Sumol');

insert into produto values ('8374802357984', 'Gomas', 'Ursos Hussel');
insert into produto values ('8479825790484', 'Gomas', 'Party Mix Haribo');
insert into produto values ('8124687498098', 'Vegetais', 'Alface do Lidl');
insert into produto values ('7125840384736', 'Coca-Cola', 'Bidão Coca-Cola 25L');
insert into produto values ('2138648375948', 'Sumol', 'Sumol de Morango');
insert into produto values ('3145278409384', 'Gelados', 'Mini-Milk');
insert into produto values ('1274593747038', 'Gelados', 'Mega-Milk');
insert into produto values ('7439875093857', 'Vegetais', 'Espinafres');
insert into produto values ('9483856348731', 'Gelados', 'Calipo');
insert into produto values ('5875329852389', 'Bebidas', 'Top Beer');

insert into tem_categoria values ('5875329852389', 'Bebidas');

insert into prateleira values (1, 1, 'MegaStore', 10.00, 'Bebidas');
insert into prateleira values (2, 17633, 'MegaStore', 20.00, 'Gomas');
insert into prateleira values (3, 8469832, 'Bazar China', 90.00, 'Sumol');
insert into prateleira values (3, 12836, 'Lidl', 30.00 , 'Gelados');

insert into planograma values ('5875329852389', 1, 1, 'MegaStore', 1, 10, 1);
insert into planograma values ('8479825790484', 2, 17633, 'MegaStore', 2, 20, 1);
insert into planograma values ('2138648375948', 3, 8469832,  'Bazar China', 1, 10, 4);
insert into planograma values ('3145278409384', 3, 12836, 'Lidl', 2, 15, 8);

insert into ponto_de_retalho values ('Lyca Mobile', 'Lisboa', 'Campo de Ourique');
insert into ponto_de_retalho values ('Galp', 'Alentejo', 'Pouca Farinha');
insert into ponto_de_retalho values ('Herdade Aroeira', 'Setúbal', 'Comporta');
insert into ponto_de_retalho values ('Casa Brito', 'Lisboa', 'Ponte 25 de Abril');

insert into instalada_em values (1, 'MegaStore', 'Lyca Mobile');
insert into instalada_em values (17633, 'MegaStore', 'Galp');
insert into instalada_em values (8469832, 'Bazar China', 'Herdade Aroeira');
insert into instalada_em values (12836, 'Lidl', 'Casa Brito');

insert into retalhista values ('908437328', 'Jerónimo Martins');
insert into retalhista values ('903824638', 'Continente');
insert into retalhista values ('908475612', 'Lidl');
insert into retalhista values ('907258147', 'Aldi');
insert into retalhista values ('903826376', 'Mercadona');
insert into retalhista values ('903846137', 'Intermarchê');

insert into responsavel_por values (1, 'MegaStore', '908437328', 'Bebidas');
insert into responsavel_por values (17633, 'MegaStore', '903826376', 'Gomas');
insert into responsavel_por values (8469832, 'Bazar China', '907258147', 'Sumol');
insert into responsavel_por values (12836, 'Lidl', '903824638', 'Gelados');
insert into responsavel_por values (4, 'MegaStore', '908437328', 'Gomas');
insert into responsavel_por values (5, 'MegaStore', '908437328', 'Gelados');
insert into responsavel_por values (6, 'MegaStore', '908437328', 'Coca-Cola');
insert into responsavel_por values (7, 'MegaStore', '908437328', 'Sumol');
insert into responsavel_por values (8, 'MegaStore', '908437328', 'Vegetais');




insert into evento_reposicao values ('5875329852389', 1, 1, 'MegaStore', '4/8/2022', 3, '908437328');
insert into evento_reposicao values ('8479825790484', 2, 17633, 'MegaStore', '1/9/2022', 2, '903826376');
insert into evento_reposicao values ('2138648375948', 3, 8469832, 'Bazar China', '25/12/2022', 3, '907258147');
insert into evento_reposicao values ('3145278409384', 3, 12836, 'Lidl', '5/10/2022', 6, '903824638');