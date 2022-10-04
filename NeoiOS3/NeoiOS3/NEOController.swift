//
//  NEOController.swift
//  NeoiOS3
//
//  Created by Jacob Perez on 10/4/22.
//

import Foundation

class NEOController {
    // SoT
    var neos: [NearEarthObject] = []
    
    private static let baseURLString = "https://api.nasa.gov/neo/rest/v1" // Only read by this file beacause of private
    // Keys
    private static let keyNeoComponent = "neo"
    private static let keyBrowseComponent = "browse"
    private static let kApiKeyKey = "api_key"
    private static let keyApiKeyValue = "drR0UpEfhkT3uK1X9cylRucHCFAJ2mCboweHuFum"
    
    // CRUD
    static func fetchNeos(completion: @escaping ([NearEarthObject]?) -> Void) {
        
        // Step 1: Create URL
        guard let baseURL = URL(string: baseURLString) else { completion(nil); return }
        let neoURL = baseURL.appendingPathComponent(keyNeoComponent)
        let browseURL = neoURL.appendingPathExtension(keyBrowseComponent)
        
        // To use URL Query items you need A URLComponent class
        var urlComponents = URLComponents(url: browseURL, resolvingAgainstBaseURL: true)
        // Step 1.2:
        let apiQueryItem = URLQueryItem(name: kApiKeyKey, value: keyApiKeyValue)
        urlComponents?.queryItems? = [apiQueryItem]
        
        guard let finalURL = urlComponents?.url else { completion(nil); return }
        print(finalURL)
        // Step 2: Start a data task to retrieve that data
        
        URLSession.shared.dataTask(with: finalURL) { neoData, _, error in
            // Handle the error
            if let error = error {
                print("There is an error with the dataTask", error.localizedDescription)
                completion(nil)
            }
            
            // Check for data / Parse in handling. /// Take data and send it to the modelController to deal wiht the data.
            guard let data = neoData else { completion(nil); return }
            
            // Now that I have data I can convert that data to a JSON object
            do {
                let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) // data is data unwrapped on 47
                // let name = topLevelDictionary [] is going to be sent from modelController.
                let neo = NearEarthObject(name: <#T##String#>, designation: <#T##String#>, isWorldKiller: <#T##Bool#>)
            } catch {
            }
        }
        // Step 3: Party!!
        
    }
} // END of class
