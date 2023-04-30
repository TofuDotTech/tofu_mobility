import { Router } from "@awaitjs/express";
import { getRutaParadas, getRutas } from "../../controller/v1/rutas.controller.js";
const router = Router();

router.getAsync('/', getRutas);
router.getAsync('/paradas', getRutaParadas);

export default router;
