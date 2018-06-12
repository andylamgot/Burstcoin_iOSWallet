//
//  AppReducer.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/27/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
  return AppState(
    navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
    accountsState: accountsReducer(action: action, state: state?.accountsState)
  )
}
