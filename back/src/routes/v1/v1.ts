import { Router } from 'express';
import notificacionesRouter from './notificaciones.route.js';
import paradasRouter from './paradas.route.js';
import rutasRouter from './rutas.route.js';
import transporteRouter from './transportes.route.js';
import viajesRouter from './viajes.route.js'
const router = Router();

router.use('/notificaciones', notificacionesRouter);
router.use('/paradas', paradasRouter);
router.use('/rutas', rutasRouter);
router.use('/transportes', transporteRouter);
router.use('/viajes', viajesRouter);

export default router;
