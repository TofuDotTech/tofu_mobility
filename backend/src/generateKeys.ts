import { generateKeyPairSync } from 'crypto';
import { writeFileSync } from 'fs';

function genKeyPair() {

  const keyPair = generateKeyPairSync('rsa', {
    modulusLength: 4096,
    publicKeyEncoding: {
      type: 'pkcs1',
      format: 'pem'
    },
    privateKeyEncoding: {
      type: 'pkcs1',
      format: 'pem'
    }
  });

  writeFileSync(new URL('../id_rsa_pub.pem', import.meta.url), keyPair.publicKey);

  writeFileSync(new URL('../id_rsa_priv.pem', import.meta.url), keyPair.privateKey);

}

genKeyPair();
