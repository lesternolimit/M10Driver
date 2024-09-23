//
//  SupportView.swift
//  UberClone
//
//  Created by lester on 23/09/2024.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        VStack {
            Text("Support")
                .font(.largeTitle)
                .padding()

            Text("Contactez-nous pour toute assistance.")
                .font(.title2)
                .padding()
            
            Button(action: {
                // Action pour appeler ou envoyer un mail
                print("Appeler le support")
            }) {
                Text("Appeler le Support")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Support")
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
