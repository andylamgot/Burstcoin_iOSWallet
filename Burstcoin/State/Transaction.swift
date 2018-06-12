//
//  Transaction.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/1/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

/*
 * Transaction class
 *
 * The Transaction class is a mapping for a transaction on the Burst blockchain
 */
struct Transaction {
  var id: String
  var amountNQT: Double
  // var attachment: Attachment
  var block: String
  var blockTimestamp: Double
  var confirmations: Double
  var confirmed: Bool
  var deadline: Double
  var feeNQT: Double
  var fullHash: String
  var height: Double
  var recipientId: String
  var recipientAddress: String
  var recipientPublicKey: String
  var senderId: String
  var senderAddress: String
  var senderPublicKey: String
  var signature: String
  var signatureHash: String
  var subtype: Double
  var timestamp: Double
  var type: Double
  var version: Double
}
