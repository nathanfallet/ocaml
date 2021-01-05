//
//  CustomDonateViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import DonateViewController

class CustomDonateViewController: DonateViewController, DonateViewControllerDelegate {

    override func viewDidLoad() {
        // Set strings
        title = "donate_title".localized()
        header = "donate_header".localized()
        footer = "donate_footer".localized()
        delegate = self
        
        // Add purchases
        add(identifier: "me.nathanfallet.OCaml.donation1")
        add(identifier: "me.nathanfallet.OCaml.donation2")
        add(identifier: "me.nathanfallet.OCaml.donation3")
        
        // Call super
        super.viewDidLoad()
        
        // Add close button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "button_cancel".localized(), style: .plain, target: self, action: #selector(close(_:)))
    }
    
    @objc func close(_ sender: UIBarButtonItem) {
        // Dismiss view controller
        dismiss(animated: true, completion: nil)
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationSucceed donation: Donation) {
        let alert = UIAlertController(title: "donate_thanks".localized(), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationFailed donation: Donation) {
        print("Donation failed.")
    }

}
