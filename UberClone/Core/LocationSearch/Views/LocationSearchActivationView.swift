//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Sunehar Sandhu on 1/3/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
                
                
            
            Text("Where to?")
                .foregroundColor(Color(.blue))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .blue, radius: 6)
                .cornerRadius(20)
                .shadow(color: .blue, radius: 20)
        )
        
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
