//
//  RideType.swift
//  UberClone
//
//  Created by Sunehar Sandhu on 1/3/23.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case M10eco
    case black
    case uberXL
    case m10
    case spotify
    case van
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .M10eco: return "M10 Eco"
        case .black: return "M10 Driver"
        case .uberXL: return "M10 Tesla"
        case .m10: return "M10 Driver"
        case .spotify: return "M10 Spotify"
        case .van: return "M10 Van"
        }
    }
    
    var imageName: String {
        switch self {
        case .M10eco: return "toyota"
        case .black: return "Classe-C"
        case .uberXL: return "tesla"
        case .m10: return "skodab"
        case .spotify: return "skodab"
        case .van: return "van"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .M10eco: return 5
        case .black: return 20
        case .uberXL: return 10
        case .m10: return 4
        case .spotify: return 4
        case .van: return 4
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .M10eco: return distanceInMiles * 0.9 + baseFare
        case .black: return distanceInMiles * 1.35 + baseFare
        case .uberXL: return distanceInMiles * 1.40 + baseFare
        case .m10: return distanceInMiles * 1.25 + baseFare
        case .spotify: return distanceInMiles * 1.25 + baseFare
        case .van: return distanceInMiles * 1.35 + baseFare
        }
    }
}
