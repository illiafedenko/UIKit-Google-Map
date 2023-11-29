//
//  CarModel.swift
//  test
//
//  Created by qwe on 10/18/23.
//

import Foundation
import UIKit
import ObjectMapper

struct CarModel:Mappable{
    
    var carImage: UIImage!
    var carType: String!
    var carPrice: String!
    var waitTime: String!
    var seat: String!
    
    init?(map: Map) {
        
    }
    
    init?() {
        
    }
    
    mutating func mapping(map: Map) {
        carImage <- map["carImage"]
        carType <- map["carType"]
        carPrice <- map["carPrice"]
        waitTime <- map["waitTime"]
        seat <- map["seat"]
    }
}
