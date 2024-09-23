//
//  WalletView.swift
//  UberClone
//
//  Created by lester on 23/09/2024.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
        VStack {
            Text("Portefeuille")
                .font(.largeTitle)
                .padding()

            Text("Solde actuel: 50.00 €")
                .font(.title2)
                .padding()

            Spacer()
        }
        .navigationTitle("Portefeuille")
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
