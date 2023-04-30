import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";

export async function notificarProblema(req: Request, res: Response) {
  const mensaje: string = req.body.mensaje;
  const gestorId = "";
  await prisma.notificaciones.create({
    data: {
      origen: req.usuarios!.id,
      destino: gestorId,
      mensaje: mensaje
    }
  });
  res.status(200).send({ success: true });
}

export async function getNotificaciones(req: Request, res: Response) {
  const notificaciones = await prisma.notificaciones.findMany({
    where: {
      destino: req.usuarios!.id
    }
  })
  res.status(200).send({ success: true, notificaciones: notificaciones });
}
