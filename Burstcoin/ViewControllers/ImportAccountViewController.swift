//
//  ImportAccountViewController.swift
//  Burstcoin
//
//  Created by Andy Prock on 7/22/18.
//  Copyright © 2018 PoC-Consortium. All rights reserved.
//

import Foundation

import UIKit
import ReSwift
import ReSwiftRouter

class ImportAccountViewController: UIViewController {
  static let identifier = "ImportAccountViewController"

  @IBOutlet weak var importLabel: UILabel!
  @IBOutlet weak var importDescription: UILabel!
  @IBOutlet weak var importToggle: UISwitch!
  @IBOutlet weak var inputButton: UIButton!
  @IBOutlet weak var inputText: UITextField!

  typealias StoreSubscriberStateType = AppState

  @IBAction func importToggled(_ sender: UISwitch) {
    if (sender.isOn) {
      importLabel.text = "IMPORT.ACTIVE_ACCOUNT".localized
      importDescription.text = "IMPORT.ACTIVE_ACCOUNT_DESCRIPTION".localized
      inputText.placeholder = "IMPORT.ACTIVE_ACCOUNT_INPUT_HINT".localized
      inputButton.setTitle("IMPORT.NEXT".localized, for: .normal)
    } else {
      importLabel.text = "IMPORT.OFFLINE_ACCOUNT".localized
      importDescription.text = "IMPORT.OFFLINE_ACCOUNT_DESCRIPTION".localized
      inputText.placeholder = "IMPORT.OFFLINE_ACCOUNT_INPUT_HINT".localized
      inputButton.setTitle("IMPORT.IMPORT".localized, for: .normal)
    }
  }

  @IBAction func nextButtonPressed(_ sender: UIButton) {
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "IMPORT.ACTION_BAR_TITLE".localized
  }

  // TODO : replace with https://github.com/hlineholm/RoutableUIKit
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    // Required to update the route, when this VC was dismissed through back button from
    // NavigationController, since we can't intercept the back button
    if store.state.navigationState.route == [accountWizardRoute, ImportAccountViewController.identifier] {
      store.dispatch(ReSwiftRouter.SetRouteAction([accountWizardRoute]))
    }
  }

}
