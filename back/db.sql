create table usuarios(
  id varchar(36) not null,
  tipo int not null,
  tarjeta varchar(70) unique,
  PRIMARY KEY(id)
);

CREATE TABLE notificaciones (
  id varchar(36) not null,
  origen varchar(36) not null,
  destino varchar(36) not null,
  mensaje varchar(1000) not null,
  FOREIGN KEY(origen) REFERENCES usuarios(id),
  FOREIGN KEY(destino) REFERENCES usuarios(id),
  PRIMARY KEY(id)
);

CREATE TABLE paradas (
  id varchar(36) not null,
  nombre varchar(100) not null,
  rutaId varchar(36) not null,
  PRIMARY KEY(id),
  FOREIGN KEY(rutaId) REFERENCES rutas(id)
);

CREATE TABLE transportes (
  id varchar(36) not null,
  paradaActual varchar(36),
  espaciosReservados int not null,
  modelo varchar(100) not null,
  placas varchar(10) not null,
  capacidad int not null,
  PRIMARY KEY(id),
  FOREIGN KEY(paradaActual) REFERENCES paradas(id)
);

CREATE TABLE reportes (
  id varchar(36) not null,
  transporteId varchar(36) not null,
  usuarioId varchar(36) not null,
  mensaje varchar(1000) not null,
  FOREIGN KEY(transporteId) REFERENCES transportes(id),
  FOREIGN KEY(usuarioId) REFERENCES usuarios(id),
  PRIMARY KEY(id)
);

CREATE TABLE conductores (
  id varchar(36) not null,
  usuarioId varchar(36) not null,
  transporteId varchar(36) not null,
  FOREIGN KEY(usuarioId) REFERENCES usuarios(id),
  FOREIGN KEY(transporteId) REFERENCES transportes(id),
  PRIMARY KEY(id)
);

CREATE TABLE rutas (
  id varchar(36) not null,
  nombre varchar(100) not null,
  PRIMARY KEY(id)
);

CREATE TABLE direcciones (
  id varchar(36) not null,
  origen varchar(36) not null,
  destino varchar(36) not null,
  FOREIGN KEY(origen) REFERENCES paradas(id),
  FOREIGN KEY(destino) REFERENCES paradas(id),
  PRIMARY KEY(id)
);

CREATE TABLE paradasDeshabilitadas (
  id varchar(36) not null,
  transporteId varchar(36) not null,
  paradaId varchar(36) not null,
  FOREIGN KEY(transporteId) REFERENCES transportes(id),
  FOREIGN KEY(paradaId) REFERENCES paradas(id),
  PRIMARY KEY(id)
);

CREATE TABLE viajes (
  id varchar(36) not null,
  inicio datetime not null,
  fin datetime,
  transporteId varchar(36) not null,
  paradaInicio varchar(36) not null,
  paradaFin varchar(36),
  PRIMARY KEY(id),
  FOREIGN KEY(transporteId) REFERENCES transportes(id),
  FOREIGN KEY(paradaInicio) REFERENCES paradas(id),
  FOREIGN KEY(paradaFin) REFERENCES paradas(id)
);
