//
//  Location.swift
//  Test
//
//  Created by Justin Zaw on 24/04/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import Foundation
import SwiftyJSON

class Geolocation: NSObject {
   var latitude : Double?
   var longitude : Double?
    
     init(latitude:Double?,longitude:Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    class func initWith(json: JSON) -> Geolocation {
        let obj = Geolocation(latitude: json["latitude"].doubleValue, longitude: json["longitude"].doubleValue)
        
        return obj
    }
    
    class func createListgeolocation(json: JSON) -> NSArray{

        let list = NSMutableArray()
        let jsonArray = json.arrayValue
        for json in jsonArray {
            let data = Geolocation.initWith(json: json)
            list.add(data)
        }
        return list as NSArray
    }

    
}

class Location: NSObject {
    
    var id: Int?
    var job_id: Int?
    var company:String?
    var address:String?
    var geolocation: NSDictionary?
    
    
    init(id:Int?,job_id:Int?,company:String?,address:String?,geolocation:NSDictionary?) {
    self.id = id
    self.job_id = job_id
    self.company = company
    self.address = address
    self.geolocation = geolocation
        }
    
    class func initWith(json: JSON) -> Location{
        let obj = Location(id: json["id"].intValue, job_id: json["job-id"].intValue, company: json["company"].stringValue, address: json["address"].stringValue,geolocation: json["geolocation"].dictionaryObject as NSDictionary?)
        
        return obj
    }
    
    class func createListLocation(json: JSON) -> NSArray{
        
        let list = NSMutableArray()
        let jsonArray = json.arrayValue
        for json in jsonArray {
            let data = Location.initWith(json: json)
            list.add(data)
        }
        return list as NSArray
    }
    
}


