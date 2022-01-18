//
//  Models.swift
//  MultipleSheets
//
//  Created by Apprenant 86 on 03/12/2021.
//

import Foundation

class User: ObservableObject {
    @Published var homeAddress: String = "Définir l'adresse"
    @Published var officeAddress: String = "Définir l'adresse"
    
    @Published var preferredTripType: PreferredTripType = .none
    @Published var preferredBikeType: PreferredBikeType = .none
    
    @Published var favorites: [Favorite] = []
}

extension User {
    static var globalUser = User()
}

struct Favorite {
    var place: Place
    var icon: IconeBookmark
}

struct Place: Identifiable, Hashable {
    var id = UUID()
    var name: String
    
    var address: String
    var latitude: Double = 0.0
    var longitude: Double = 0.0
//    var coordinates: mapkit.Coordinate

}
extension Place {
    static var domicile = Place(name: "Domicile", address: "3 rue de l'Etoile, 75012 Paris")
    static var travail = Place(name: "Travail", address: "17 rue de l'Etoile, 75012 Paris")
    
    // An array representing the favorite Places:
    static var bookmarks = [Place: IconeBookmark]()
}

struct Trip {
    
    var name: String
    var start: Place
    var end: Place
    
}

enum IconeBookmark: String {
    case star = "star"
    case heart = "heart.circle.fill"
    case fork = "fork"
    case cart = "cart"
}

enum PreferredBikeType: String, CaseIterable {
    case none = "Aucun"
    case myOwnBike = "Mon vélo perso"
    case publicSharedBike = "Un vélo partagé public (type Vélib)"
    case privateSharedBike = "Un vélo partagé privé (type Dott)"
}

enum PreferredTripType : String, CaseIterable {
    case none = "Aucun"
    case fast = "Rapide"
    case secure = "Sécurisé"
    case nice = "Agréable"
    case discovery = "Découverte"
}

enum DisruptionType {
    case publicWorks, accident, obstacle
}



struct Disruption {
    var lieu: Place
    var type: DisruptionType
    var heure: Date
    
}

enum StationType {
    case stationVelo, parkingVelo
}

struct Annotation {
    var type: StationType = .stationVelo
    var lieu: Place
}

struct StationVelo {
    
}

struct ParkingVelo {
    
}

struct Balade {
    
}
