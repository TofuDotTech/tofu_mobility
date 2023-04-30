import express, { json, urlencoded } from 'express';
import project_routes from './routes/projectRoute.js';
import type { Request, Response, NextFunction } from 'express';
import passport from 'passport';
import { createServer } from "http";
import config_passport from './config/passport.js';
import { configSocketServer } from './config/socket.js';

const app = express();
const httpServer = createServer(app);
const io = configSocketServer(httpServer)

config_passport(passport);

const socketMap = new Map();

app.use(function(req, res, next) {
  // Website you wish to allow to connect
  res.setHeader("Access-Control-Allow-Origin", "*");

  // Request methods you wish to allow
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, OPTIONS, PUT, PATCH, DELETE"
  );

  // Request headers you wish to allow
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  );

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  //res.setHeader('Access-Control-Allow-Credentials', true);

  // Pass to next layer of middleware
  next();
});
app.use(passport.initialize());
app.use(json());
app.use(urlencoded({ extended: true }));

app.use("/api/", project_routes);

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  console.log(err);
  res.status(500).send({ success: false, message: err.message });
});

export { httpServer, io, socketMap };
