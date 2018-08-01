//
//  AppDelegate.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/27/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import UIKit
import Localize
import ReSwift
import ReSwiftRouter

var store = Store<AppState>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var router: Router<AppState>!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let localize = Localize.shared
    // Set your localize provider.
    localize.update(provider: .json)
    // Set your file name
    localize.update(fileName: "lang")
    // Set your default language.
    localize.update(defaultLanguage: "en")

    window = UIWindow(frame: UIScreen.main.bounds)
    
    /*
     Set a dummy VC to satisfy UIKit
     Router will set correct VC throug async call which means
     window would not have rootVC at completion of this method
     which causes a crash.
     */
    window?.rootViewController = UIViewController()
    
    let rootRoutable = AppRoute(window: window!)
    
    router = Router(store: store, rootRoutable: rootRoutable) { state in
      state.select { $0.navigationState }
    }

    store.dispatch(ReSwiftRouter.SetRouteAction([accountWizardRoute]))

//    if case .loggedIn(_) = store.state.authenticationState.loggedInState {
//      store.dispatch(ReSwiftRouter.SetRouteAction([mainRoute]))
//    } else {
//      store.dispatch(ReSwiftRouter.SetRouteAction([loginRoute]))
//    }
    
    window?.makeKeyAndVisible()

    return true
  }

}

extension AppDelegate: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController,
                        shouldSelect viewController: UIViewController) -> Bool {
 
    switch viewController {
    case _ as BalanceViewController:
      store.dispatch(SetRouteAction(["Main", BalanceViewController.identifier]))
    case _ as HistoryViewController:
      store.dispatch(SetRouteAction(["Main", HistoryViewController.identifier]))
    case _ as AccountsViewController:
      store.dispatch(SetRouteAction(["Main", AccountsViewController.identifier]))
    case _ as SettingsViewController:
      store.dispatch(SetRouteAction(["Main", SettingsViewController.identifier]))
    default: break
    }

    return false
  }
  
}
