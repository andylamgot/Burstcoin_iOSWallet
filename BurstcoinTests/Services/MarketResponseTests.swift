//
//  BurstAddressTests.swift
//  BurstcoinTests
//
//  Created by Andy Prock on 5/30/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import XCTest
@testable import Burstcoin

class MarketResponseTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testDecoding() {
    let decoder = JSONDecoder()
    let cmc = try! decoder.decode(MarketResponse.self, from: """
      {
        "data": {
        "id": 573,
        "name": "Burst",
        "symbol": "BURST",
        "website_slug": "burst",
        "rank": 191,
        "circulating_supply": 1946893221.0,
        "total_supply": 1946893221.0,
        "max_supply": 2158812800.0,
        "quotes": {
          "USD": {
          "price": 0.0274657,
          "volume_24h": 353308.0,
          "market_cap": 53472785.0,
          "percent_change_1h": 2.2,
          "percent_change_24h": 5.08,
          "percent_change_7d": -1.48
          },
          "EUR": {
          "price": 0.0233244448,
          "volume_24h": 300036.5164961148,
          "market_cap": 45410204.0,
          "percent_change_1h": 2.2,
          "percent_change_24h": 5.08,
          "percent_change_7d": -1.48
          }
        },
        "last_updated": 1528566848
        },
        "metadata": {
        "timestamp": 1528566581,
        "error": null
        }
      }
    """.data(using: .utf8)!)
    
    XCTAssertEqual(cmc.id, 573)
    XCTAssertEqual(cmc.name, "Burst")
    XCTAssertNil(cmc.error)
  }

}
