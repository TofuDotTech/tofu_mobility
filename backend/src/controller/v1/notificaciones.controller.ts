import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";
import { io, socketMap } from "../../app.js";

export async function notificarProblema(req: Request, res: Response) {
  const mensaje: string = req.body.mensaje;
  const conductorId = "64c741eb-a3e5-4fce-9125-bfc521acf91d";
  await prisma.notificaciones.create({
    data: {
      origen: req.account!.id,
      destino: conductorId,
      mensaje: mensaje,
      fechaCreacion: new Date()
    }
  });
  io.to(socketMap.get(conductorId)).emit('nuevaNotificacion', { mensaje });
  res.status(200).send({ success: true });
}

export async function getNotificaciones(req: Request, res: Response) {
  const notificaciones = await prisma.notificaciones.findMany({
    where: {
      destino: req.account!.id
    }
  })
  res.status(200).send({ success: true, notificaciones: notificaciones });
}

export async function getNotificacionNueva(req: Request, res: Response) {
  const notificacion = await prisma.notificaciones.findFirst({
    where: {
      destino: req.account!.id
    },
    orderBy: {
      fechaCreacion: 'desc'
    }
  });
  res.status(200).send({ succes: true, notificacion });
}
