create database if not exists dbsistema;

use dbsistema;

create table if not exists usuario
(
    id       varchar(6)   not null primary key,
    nombre   varchar(50)  null,
    apellido varchar(50)  null,
    email    varchar(100) null
);


select *
from usuario;