//
//  Crypto.h
//  Burstcoin
//
//  Created by Andy Prock on 7/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Crypto : NSObject

- (NSData*) getPublicKey:(NSString*) passPhrase;
- (NSData*) getPrivateKey:(NSString*) passPhrase;

- (NSData*) sign:(NSData*) data with:(NSString*) passPhrase;
- (BOOL) verify:(NSData*)signature publicKey:(NSData*)pubKey data:(NSData*)data;

- (NSData*) aesEncrypt: (NSData*) plainText myPrivateKey:(NSData*)privKey theirPublicKey:(NSData*)pubKey nonce:(NSData*)nonce;
- (NSData*) aesDecrypt: (NSData*) ivCiphertext myPrivateKey:(NSData*)privKey theirPublicKey:(NSData*)pubKey nonce:(NSData*)nonce;

@end
