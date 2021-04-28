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

/*
*
* Adapted from
* https://github.com/GroupeMINASTE/DonateViewController
* for SwiftUI
*
*/

import Foundation
import StoreKit

class DonateViewModel: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    /// Delegate
    //public weak var delegate: DonateViewControllerDelegate?
    
    /// Donations
    @Published private(set) var donations = [SKProduct]()
    
    /// Payment queue
    private let paymentQueue = SKPaymentQueue()
    
    /// Strong reference to request
    private var request: SKProductsRequest?
    
    /// Initializer
    public override init() {
        super.init()
        
        // Add the observer
        paymentQueue.add(self)
    }
    
    /// Update donation datas
    public func fetchDonations(identifiers: [String]) {
        // Create a request
        request = SKProductsRequest(productIdentifiers: Set(identifiers))
        request?.delegate = self
        request?.start()
    }
    
    /// Handle when a row is selected
    public func donationSelected(id: String) {
        // Get the product
        guard let product = donations.first(where: { $0.productIdentifier == id }) else { return }
        
        // Create a payment
        let payment = SKPayment(product: product)
        
        // Add it to queue
        paymentQueue.add(payment)
    }
    
    /// Handle response from product request
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            // Save products
            self.donations = response.products
        }
    }
    
    /// Handle fail from product request
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    /// Handle when transactions are updated
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // Iterate transactions
        for transaction in transactions {
            // Get the corresponding donation
            if let donation = donations.first(where: { $0.productIdentifier == transaction.payment.productIdentifier }) {
                // Check the transaction state
                if transaction.transactionState == .purchased {
                    // Donation succeed
                    //delegate?.donateViewController(self, didDonationSucceed: donation)
                } else if transaction.transactionState == .failed {
                    // Donation failed
                    //delegate?.donateViewController(self, didDonationFailed: donation)
                }
                
                // End the transaction if needed
                if transaction.transactionState != .purchasing {
                    // Finish transaction if not purchasing state
                    queue.finishTransaction(transaction)
                }
            }
        }
    }
    
}
