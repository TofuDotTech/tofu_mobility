import { Router } from "@awaitjs/express";
import {
  getParadaTransporte,
  getParadas,
  getSiguienteParada,
  updateSiguienteParada,
} from "../../controller/v1/paradas.controller.js";
const router = Router();

router.postAsync("/all", getParadas);
router.postAsync("/siguiente", getSiguienteParada);
router.putAsync("/siguiente", updateSiguienteParada);
router.postAsync("/transporte", getParadaTransporte);

export default router;
