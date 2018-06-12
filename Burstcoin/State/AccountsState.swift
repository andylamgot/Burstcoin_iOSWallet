//
//  Accounts.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift

/*
 * Account class
 *
 * The account class serves as a model for a Burstcoin account.
 * Each account contains its Burst address and numeric id.
 */
struct Account {
  var id: String
  var address: String
  var balance: Double? = 0
  var keys: Keys
  var pinHash: String
  var transactions: [Transaction]
  var type: String? = "offline"
  var selected = false
  var unconfirmedBalance: Double? = 0
}

struct AccountsState: StateType {
  var accounts: [Account]
}
