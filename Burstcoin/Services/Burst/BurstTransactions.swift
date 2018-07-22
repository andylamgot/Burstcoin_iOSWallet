//
//  BurstTransactions.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/21/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

struct BurstTransactions: Decodable {
  enum DataKeys: String, CodingKey {
    case transactions
  }

  let transactions: [BurstTransaction]
}
