import { Router } from "@awaitjs/express";
import { cambiarEstado, createViaje, getViaje, getViajes, verEstado } from "../../controller/v1/viajes.controller.js";
import passport from "passport";
const router = Router();

router.use(passport.authorize("jwt", { session: false }));

router.postAsync("/", getViajes);
router.postAsync("/id", getViaje);
router.putAsync("/", createViaje);
router.postAsync('/estado', verEstado);
router.putAsync('/estado', cambiarEstado);

export default router;
