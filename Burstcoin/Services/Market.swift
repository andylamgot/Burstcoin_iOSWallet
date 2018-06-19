//
//  Market.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

struct Market {

  static func getTickerFor(id: Int, currency: String, completion: @escaping ([MarketResponse]) -> Void) {
    let urlString = "https://api.coinmarketcap.com/v2/ticker/\(id)/?convert=\(currency)"
    let urlRequest: URLRequest = URLRequest(url: URL(string: urlString)!)
    let session = URLSession.shared
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
      guard error == nil else {
        completion([])
        return
      }
      
      do {
        let ticker = try Market.parseResponse(data!)
        DispatchQueue.main.async {
          completion([ticker])
        }
      } catch {
        fatalError("Could not fetch/parse image urls from the server")
      }
    }
    
    task.resume()
  }

  static func parseResponse(_ responseData: Data) throws -> MarketResponse {
    let decoder = JSONDecoder()
    return try decoder.decode(MarketResponse.self, from: responseData)
  }

}
