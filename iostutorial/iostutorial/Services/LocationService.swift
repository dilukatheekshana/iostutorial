//
//  LocationService.swift
//  iostutorial
//
//  Created by Student3 on 2026-07-08.
//

import Foundation
import CoreLocation
internal import Combine

final class LocationService: NSObject, ObservableObject
{
    static let shared = LocationService()

    @Published var currentLocation: CLLocation?

    private let manager = CLLocationManager()

    private override init()
    {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission()
    {
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation()
    {
        manager.requestLocation()
    }
    
    func refreshLocation()
    {
        manager.requestLocation()
    }
}


extension LocationService: CLLocationManagerDelegate
{
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        currentLocation = locations.first
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Location Error:", error.localizedDescription)
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus
        {
        case .authorizedAlways,
             .authorizedWhenInUse:

            requestLocation()

        default:
            break
        }
    }
}
