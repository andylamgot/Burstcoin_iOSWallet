//
//  AccountsReducer.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift

func accountsReducer(action: Action, state: AccountsState?) -> AccountsState {
  let state = state ?? AccountsState(accounts: [])
  return state
}
