//
//  FetchMarketAction.swift
//  Burstcoin
//
//  Created by Andy Prock on 6/9/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import ReSwift

func fetchMarketData(state: AppState, store: Store<AppState>) -> FetchMarketDataAction {
  Market.getTickerFor(id: 573, currency: "BTC") {
    tickers in
    print(tickers)
  }
  
  return FetchMarketDataAction()
}

struct FetchMarketDataAction: Action {
}
