//
//  MainRoute.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import UIKit
import ReSwiftRouter

class MainRoute: Routable {

  let viewController: UITabBarController
  
  init(_ viewController: UITabBarController) {
    self.viewController = viewController
    
    let balanceViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "BalanceViewController")
    balanceViewController.tabBarItem.image = UIImage(named: "coins")
    let historyViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "HistoryViewController")
    historyViewController.tabBarItem.image = UIImage(named: "transactions")
    let accountsViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "AccountsViewController")
    accountsViewController.tabBarItem.image = UIImage(named: "accounts")
    let settingsViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "SettingsViewController")
    settingsViewController.tabBarItem.image = UIImage(named: "gears")
    
    viewController.viewControllers = [balanceViewController, historyViewController, accountsViewController, settingsViewController]
    viewController.delegate = UIApplication.shared.delegate as! AppDelegate
  }

  public func changeRouteSegment(_ fromSegment: RouteElementIdentifier,
                                 to: RouteElementIdentifier,
                                 animated: Bool,
                                 completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    switch to {
    case BalanceViewController.identifier:
      viewController.selectedIndex = 0
      completionHandler()
      return BalanceViewRoutable()
    case HistoryViewController.identifier:
      viewController.selectedIndex = 1
      completionHandler()
      return HistoryViewRoutable()
    case AccountsViewController.identifier:
      viewController.selectedIndex = 2
      completionHandler()
      return AccountsViewRoutable()
    case SettingsViewController.identifier:
      viewController.selectedIndex = 3
      completionHandler()
      return SettingsViewRoutable()
    default:
      abort()
    }
  }
  
  public func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    switch routeElementIdentifier {
    case BalanceViewController.identifier:
      viewController.selectedIndex = 0
      completionHandler()
      return BalanceViewRoutable()
    case HistoryViewController.identifier:
      viewController.selectedIndex = 1
      completionHandler()
      return HistoryViewRoutable()
    case AccountsViewController.identifier:
      viewController.selectedIndex = 2
      completionHandler()
      return AccountsViewRoutable()
    case SettingsViewController.identifier:
      viewController.selectedIndex = 3
      completionHandler()
      return SettingsViewRoutable()
    default:
      abort()
    }
  }
  
  public func popRouteSegment(_ viewControllerIdentifier: RouteElementIdentifier,
                              animated: Bool,
                              completionHandler: @escaping RoutingCompletionHandler) {
    // would need to unset root view controller here
    completionHandler()
  }
}

class BalanceViewRoutable: Routable {}
class HistoryViewRoutable: Routable {}
class AccountsViewRoutable: Routable {}
class SettingsViewRoutable: Routable {}
