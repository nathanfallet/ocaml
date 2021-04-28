/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

/*import UIKit
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

}*/

import SwiftUI

struct DonateView: View {
    @StateObject var viewModel = DonateViewModel()
    
    let identifiers = [
        "me.nathanfallet.OCaml.donation1",
        "me.nathanfallet.OCaml.donation2",
        "me.nathanfallet.OCaml.donation3"
    ]
    
    #if os(iOS)
    var body: some View {
        if viewModel.donations.isEmpty {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .navigationTitle("donate_title")
                .onAppear {
                    viewModel.fetchDonations(identifiers: identifiers)
                }
        } else {
            List {
                ForEach(viewModel.donations, id: \.productIdentifier) { donation in
                    HStack {
                        Text(donation.localizedTitle)
                        Spacer()
                        Text(donation.localizedPrice ?? "")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .onTapGesture {
                        viewModel.donationSelected(id: donation.productIdentifier)
                    }
                }
            }
            .listStyleInsetGroupedIfAvailable()
            .navigationTitle("donate_title")
        }
    }
    #endif
    
    #if os(macOS)
    var body: some View {
        if viewModel.donations.isEmpty {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    viewModel.fetchDonations(identifiers: identifiers)
                }
        } else {
            Form {
                ForEach(viewModel.donations, id: \.productIdentifier) { donation in
                    HStack {
                        Text(donation.localizedTitle)
                        Text(donation.localizedPrice ?? "")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Button("donate_title") {
                            viewModel.donationSelected(id: donation.productIdentifier)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    #endif
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
