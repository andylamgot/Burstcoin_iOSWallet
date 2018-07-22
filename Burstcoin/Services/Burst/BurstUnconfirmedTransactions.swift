//
//  BurstUnconfirmedTransactions.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/21/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

struct BurstUnconfirmedTransactions: Decodable {
  enum DataKeys: String, CodingKey {
    case unconfirmedTransactions
  }

  let unconfirmedTransactions: [BurstTransaction]
}
