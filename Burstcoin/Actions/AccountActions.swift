//
//  NavigationActions.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/22/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func importBurstAccount(state: AppState, store: Store<AppState>) -> Action? {
  store.dispatch(ReSwiftRouter.SetRouteAction([mainRoute]))

  return ImportBurstAccountAction()
}

struct ImportBurstAccountAction: Action {
}
