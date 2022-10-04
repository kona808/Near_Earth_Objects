//
//  NearEarthObject.swift
//  NeoiOS3
//
//  Created by Jacob Perez on 10/4/22.
//

import Foundation

class NearEarthObject {
    
    let name: String
    let designation: String
    let isWorldKiller: Bool
    
    init(name: String, designation: String, isWorldKiller: Bool) {
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKiller
    }
    
    // Failable Initializer, we want to make sure that our URL information matches. giving the dictionary, inputing the keys ourselves.
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name_limited"] as? String else { return nil }
        guard let designation = dictionary["designation"] as? String else { return nil }
        guard let isWorldKilled = dictionary["is_potentially_hazardous_asteroid"] as? Bool else { return nil }
        
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKilled
    }
    
} // End of class

/**
 {
    "links": {
        "next": "http://api.nasa.gov/neo/rest/v1/neo/browse?page=1&size=20&api_key=drR0UpEfhkT3uK1X9cylRucHCFAJ2mCboweHuFum",
        "self": "http://api.nasa.gov/neo/rest/v1/neo/browse?page=0&size=20&api_key=drR0UpEfhkT3uK1X9cylRucHCFAJ2mCboweHuFum"
    },
    "page": {
        "size": 20,
        "total_elements": 29364,
        "total_pages": 1469,
        "number": 0
    },
    "near_earth_objects": [
        {
            "links": {
                "self": "http://api.nasa.gov/neo/rest/v1/neo/2000433?api_key=drR0UpEfhkT3uK1X9cylRucHCFAJ2mCboweHuFum"
            },
            "id": "2000433",
            "neo_reference_id": "2000433",
            "name": "433 Eros (A898 PA)",
            "name_limited": "Eros",
            "designation": "433",
            "nasa_jpl_url": "http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=2000433",
            "absolute_magnitude_h": 10.31,
            "estimated_diameter": {
                "kilometers": {
                    "estimated_diameter_min": 23.0438466577,
                    "estimated_diameter_max": 51.5276075896
                },
                "meters": {
                    "estimated_diameter_min": 23043.8466576534,
                    "estimated_diameter_max": 51527.6075895943
                },
                "miles": {
                    "estimated_diameter_min": 14.3187780415,
                    "estimated_diameter_max": 32.0177610556
                },
                "feet": {
                    "estimated_diameter_min": 75603.1738682955,
                    "estimated_diameter_max": 169053.8360842445
                }
            },
            "is_potentially_hazardous_asteroid": false,
            "close_approach_data": [
                {
 **/
