//
//  PromoCodeView.swift
//  UberClone
//
//  Created by lester on 23/09/2024.
//

import SwiftUI

struct PromoCodeView: View {
    @State private var promoCode: String = ""
    
    var body: some View {
        VStack {
            Text("Code Promo")
                .font(.largeTitle)
                .padding()
            
            TextField("Saisissez votre code promo", text: $promoCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Action d'ajout du code promo
                print("Code promo appliqué: \(promoCode)")
            }) {
                Text("Appliquer le Code Promo")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Code Promo")
    }
}

struct PromoCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PromoCodeView()
    }
}
