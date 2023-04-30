import { Router } from "@awaitjs/express";
import { getRutaTransporte, getTransporte, getTransportesRuta } from "../../controller/v1/transportes.controller.js";
const router = Router();

router.postAsync('/', getTransportesRuta);
router.postAsync('/id', getTransporte);
router.postAsync('/ruta', getRutaTransporte);

export default router;
