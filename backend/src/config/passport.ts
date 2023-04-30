import { ExtractJwt, Strategy } from 'passport-jwt';
import { readFileSync } from 'fs';
import { prisma } from './dataSource.js';
import type { PassportStatic } from 'passport';

const PUB_KEY = readFileSync(new URL('../../id_rsa_pub.pem', import.meta.url), 'utf8');

const options = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: PUB_KEY,
  algorithms: ['RS256']
};

export default (passport: PassportStatic) => {
  passport.use(
    new Strategy(options, async (payload, done) => {
      try {
        const user = await prisma.usuarios.findUnique({
          where: {
            id: payload.sub
          }
        })
        if (user !== null) return done(null, user);
        return done(null, false);
      }
      catch (err) {
        return done(err, false);
      }
    })
  );
}
