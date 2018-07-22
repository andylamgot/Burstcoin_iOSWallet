//
//  Account.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation
import UIKit
import BigInt
import PromiseKit

/*
 * AccountService class
 *
 * The AccountService is responsible for communication with the Burst node.
 */
class AccountService {
  
  /*
   * Method responsible for creating a new active account from a passphrase.
   * Generates keys for an account, encrypts them with the provided key and saves them.
   */
  static func createActiveAccount(passPhrase:String, pin:String = "") -> Promise<Account> {
    return DispatchQueue.global().async(.promise) {
      let keys = Crypto.generateMasterKeys(passPhrase)!
      keys.signPrivateKey = Crypto.aesEncrypt(keys.signPrivateKey, privateKey: hashPinEncryption(pin: pin))
      keys.agreementPrivateKey = Crypto.aesEncrypt(keys.agreementPrivateKey, privateKey: hashPinEncryption(pin: pin))

      let accountId = getAccountIdFromPublicKey(publicKey: keys.publicKey)
      let address = accountId.burstAddressEncode()

      return Account(id: accountId, address: address, keys: keys, pinHash: hashPinStorage(pin: pin, publicKey: keys.publicKey), type: "active")
    }
  }

  /*
   * Method responsible for importing an offline account.
   * Creates an account object with no keys attached.
   */
  static func createOfflineAccount(address:String) -> Promise<Account> {
    return DispatchQueue.global().async(.promise) {
      return Account(id: address.burstAddressDecode()!, address: address, type: "offline")
    }
  }

  /*
   * Method responsible for activating an offline account.
   * This method adds keys to an existing account object and enables it.
   */
  static func activateAccount(account:Account, passPhrase:String, pin:String = "") -> Promise<Account> {
    return DispatchQueue.global().async(.promise) {
      let keys = Crypto.generateMasterKeys(passPhrase)!
      keys.signPrivateKey = Crypto.aesEncrypt(keys.signPrivateKey, privateKey: hashPinEncryption(pin: pin))
      keys.agreementPrivateKey = Crypto.aesEncrypt(keys.agreementPrivateKey, privateKey: hashPinEncryption(pin: pin))

      var accountCopy = account
      accountCopy.keys = keys
      accountCopy.pinHash = hashPinStorage(pin: pin, publicKey: keys.publicKey)
      accountCopy.type = "active"

      return accountCopy
    }
  }

  /*
   * Method responsible for synchronizing an account with the blockchain.
   */
  static func synchronizeAccount(account:Account) -> Promise<Account> {
    return firstly {
      when(fulfilled:
        BurstService.getBalance(account: account.id),
        BurstService.getTransactions(account: account.id),
        BurstService.getUnconfirmedTransactions(account: account.id))
    }.map { balance, transactions, unconfirmedTransactions in
      var accountCopy = account
      accountCopy.balance = Double(balance.guaranteedBalanceNQT)
      accountCopy.unconfirmedBalance = Double(balance.unconfirmedBalanceNQT)
      accountCopy.transactions = (transactions + unconfirmedTransactions) as [BurstTransaction]?

      return accountCopy
    }
  }

  private static func hashPinEncryption(pin:String) -> Data {
    let data = (pin + UIDevice.current.identifierForVendor!.uuidString).data(using: .utf8)!
    return Crypto.sha256(data)
  }

  private static func hashPinStorage(pin:String, publicKey:Data) -> Data {
    let messageData = NSMutableData()
    messageData.append(pin.data(using: .utf8)!)
    messageData.append(publicKey)
    return Crypto.sha256(messageData as Data?)
  }

  static func getAccountIdFromPublicKey(publicKey: Data) -> String {
    let hash = Crypto.sha256(publicKey)!

    // order it from lowest bit to highest / little-endian first / reverse
    let data = Data(hash.prefix(8).reversed())

    // create a biginteger based on the reversed byte/number array
    return String(BigUInt(data))
  }
}
