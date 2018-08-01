//
//  Routes.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import UIKit
import ReSwiftRouter

let mainRoute: RouteElementIdentifier = "Main"
let accountWizardRoute: RouteElementIdentifier = "AccountWizard"
let storyboard = UIStoryboard(name: "Main", bundle: nil)

let mainVcId = "MainViewController"
let accountWizardVcId = "AccountWizardViewController"

class AppRoute: Routable {
  
  let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }
  
  func setToAccountWizardViewController() -> Routable {
    self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: accountWizardVcId)
    return AddAccountRoute(self.window.rootViewController! as! UINavigationController)
  }
  
  func setToMainViewController() -> Routable {
    self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: mainVcId)
    return MainRoute(self.window.rootViewController! as! UITabBarController)
  }
  
  func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    if to == accountWizardRoute {
      completionHandler()
      return self.setToAccountWizardViewController()
    } else if to == mainRoute {
      completionHandler()
      return self.setToMainViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
  
  func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    if routeElementIdentifier == accountWizardRoute {
      completionHandler()
      return self.setToAccountWizardViewController()
    } else if routeElementIdentifier == mainRoute {
      completionHandler()
      return self.setToMainViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
  
  func popRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) {
    // TODO: this should technically never be called -> bug in router
    completionHandler()
  }
  
}
