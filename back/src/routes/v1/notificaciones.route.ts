import { Router } from "@awaitjs/express";
import { getNotificaciones, notificarProblema } from "../../controller/v1/notificaciones.controller.js";
import passport from "passport";
const router = Router();

router.use(passport.authorize('jwt', { session: false }));

router.getAsync('/', getNotificaciones);
router.postAsync('/', notificarProblema);

export default router;
