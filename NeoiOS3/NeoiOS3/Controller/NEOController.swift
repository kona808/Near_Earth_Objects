//
//  NEOController.swift
//  NeoiOS3
//
//  Created by Jacob Perez on 10/4/22.
//

import Foundation

class NEOController {
    // SoT
    // var neos: [NearEarthObject] = [] /// If we used a boolean than we would need an SoT We completed the fetch with an array of NearEarthObject.
    
    private static let baseURLString = "https://api.nasa.gov/neo/rest/v1" /// Only read by this file because of private
    // Keys - create kets rather than hard coding strings of URL component.
    private static let keyNeoComponent = "neo"
    private static let keyBrowseComponent = "browse"
    private static let kApiKeyKey = "api_key"
    private static let keyApiKeyValue = "drR0UpEfhkT3uK1X9cylRucHCFAJ2mCboweHuFum"
    private static let neoArrayOfDict = "near_earth_objects"
    
    // CRUD /// Because we decided to complete with an array of NearEarthObject we do not need an SoT, completion handler informs me of when the feth function has completed its task.
    static func fetchNeos(completion: @escaping ([NearEarthObject]?) -> Void) {
        
        // Step 1: Create URL
        /// Return unwrapping but there are functions 
        guard let baseURL = URL(string: baseURLString) else { completion(nil); return }
        let neoURL = baseURL.appendingPathComponent(keyNeoComponent)
        /// New Swift way of writing appending:
        let browseURL = neoURL.appending(path: keyBrowseComponent)
        /// let
        // To use URL Query items you need A URLComponent class, you will ned a URLComponent Struct, that is the finalURL.
//        guard var urlComponents = URLComponents(url: browseURL, resolvingAgainstBaseURL: true) else { completion(nil); return }
        var urlComponents = URLComponents(url: browseURL, resolvingAgainstBaseURL: true)
        // Step 1.2: Query Item
        let apiQueryItem = URLQueryItem(name: kApiKeyKey, value: keyApiKeyValue)
        urlComponents?.queryItems = [apiQueryItem]
        
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
                guard let topLevelDictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any], // data is data unwrapped on 47
                // let name = topLevelDictionary [] is going to be sent from modelController.
                 let neosArray = topLevelDictionary[neoArrayOfDict] as? [[String: Any]] else { completion(nil); return }
                /// Create a temp array to hold onto these neos
                var tempNeoArray: [NearEarthObject] = []
                for neoDict in neosArray {
                    guard let neo = NearEarthObject(dictionary: neoDict) else { completion(nil); return }
                    tempNeoArray.append(neo) // self.neos.append(neo)
                }
                completion(tempNeoArray)
            }
        } .resume()
        // Step 3: Party!!
        
    }
} // END of class
