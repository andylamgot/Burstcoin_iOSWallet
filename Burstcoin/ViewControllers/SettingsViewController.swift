//
//  SettingsViewController.swift
//  Burstcoin
//
//  Created by Andy Prock on 5/28/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class SettingsViewController: UIViewController, StoreSubscriber {
  
  typealias StoreSubscriberStateType = AppState
  
  static let identifier = "SettingsViewController"
  
  func newState(state: AppState) {
    // TODO
  }
  
}
