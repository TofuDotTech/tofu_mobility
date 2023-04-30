import { socketMap } from "../app.js";
//import { prisma } from "./dataSource.js";
import { Server as ioServer } from "socket.io";
import type { Server } from "http";

export function configSocketServer(httpServer: Server) {
  const io = new ioServer(httpServer, {
    cors: {
      origin: '*',
    }
  });

  /*io.use(async (socket, next) => {
    const id = socket.handshake.auth.id;
    try {
      const user = await prisma.usuarios.findUnique({
        where: {
          id: id
        }
      });
      if (user !== null) return next(new Error("unauthorized"));
      socket.data.user = user;
      return next();
    }
    catch (err) {
      return next(new Error("unauthorized"));
    }
  });*/

  io.on("connection", (socket) => {
    socketMap.set("64c741eb-a3e5-4fce-9125-bfc521acf91d", socket.id);

    socket.on('joinRoom', room => {
      socket.join(room);
    })
  });

  return io;
}

