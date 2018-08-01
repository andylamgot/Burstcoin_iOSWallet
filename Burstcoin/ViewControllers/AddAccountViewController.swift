//
//  AddAccountViewController.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/22/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

import UIKit
import ReSwift
import ReSwiftRouter

class AddAccountViewController: UIViewController {

  typealias StoreSubscriberStateType = AppState

  @IBAction func importAccount(_ sender: UIButton) {
    store.dispatch(ReSwiftRouter.SetRouteAction([accountWizardRoute, ImportAccountViewController.identifier]))
  }

  @IBAction func createAccount(_ sender: UIButton) {
    store.dispatch(ReSwiftRouter.SetRouteAction([mainRoute]))
  }
}
