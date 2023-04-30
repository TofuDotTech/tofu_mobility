import { Router } from "@awaitjs/express";
import { getViaje, getViajes } from "../../controller/v1/viajes.controller.js";
const router = Router();

router.getAsync('/', getViajes);
router.getAsync(':id', getViaje);

export default router;
