import { Router } from "@awaitjs/express";
import { getRutaParadas, getRutas } from "../../controller/v1/rutas.controller.js";
const router = Router();

router.postAsync('/', getRutas);
router.postAsync('/paradas', getRutaParadas);

export default router;
