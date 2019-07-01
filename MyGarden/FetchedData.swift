//
//  FetchedData.swift
//  MyGarden
//
//  Created by Rodrigo Hilkner on 25/06/19.
//  Copyright © 2019 Filipe Marques. All rights reserved.
//

import Foundation

struct FetchedData {
    var timestamp: Double
    var humidity: Int
    var temperature: Int
    var luminosity: Int
    var dateString: String {
        get {
            let date = Date(timeIntervalSince1970: self.timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            return strDate
        }
    }
}
