//
//  BurstService.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/21/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import PromiseKit
import PMKFoundation

struct BurstService {
  
  /*
   * Method responsible for getting the unconfirmed transactions for the account.
   */
  static func getUnconfirmedTransactions(account:String) -> Promise<[BurstTransaction]> {
    let queryDictionary = ["requestType": "getUnconfirmedTransactions", "account": account]

    return firstly {
      URLSession.shared.dataTask(.promise, with: makeBurstRequest(queryDictionary: queryDictionary))
    }.map {
      try JSONDecoder().decode(BurstUnconfirmedTransactions.self, from: $0.data)
    }.map {
      $0.unconfirmedTransactions
    }
  }

  /*
   * Method responsible for getting the latest 15 transactions.
   */
  static func getTransactions(account:String) -> Promise<[BurstTransaction]> {
    let queryDictionary = [
      "requestType": "getAccountTransactions",
      "firstIndex": "0",
      "lastIndex": "15",
      "account": account]

    return firstly {
      URLSession.shared.dataTask(.promise, with: makeBurstRequest(queryDictionary: queryDictionary))
    }.map {
      try JSONDecoder().decode(BurstTransactions.self, from: $0.data)
    }.map {
      $0.transactions
    }
  }

  /*
   * Method responsible for getting a transaction.
   */
  static func getTransaction(transaction:String) -> Promise<BurstTransaction> {
    let queryDictionary = ["requestType": "getTransaction", "transaction": transaction]

    return firstly {
      URLSession.shared.dataTask(.promise, with: makeBurstRequest(queryDictionary: queryDictionary))
    }.map {
      try JSONDecoder().decode(BurstTransaction.self, from: $0.data)
    }
  }

  /*
   * Method responsible for getting the current balance of an account.
   */
  static func getBalance(account:String) -> Promise<BurstBalance> {
    let queryDictionary = ["requestType": "getAccountBalance", "account": account]

    return firstly {
      URLSession.shared.dataTask(.promise, with: makeBurstRequest(queryDictionary: queryDictionary))
    }.map {
      try JSONDecoder().decode(BurstBalance.self, from: $0.data)
    }
  }
  
  /*
   * Method responsible for getting the public key in the blockchain of an account.
   */
  static func getPublicKey(account:String) -> Promise<String> {
    let queryDictionary = ["requestType": "getAccountPublicKey", "account": account]
    
    return firstly {
      URLSession.shared.dataTask(.promise, with: makeBurstRequest(queryDictionary: queryDictionary))
    }.map {
      try JSONDecoder().decode(BurstPublicKey.self, from: $0.data)
    }.map {
      $0.publicKey
    }
  }
  
  static private func makeBurstRequest(queryDictionary: [String: String]) -> URLRequest {
    var components = URLComponents(string: "https://wallet.burst.cryptoguru.org:8125/burst")
    components?.queryItems = queryDictionary.map {
      URLQueryItem(name: $0, value: $1)
    }
  
    return URLRequest(url: components!.url!)
  }
}
