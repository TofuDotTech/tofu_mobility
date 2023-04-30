import type { usuarios } from "@prisma/client";

declare module 'express-serve-static-core' {
  interface Request {
    usuarios?: usuarios;
  }
}
