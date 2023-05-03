DROP DATABASE gran_dt;
CREATE DATABASE gran_dt;

CREATE TABLE usuarios (
    id int AUTO_INCREMENT PRIMARY KEY,
    mail varchar(25) NOT NULL,
    clave varchar(16) NOT NULL,
    saldo int NOT NULL,
    puntaje int NOT NULL
);

CREATE TABLE posiciones (
    id int AUTO_INCREMENT PRIMARY KEY,
    posicion varchar(10) NOT NULL
);

CREATE TABLE jugadores (
    id int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(25) NOT NULL,
    apellido varchar(25) NOT NULL,
    precio int NOT NULL,
    puntaje int NOT NULL,
    id_posicion int,
    FOREIGN KEY (id_posicion) REFERENCES posiciones(id),
    lesionado boolean
);

CREATE TABLE equipos (
    id int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(25) NOT NULL,
    id_usuario int,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE seleccionados (
    id int AUTO_INCREMENT PRIMARY KEY,
    id_jugador int,
    id_equipo int,
    FOREIGN KEY (id_jugador) REFERENCES jugadores(id),
    FOREIGN KEY (id_equipo) REFERENCES equipos(id),
    titular boolean
);