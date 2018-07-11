//
//  Crytpo.m
//  Burstcoin
//
//  Created by Andy Prock on 7/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

#import "Crypto.h"
#import <CommonCrypto/CommonDigest.h>

#define ECCKeyLength 32
#define ECCSignatureLength 64

extern void keygen25519(uint8_t* P, uint8_t* s, uint8_t* k);
extern int sign25519(uint8_t* v, const uint8_t* h, const uint8_t* x, const uint8_t* s);
extern void verify25519(uint8_t* Y, const uint8_t* v, const uint8_t* h, const uint8_t* P);

@implementation Crypto

- (NSData*) getPublicKey: (NSString*) passPhrase {
  uint8_t publicKey[ECCKeyLength] = {0};
  uint8_t hash[ECCKeyLength] = {0};
  
  const char *s = [passPhrase cStringUsingEncoding:NSASCIIStringEncoding];
  NSData* data = [NSData dataWithBytes:s length:strlen(s)];

  CC_SHA256(data.bytes, (CC_LONG)data.length, hash);
  keygen25519(publicKey, nil, hash);

  return [NSData dataWithBytes:publicKey length:CC_SHA256_DIGEST_LENGTH];
}

- (NSData*) getPrivateKey: (NSString*) passPhrase {
  uint8_t privateKey[ECCKeyLength] = {0};
  
  const char *s = [passPhrase cStringUsingEncoding:NSASCIIStringEncoding];
  NSData* data = [NSData dataWithBytes:s length:strlen(s)];
  
  CC_SHA256(data.bytes, (CC_LONG)data.length, privateKey);
  privateKey[31] &= 0x7F;
  privateKey[31] |= 0x40;
  privateKey[ 0] &= 0xF8;

  return [NSData dataWithBytes:privateKey length:CC_SHA256_DIGEST_LENGTH];
}

/* deterministic EC-KCDSA
 *
 *    s is the private key for signing
 *    P is the corresponding public key
 *    Z is the context data (signer public key or certificate, etc)
 *
 * signing:
 *
 *    m = hash(Z, message)
 *    x = hash(m, s)
 *    keygen25519(Y, NULL, x);
 *    r = hash(Y);
 *    h = m XOR r
 *    sign25519(v, h, x, s);
 *
 *    output (v,r) as the signature
 */
- (NSData*) sign: (NSData*) data with: (NSString*) passPhrase {
  uint8_t P[ECCKeyLength] = {0};
  uint8_t s[ECCKeyLength] = {0};

  uint8_t k[ECCKeyLength] = {0};
  const char *str = [passPhrase cStringUsingEncoding:NSASCIIStringEncoding];
  NSData* passBytes = [NSData dataWithBytes:str length:strlen(str)];
  
  CC_SHA256(passBytes.bytes, (CC_LONG)passBytes.length, k);
  keygen25519(P, s, k);

  uint8_t m[ECCKeyLength] = {0};
  CC_SHA256(data.bytes, (CC_LONG)data.length, m);
  
  uint8_t x[ECCKeyLength] = {0};
  CC_SHA256_CTX ctx;
  CC_SHA256_Init(&ctx);
  CC_SHA256_Update(&ctx, m, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Update(&ctx, s, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Final(x, &ctx);

  uint8_t Y[ECCKeyLength] = {0};
  keygen25519(Y, nil, x);
  
  uint8_t h[ECCKeyLength] = {0};
  CC_SHA256_Init(&ctx);
  CC_SHA256_Update(&ctx, m, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Update(&ctx, Y, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Final(h, &ctx);

  uint8_t v[ECCKeyLength] = {0};
  sign25519(v, h, x, s);

  uint8_t signature[ECCSignatureLength] = {0};
  memcpy(signature, v, CC_SHA256_DIGEST_LENGTH);
  memcpy(signature + CC_SHA256_DIGEST_LENGTH, h, CC_SHA256_DIGEST_LENGTH);

  return [NSData dataWithBytes: signature length: ECCSignatureLength];
}

/**
 * verification:
 *
 *    m = hash(Z, message);
 *    h = m XOR r
 *    verify25519(Y, v, h, P)
 *
 *    confirm  r == hash(Y)
 */
- (BOOL) verify:(NSData*)signature publicKey:(NSData*)pubKey data:(NSData*)data {
  uint8_t Y[ECCKeyLength] = {0};
  uint8_t v[ECCKeyLength] = {0};
  
  [signature getBytes:v length:32];

  uint8_t h[ECCKeyLength] = {0};
  [signature getBytes:h range:NSMakeRange(32, 32)];

  verify25519(Y, v, h, pubKey.bytes);
  
  uint8_t h2[ECCKeyLength] = {0};
  CC_SHA256_CTX ctx;
  CC_SHA256_Init(&ctx);
  CC_SHA256_Update(&ctx, data.bytes, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Update(&ctx, Y, CC_SHA256_DIGEST_LENGTH);
  CC_SHA256_Final(h2, &ctx);
  
  return 0 == memcmp(h, h2, CC_SHA256_DIGEST_LENGTH);
}

@end
