//
//  BurstPublicKeyTests.swift
//  BurstcoinTests
//
//  Created by Andy Prock on 7/21/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

import XCTest
@testable import Burstcoin

class BurstPublicKeyTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testDecoding() {
    let publicKey = "a61325eec9e83d7cac55544b8eca8ea8034559bafb5834b8a5d3b6d4efb85f12"

    let decoded = try! JSONDecoder().decode(BurstPublicKey.self, from: """
      {
        "publicKey": "\(publicKey)",
        "requestProcessingTime": 1
      }
    """.data(using: .utf8)!)

    XCTAssertEqual(decoded.publicKey, publicKey)
  }
}
