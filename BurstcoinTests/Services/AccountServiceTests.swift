//
//  BurstAddressTests.swift
//  BurstcoinTests
//
//  Created by Andy Prock on 5/30/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import XCTest
@testable import Burstcoin

class AccountServiceTests: XCTestCase {
  var passphrase: String!
  var publicKey: String!
  var privateKey: String!
  var pin: Int!
  var id: String!

  override func setUp() {
    super.setUp()

    passphrase = "ach wie gut dass niemand weiss dass ich Rumpelstilzchen heiss"
    pin = 777666
    id = "4297397359864028267"
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testGetAccountIdFromPublicKey() {
    let ex = expectation(description: "")
    AccountService.createActiveAccount(passPhrase: passphrase).done { account in
      XCTAssertEqual(account.id, self.id)
      ex.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
