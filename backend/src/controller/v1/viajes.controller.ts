import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";
import { io, socketMap } from "../../app.js";

const estado = {
  estado: false
}

export async function getViajes(req: Request, res: Response) {
  const viajes = await prisma.viajes.findMany({
    where: {
      usuarioId: req.account!.id,
    },
    select: {
      inicio: true,
      transportes: {
        select: {
          placas: true,
          conductores: true,
        },
      },
    },
  });
  res.status(200).send({ success: true, viajes: viajes });
}

export async function getViaje(req: Request, res: Response) {
  const viajeId: string = req.body.viajeId;
  const viaje = await prisma.viajes.findUnique({
    where: {
      id: viajeId,
    },
    include: {
      transportes: {
        select: {
          placas: true,
          conductores: true,
        },
      },
    },
  });
  res.status(200).send({ success: true, viaje: viaje });
}

export async function createViaje(req: Request, res: Response) {
  const usuarioId = req.account!.id;
  const inicio = new Date();
  const transporteId: string = req.body.transporteId;
  const paradaInicio: string = req.body.paradaInicio;
  const viaje = await prisma.viajes.create({
    data: {
      usuarioId: usuarioId,
      inicio: inicio,
      transporteId: transporteId,
      paradaInicio: paradaInicio
    },
    include: {
      usuario: true,
      transportes: true,
      paradas_viajes_paradaInicioToparadas: true
    }
  });
  io.to(socketMap.get(usuarioId)).emit("empiezaViaje", viaje);
  io.to(transporteId).emit("nuevoPasajero", 1);
  res.status(200).send({ success: true });
}

export async function cambiarEstado(req: Request, res: Response) {
  estado.estado = !estado.estado;
  res.status(200).send({ success: true });
}

export async function verEstado(req: Request, res: Response) {
  res.status(200).send({ success: true, estado: estado.estado });
}
