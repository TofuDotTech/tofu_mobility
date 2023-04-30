import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";

export async function getRutaParadas(req: Request, res: Response) {
  const rutas = await prisma.rutas.findMany({
    include: {
      paradas: true
    }
  });
  res.status(200).send({ rutas: rutas });
}

export async function getRutas(req: Request, res: Response) {
  const rutas = await prisma.rutas.findMany();
  res.status(200).send({ rutas: rutas });
}
