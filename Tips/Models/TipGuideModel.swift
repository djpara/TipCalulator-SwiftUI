//
//  TipGuideModel.swift
//  Tips
//
//  Created by David Para on 5/5/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI


struct TipGuideModel {
    var service: String
    var suggestion: String
    var image: String?
    var min: Double?
}

enum Services {
    static var list = [
        TipGuideModel(service: "15 - 20%", suggestion: "Server", image: "server", min: 15),
        TipGuideModel(service: "20%", suggestion: "Barber/Stylist", image: "barber", min: 20),
        TipGuideModel(service: "15%", suggestion: "Rideshare/Taxi", image: "taxi", min: 15),
        TipGuideModel(service: "10 - 15%", suggestion: "Delivery", image: "fastfood", min: 10),
        TipGuideModel(service: "15%", suggestion: "Mani/Pedi", image: "manicure", min: 15),
        TipGuideModel(service: "$1 - $2 per drink", suggestion: "Bartender", image: "martini", min: 0),
        TipGuideModel(service: "$2 - $5", suggestion: "Car wash", image: "shower", min: 0),
        TipGuideModel(service: "20%", suggestion: "Babysitter", image: "bunkbed", min: 20),
        TipGuideModel(service: "$5", suggestion: "Valet", image: "car", min: 0),
        TipGuideModel(service: "$1", suggestion: "Barista", image: "cafe", min: 0),
        TipGuideModel(service: "15 - 20%", suggestion: "Room service", image: "hotmeal", min: 15),
        TipGuideModel(service: "5 - 20%", suggestion: "Movers", image: "truck", min: 5)
    ]
}
