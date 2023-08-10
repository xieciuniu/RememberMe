//
//  Friends.swift
//  RememberMe
//
//  Created by Hubert Wojtowicz on 11/08/2023.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

enum CodingKeys: CodingKey {
    case profile
}

struct Friend: Comparable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var photo: Data?
    var description: String = ""
    var birthdayGift: String = ""
    var hobby: String = ""
    
    let latitude : Double
    let longitude : Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        lhs.name < rhs.name
    }
    
    static func ==(lhs: Friend, rhs: Friend) -> Bool {
        lhs.id == rhs.id
    }
}

extension CLLocationCoordinate2D {
    
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
