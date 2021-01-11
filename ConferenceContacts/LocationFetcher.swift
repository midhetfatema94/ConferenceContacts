//
//  LocationFetcher.swift
//  ConferenceContacts
//
//  Created by Waveline Media on 1/10/21.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationFetcher: NSObject, CLLocationManagerDelegate {

    var successHandler: ((CLLocationCoordinate2D) -> Void)?

    let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastKnownLocation = locations.first?.coordinate {
            successHandler?(lastKnownLocation)
        }
    }
}
