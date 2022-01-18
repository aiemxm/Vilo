//
//  LocalSearchService.swift
//  Itineraire
//
//  Created by Maxime Bégué on 08/12/2021.
//

import Foundation
import MapKit
import Combine
import SwiftUI





final class LocalSearchService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    @State private var center: CLLocationCoordinate2D
    @State private var radius: CLLocationDistance
    
    init(in center: CLLocationCoordinate2D,
         radius: CLLocationDistance = .infinity) {
        self.center = center
        self.radius = radius
    }
    
    public func searchCities(searchText: String) {
        request(resultType: .address, searchText: searchText)
    }
    
    public func searchPointOfInterests(searchText: String) {
        request(searchText: searchText)
    }
    
    
    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        request.region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] (response, _) in
            guard let response = response else {
                return
            }
            
            self?.localSearchPublisher.send(response.mapItems)
            
//            for item in response.mapItems {
//                if let name = item.name, let location = item.placemark.location {
//                    print("\(name): \(location.coordinate.latitude) \(location.coordinate.longitude)")
//                    
//                }
//            }
        }
    }
}
