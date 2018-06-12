//
//  Attachment.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/1/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

/*
 * Attachment class
 *
 * The attachment class is used to appended to transaction where appropriate.
 * It is a super class for Message and EncryptedMessage.
 */
protocol Attachment {
  var type: String { get }
}

/*
 * Message class
 *
 * The Message class is used to model a plain message attached to a transaction.
 */
struct Message: Attachment {
  let type: String
  let isText: Bool
  let message: String?
  
  init(type: String, isText: Bool? = false, message: String? = nil) {
    self.type = type
    self.isText = isText!
    self.message = message!
  }
}

/*
 * EncryptedMessage class
 *
 * The EncryptedMessage class is a model for a encrypted message attached to a transaction.
 */
struct EncryptedMessage: Attachment {
  let type: String
  let isText: Bool
  let data: String?
  let nonce: String?
  
  init(type: String, isText: Bool? = false, data: String? = nil, nonce: String? = nil) {
    self.type = type
    self.isText = isText!
    self.data = data!
    self.nonce = nonce!
  }
}
