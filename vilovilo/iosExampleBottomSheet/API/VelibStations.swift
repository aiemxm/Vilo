//
//  VelibStations.swift
//  SwiftAnnotation
//
//  Created by Apprenant 86 on 14/12/2021.
//

import Foundation
import CoreLocation

// MARK: - VelibLatLong
struct VelibLatLong: Codable {
    let data: DataClass
    let lastUpdatedOther: Int
    let ttl: Int

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case lastUpdatedOther = "lastUpdatedOther"
        case ttl = "ttl"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let stations: [Station]

    enum CodingKeys: String, CodingKey {
        case stations = "stations"
    }
}

// MARK: - Station
struct Station: Codable, Identifiable {
    var id: Int // for conforming with Identifiable protocol
    
    var idString: String {
        String(id)
    }
    
    let capacity: Int
    let lat: Double
    let lon: Double
    var coordinate: CLLocationCoordinate2D { .init(latitude: lat,longitude: lon) }
    let name: String
//    let stationID: Int

    enum CodingKeys: String, CodingKey {
        case capacity = "capacity"
        case lat = "lat"
        case lon = "lon"
        case name = "name"
        case id = "station_id"
    }
}

func loadJson(filename fileName: String) -> VelibLatLong? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(VelibLatLong.self, from: data)
            dump(jsonData)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
