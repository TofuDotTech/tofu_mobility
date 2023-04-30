import { Request, Response } from "express";
import { prisma } from "../../config/dataSource.js";

export async function getParadaTransporte(req: Request, res: Response) {
  const paradaId: string = req.body.paradaId;
  const parada = await prisma.paradas.findUnique({
    where: {
      id: paradaId,
    },
  });
  const camionProximo = await prisma.transportes.findFirst({
    where: {
      paradas: {
        numero: {
          lte: parada?.numero,
        },
      },
    },
    include: {
      conductores: {
        include: {
          usuarios: {
            select: {
              nombre: true
            }
          }
        }
      },
      _count: {
        select: {
          viajes: true,
        },
      },
    },
  });
  res
    .status(200)
    .send({ success: true, parada: parada, camionProximo: camionProximo });
}

export async function getParadas(req: Request, res: Response) {
  const oneHourLess = new Date();
  oneHourLess.setHours(oneHourLess.getHours() - 1);
  const paradas = await prisma.paradas.findMany({
    include: {
      viajes_viajes_paradaInicioToparadas: {
        where: {
          inicio: {
            gte: oneHourLess,
          },
        },
      },
      _count: {
        select: {
          viajes_viajes_paradaInicioToparadas: true,
        },
      },
    },
    orderBy: {
      viajes_viajes_paradaInicioToparadas: {
        _count: "desc",
      },
    },
  });
  res.status(200).send({ success: true, paradas: paradas });
}

export async function getSiguienteParada(req: Request, res: Response) {
  const numeroParadaActual = await prisma.usuarios.findUnique({
    where: {
      id: req.account!.id,
    },
    select: {
      conductores: {
        select: {
          transportes: {
            select: {
              paradas: {
                select: {
                  numero: true,
                  rutaId: true,
                },
              },
            },
          },
        },
      },
    },
  });
  if (numeroParadaActual?.conductores[0].transportes.paradas === null)
    return res
      .status(400)
      .send({
        success: false,
        message: "no hay parada actual",
      }) as unknown as void;
  const siguienteParada = await prisma.paradas.findFirst({
    where: {
      numero:
        numeroParadaActual!.conductores[0].transportes.paradas!.numero + 1,
      rutaId: numeroParadaActual!.conductores[0].transportes.paradas!.rutaId,
    },
  });
  return res
    .status(200)
    .send({ success: true, siguienteParada }) as unknown as void;
}

export async function updateSiguienteParada(req: Request, res: Response) {
  const numeroParadaActual = await prisma.usuarios.findUnique({
    where: {
      id: req.account!.id,
    },
    select: {
      conductores: {
        select: {
          transportes: {
            select: {
              id: true,
              paradas: {
                select: {
                  numero: true,
                  rutaId: true,
                },
              },
            },
          },
        },
      },
    },
  });
  if (numeroParadaActual?.conductores[0].transportes.paradas === null)
    return res
      .status(400)
      .send({
        success: false,
        message: "no hay parada actual",
      }) as unknown as void;
  const siguienteParada = await prisma.paradas.findFirst({
    where: {
      numero:
        numeroParadaActual!.conductores[0].transportes.paradas!.numero + 1,
      rutaId: numeroParadaActual!.conductores[0].transportes.paradas!.rutaId,
    },
  });
  if (siguienteParada === null)
    return res
      .status(400)
      .send({
        success: false,
        message: "no hay siguiente parada",
      }) as unknown as void;
  const transporteId = numeroParadaActual!.conductores[0].transportes.id;
  await prisma.transportes.update({
    where: {
      id: transporteId,
    },
    data: {
      paradaActual: siguienteParada.id,
    },
  });
  return res.status(200).send({ success: true }) as unknown as void;
}
