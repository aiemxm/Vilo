//
//  MapViewModel.swift
//  Vilo Stephanie
//
//  Created by Apprenant 85 on 12/12/2021.
//

import Foundation
import MapKit
import CoreLocation

enum MapDetails {
    // Paris, FR (Wikipedia decimal: 48,856613 ; 2,352222)
    static let parisLocation = CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)
    static let pizzaLocation = CLLocationCoordinate2D(latitude: 48.8697731, longitude: 2.3285281)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: MapDetails.parisLocation,
        span: MapDetails.defaultSpan)
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: self.region.span)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
