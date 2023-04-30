import { Router } from "@awaitjs/express";
import { getParadaPersonas, getParadaTransporte, getParadas, getSiguienteParada, updateSiguienteParada } from "../../controller/v1/paradas.controller.js";
const router = Router();

router.getAsync('/all', getParadas);
router.getAsync('/siguiente', getSiguienteParada);
router.putAsync('/siguiente', updateSiguienteParada);
router.getAsync('/personas/:id', getParadaPersonas);
router.getAsync('/transporte/:id', getParadaTransporte);

export default router;
