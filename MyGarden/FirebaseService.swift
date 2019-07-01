//
//  FirebaseService.swift
//  MyGarden
//
//  Created by Rodrigo Hilkner on 25/06/19.
//  Copyright © 2019 Filipe Marques. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseService {
    
    var ref: DatabaseReference!
    
    let interestingNumbers = [
        "Prime": [2, 3, 5, 7, 11, 13],
        "Fibonacci": [1, 1, 2, 3, 5, 8],
        "Square": [1, 4, 9, 16, 25]
    ]
    
    init() {
        ref = Database.database().reference()
    }
    
    func fetchData(completionHandler: @escaping (FetchedData?) -> Void) {
        ref.child("sensorData").queryOrderedByValue().queryLimited(toLast: 1).observe(.value, with: { (dataSnapshot) in
            if !dataSnapshot.exists() {
                print("Snapshot returned nil")
                completionHandler(nil)
                return
            }
            guard let snapVal = dataSnapshot.value as? [String : [String : Any]] else {
                print("Snapshot value returned nil")
                completionHandler(nil)
                return
            }
            
            guard let fetchedVal = snapVal.first?.value else {
                print("Snapshot empty")
                completionHandler(nil)
                return
            }
            
            print(fetchedVal)
            guard fetchedVal.keys.contains("timestamp"),
                fetchedVal.keys.contains("humidity"),
                fetchedVal.keys.contains("temperature"),
                fetchedVal.keys.contains("luminosity") else {
                print("Snapshot doesn't have all keys")
                completionHandler(nil)
                return
            }
            
            let fetchedData = FetchedData(timestamp: fetchedVal["timestamp"] as? Double ?? 0.0,
                                          humidity: fetchedVal["humidity"] as? Int ?? 0,
                                          temperature: fetchedVal["temperature"] as? Int ?? 0,
                                          luminosity: fetchedVal["luminosity"] as? Int ?? 0)
            
            completionHandler(fetchedData)
        })
    }
}
