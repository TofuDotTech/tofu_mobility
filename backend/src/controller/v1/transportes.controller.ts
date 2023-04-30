import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";
import { ParadaTransporte } from "../../types/custom.js";

export async function getTransportesRuta(req: Request, res: Response) {
  const rutaId: string = req.body.rutaId;
  const transportes = await prisma.rutas.findUnique({
    where: {
      id: rutaId,
    },
    select: {
      paradas: {
        select: {
          transportes: true,
        },
      },
    },
  });
  res.status(200).send({ success: true, transportes: transportes });
}

export async function getTransporte(req: Request, res: Response) {
  const transporteId: string = req.body.transporteId;
  const transporte = await prisma.transportes.findUnique({
    where: {
      id: transporteId,
    },
    include: {
      conductores: true,
      _count: {
        select: {
          viajes: true,
        },
      },
    },
  });
  res.status(200).send({ success: true, transporte: transporte });
}

export async function getRutaTransporte(req: Request, res: Response) {
  const transporteId: string = req.body.transporteId;
  const ruta = await prisma.transportes.findUnique({
    where: {
      id: transporteId,
    },
    select: {
      paradas: {
        select: {
          rutaId: true,
        },
      },
    },
  });
  if (ruta === null)
    return res.status(400).send({ success: false }) as unknown as void;
  const paradas = await prisma.paradas.findMany({
    where: {
      rutaId: ruta.paradas?.rutaId,
    },
    orderBy: {
      numero: "asc",
    },
  });
  const deshabilitadas = await prisma.paradasDeshabilitadas.findMany({
    where: {
      transporteId: transporteId,
    },
  });
  const paradasRuta = new Array<ParadaTransporte>();
  for (let i = paradas.length - 1; i > -1; i--) {
    const temp = paradas[i] as ParadaTransporte;
    temp.habilitada =
      deshabilitadas.find((element) => element.id === temp.id) === undefined;
    paradasRuta.push(temp);
  }
  res.status(200).send({ success: true, paradas: paradasRuta });
}
