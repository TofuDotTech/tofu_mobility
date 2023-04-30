import { pbkdf2Sync, randomBytes } from 'crypto';
import jwt from 'jsonwebtoken';
import { readFileSync } from 'fs';
import * as dotenv from 'dotenv';
dotenv.config();

const client_id = process.env.spotify_client_id;
const client_secret = process.env.spotify_client_secret;
const PRIV_KEY = readFileSync(new URL('../../id_rsa_priv.pem', import.meta.url), 'utf8');

export function validPassword(password: string, hash: string, salt: string) {
  const hashVerify = pbkdf2Sync(password, salt, 10000, 64, 'sha512').toString('hex');
  return hash === hashVerify;
}

export function genPassword(password: string) {
  const salt = randomBytes(32).toString('hex');
  const genHash = pbkdf2Sync(password, salt, 10000, 64, 'sha512').toString('hex');

  return {
    salt: salt,
    hash: genHash
  };
}

export function issueJWT(userId: string) {
  const expiresIn = '15d';
  const payload = {
    sub: userId,
    iat: Date.now()
  };
  const signedToken = jwt.sign(payload, PRIV_KEY, { expiresIn: expiresIn, algorithm: 'RS256' });
  return {
    token: "Bearer " + signedToken,
    expires: expiresIn
  }
}
