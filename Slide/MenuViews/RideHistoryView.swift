//
//  RideHistoryView.swift
//  UberClone
//
//  Created by lester on 23/09/2024.
//

import SwiftUI

struct RideHistoryView: View {
    var body: some View {
        VStack {
            Text("Historique des Courses")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(0..<5) { item in
                    HStack {
                        Text("Course #\(item + 1)")
                        Spacer()
                        Text("15.00 €")
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Historique des Courses")
    }
}

struct RideHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RideHistoryView()
    }
}

