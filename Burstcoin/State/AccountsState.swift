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
  var keys: Keys?
  var pinHash: Data?
  var balance: Double? = 0
  var transactions: [BurstTransaction]? = []
  var type: String? = "offline"
  var selected: Bool? = false
  var unconfirmedBalance: Double? = 0

  init(id: String, address: String, keys:Keys?=nil, pinHash:Data?=nil, balance:Double?=nil, transactions:[BurstTransaction]?=nil, type:String?=nil, selected:Bool?=nil, unconfirmedBalance:Double?=nil) {
    self.id = id
    self.address=address
    self.keys=keys
    self.pinHash=pinHash
    self.balance=balance
    self.transactions=transactions
    self.type=type
    self.selected=selected
    self.unconfirmedBalance=unconfirmedBalance
  }
}

struct AccountsState: StateType {
  var accounts: [Account]
}
