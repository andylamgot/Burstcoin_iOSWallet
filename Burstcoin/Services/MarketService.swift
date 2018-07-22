//
//  MarketService.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import PromiseKit
import PMKFoundation

struct MarketService {

  static private func makeGetTickerRequest(id: Int, currency: String) -> URLRequest {
    let urlString = "https://api.coinmarketcap.com/v2/ticker/\(id)/?convert=\(currency)"
    return URLRequest(url: URL(string: urlString)!)
  }
  
  static func getTickerFor(id: Int, currency: String) -> Promise<MarketResponse> {
    return firstly {
      URLSession.shared.dataTask(.promise, with: makeGetTickerRequest(id: id, currency: currency))
    }.map {
      try JSONDecoder().decode(MarketResponse.self, from: $0.data)
    }
  }

}
