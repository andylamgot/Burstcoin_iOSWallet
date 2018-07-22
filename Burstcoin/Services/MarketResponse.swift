//
//  MarketResponse.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

struct MarketResponse {
  
  struct GenericCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
  
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
  }
  
  enum RootKeys: String, CodingKey {
    case data, metadata
  }
  
  enum MetadataKeys: String, CodingKey {
    case timestamp, error
  }
  
  enum DataKeys: String, CodingKey {
    case id
    case name
    case symbol
    case rank
    case quotes
    
    case maxSupply = "max_supply"
    case totalSupply = "total_supply"
    case lastUpdated = "last_updated"
  }
  
  struct Quote: Codable {
    let price: Double
    let volume24h: Double
    let marketCap: Double
    let percentChange1h: Double
    let percentChange24h: Double
    let percentChange7d: Double
    
    enum CodingKeys: String, CodingKey {
      case price
      case volume24h = "volume_24h"
      case marketCap = "market_cap"
      case percentChange1h = "percent_change_1h"
      case percentChange24h = "percent_change_24h"
      case percentChange7d = "percent_change_7d"
    }
  }

  let id: Double
  let lastUpdated: Double
  let name: String
  let rank: Double
  let symbol: String
  let maxSupply: Double
  let totalSupply: Double
  let quotes: [String: Quote]
  
  let timestamp: Double
  let error: String?
}

extension MarketResponse: Decodable {
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: RootKeys.self)

    // grab the response metadata
    let metadata =
      try container.nestedContainer(keyedBy: MetadataKeys.self, forKey: .metadata)

    timestamp = try metadata.decode(Double.self, forKey: .timestamp)
    error = try metadata.decodeIfPresent(String.self, forKey: .error)
    
    // grab the response data
    let data =
      try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
    
    id = try data.decode(Double.self, forKey: .id)
    lastUpdated = try data.decode(Double.self, forKey: .lastUpdated)
    name = try data.decode(String.self, forKey: .name)
    rank = try data.decode(Double.self, forKey: .rank)
    symbol = try data.decode(String.self, forKey: .symbol)
    maxSupply = try data.decode(Double.self, forKey: .maxSupply)
    totalSupply = try data.decode(Double.self, forKey: .totalSupply)

    var quotes = [String: Quote]()
    let subContainer = try data.nestedContainer(keyedBy: GenericCodingKeys.self, forKey: .quotes)
    for key in subContainer.allKeys {
      quotes[key.stringValue] = try subContainer.decode(Quote.self, forKey: key)
    }
    self.quotes = quotes
  }
  
}
