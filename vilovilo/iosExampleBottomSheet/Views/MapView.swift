//
//  MapView.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    
    
    var forDisplay = loadJson(filename: "station_information")?.data.stations
    
    @Binding var region: MKCoordinateRegion
    
    @Binding var locationManager: CLLocationManager
    
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    
    @Binding var showDefaultTrip: Bool
    
    @Binding var showStations: Bool
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        /// showing annotation on the map
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
//            return AnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.ReuseID)
//        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
                // 1
                guard let annotation = annotation as? LandmarkAnnotation else { return nil }

                // 2
                let identifier = "Capital"

                // 3
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

                if annotationView == nil {
                    //4
                    annotationView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    annotationView?.canShowCallout = true

                    // 5
                    let btn = UIButton(type: .detailDisclosure)
                    annotationView?.rightCalloutAccessoryView = btn
                } else {
                    // 6
                    annotationView?.annotation = annotation
                }

                return annotationView
                
            
        }
        
       func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                   let renderer = MKPolylineRenderer(overlay: overlay)
                   renderer.strokeColor = UIColor(Color("blueVilo"))
                   renderer.lineWidth = 5
                   return renderer
               }
        
        
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        MapView.Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        ///  creating a map
        let view = MKMapView()
        view.showsCompass = false
        view.showsUserLocation = true
        view.userTrackingMode = .follow
        /// connecting delegate with the map
        view.delegate = context.coordinator
        view.setRegion(region, animated: false)
        view.mapType = .standard
        
        
//
//        for points in forDisplay! {
//            let annotation = LandmarkAnnotation(coordinate: points.coordinate, title: points.name, subtitle: points.idString)
//
//            view.addAnnotation(annotation)
//        }
        
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.showsUserLocation = true
//        self.locationManager.requestWhenInUseAuthorization()
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
        
        if showDefaultTrip {
            
            uiView.removeAnnotations(uiView.annotations)

            uiView.removeOverlays(uiView.overlays)
            
            
            let p1 = MKPlacemark(coordinate: MapDetails.parisLocation)

            let p2 = MKPlacemark(coordinate: MapDetails.pizzaLocation)

            let request = MKDirections.Request()

            request.source = MKMapItem(placemark: p1)
            request.destination = MKMapItem(placemark: p2)
            request.transportType = .walking

            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
                uiView.addAnnotations([p1, p2])
                uiView.addOverlay(route.polyline)
                uiView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
//                self.directions = route.steps.map { $0.instructions}.filter {!$0.isEmpty}



            }


            showDefaultTrip.toggle()
        }
        
        if showStations {
            
            if !showDefaultTrip {
            
            uiView.removeAnnotations(uiView.annotations)

            uiView.removeOverlays(uiView.overlays)
            
            for points in forDisplay! {
                let annotation = LandmarkAnnotation(coordinate: points.coordinate, title: points.name, subtitle: points.idString)
                uiView.addAnnotation(annotation)
            }
                
            }
        }
        
        

        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
}
    


struct SampleData: Identifiable {
    var id = UUID()
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}

var data = [
    SampleData(latitude: 43.70564024126748, longitude: 142.37968945214223),
    SampleData(latitude: 43.81257464206404, longitude: 142.82112322464369),
    SampleData(latitude: 43.38416585162576, longitude: 141.7252598737476),
    SampleData(latitude: 45.29168643283501, longitude: 141.95286751470724),
    SampleData(latitude: 45.49261392585982, longitude: 141.9343973160499),
    SampleData(latitude: 44.69825427301145, longitude: 141.91227845284203)
]


class LandmarkAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(
        coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?
    ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}


/// here posible to customize annotation view
let clusterID = "clustering"

class AnnotationView: MKMarkerAnnotationView {
    
    static let ReuseID = "cultureAnnotation"
    
    /// setting the key for clustering annotations
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = clusterID
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
    }
}

