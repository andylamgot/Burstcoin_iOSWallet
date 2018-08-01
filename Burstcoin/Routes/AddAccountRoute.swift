//
//  AddAccountRoute.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/22/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import UIKit
import ReSwiftRouter

let importAccountRoute: RouteElementIdentifier = "ImportAccount"

class AddAccountRoute: Routable {
  let viewController: UINavigationController

  init(_ viewController: UINavigationController) {
    self.viewController = viewController
  }

  func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
//    if to == addAccountRoute {
//      completionHandler()
//      return self.setToAccountWizardViewController()
//    } else if to == mainRoute {
//      completionHandler()
//      return self.setToMainViewController()
//    } else {
//      fatalError("Route not supported!")
//    }
    completionHandler()
    return ImportAccountViewRoute()
  }

  public func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    switch routeElementIdentifier {
    case ImportAccountViewController.identifier:
      let importAccountViewController = storyboard.instantiateViewController(withIdentifier: ImportAccountViewController.identifier)
      self.viewController.pushViewController(
        importAccountViewController,
        animated: true
      )
      completionHandler()
      return ImportAccountViewRoute()
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

class ImportAccountViewRoute: Routable {}
