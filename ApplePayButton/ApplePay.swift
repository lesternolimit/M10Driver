//
//  ApplePay.swift
//  UberClone
//
//  Created by lester on 20/09/2024.
//


import SwiftUI
import PassKit

struct ApplePayView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
        var parent: ApplePayView

        init(_ parent: ApplePayView) {
            self.parent = parent
        }

        func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
            // Gérer la validation du paiement ici...
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }

        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    }

    func makeUIViewController(context: Context) -> PKPaymentAuthorizationViewController {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "your.merchant.id"
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Course", amount: NSDecimalNumber(string: "10.00"))
        ]

        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        controller?.delegate = context.coordinator
        return controller!
    }

    func updateUIViewController(_ uiViewController: PKPaymentAuthorizationViewController, context: Context) {}
}
