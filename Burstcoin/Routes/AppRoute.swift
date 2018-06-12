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
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let mainViewControllerIdentifier = "MainViewController"

class AppRoute: Routable {
  
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
//  func setToLoginViewController() -> Routable {
//    self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: loginViewControllerIdentifier)
//    
//    return LoginViewRoutable(self.window.rootViewController!)
//  }
  
  func setToMainViewController() -> Routable {
    self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: mainViewControllerIdentifier)
    return MainRoute(self.window.rootViewController! as! UITabBarController)
  }
  
  func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable
  {
    
    /*if to == loginRoute {
      completionHandler()
      return self.setToLoginViewController()
    } else */if to == mainRoute {
      completionHandler()
      return self.setToMainViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
  
  func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable
  {
    
    /*if routeElementIdentifier == loginRoute {
      completionHandler()
      return self.setToLoginViewController()
    } else */if routeElementIdentifier == mainRoute {
      completionHandler()
      return self.setToMainViewController()
    } else {
      fatalError("Route not supported!")
    }
  }
  
  func popRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler)
  {
    // TODO: this should technically never be called -> bug in router
    completionHandler()
  }
  
}
