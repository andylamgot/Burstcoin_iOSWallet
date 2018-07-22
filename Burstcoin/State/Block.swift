//
//  Block.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/1/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

/*
 * Block class
 *
 * NOT USED YET. CREATED IN REGARD TO SPV: https://bitcoin.org/bitcoin.pdf - §8
 */
struct Block {
  let id: Double?
  let version: Double?
  let timestamp: Double?
  let height: Double?
  let previousBlockId: Double?
  let previousBlockHash: [Double]?
  let generatorletKey: [Double]?
  let totalAmountNQT: Double?
  let totalFeeNQT: Double?
  let playoadLength: Double?
  let generatorId: Double?
  let generationSignature: [Double]?
  let playloadHash: [Double]?
  let blockSignature: [Double]?
  let cumulativeDifficulty: Double?
  let baseTarget: Double?
  let nextBlockId: Double?
  let nonce: Double?
  let byteLength: Double?
  let pocTime:Double?
  let blockAts: [Double]?
  let transactions: [BurstTransaction]?
}
