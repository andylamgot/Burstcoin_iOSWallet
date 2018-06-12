//
//  AppState.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/27/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
  var navigationState: NavigationState
  var accountsState: AccountsState
}
