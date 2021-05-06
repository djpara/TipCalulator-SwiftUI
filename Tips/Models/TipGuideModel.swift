//
//  TipGuideModel.swift
//  Tips
//
//  Created by David Para on 5/5/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI


struct TipGuideModel {
    var image: String?
    var service: String
    var suggestion: String
}

enum Services {
    static var list = [
        TipGuideModel(image: "server", service: "Server", suggestion: "15 - 20 percent"),
        TipGuideModel(image: "barber", service: "Barber/Stylist", suggestion: "20 percent"),
        TipGuideModel(image: "taxi", service: "Rideshare/Taxi", suggestion: "15 percent"),
        TipGuideModel(image: "fastfood", service: "Delivery", suggestion: "10 - 15 percent"),
        TipGuideModel(image: "manicure", service: "Mani/Pedi", suggestion: "15 percent"),
        TipGuideModel(image: "martini", service: "Bartender", suggestion: "$1 - $2 per drink"),
        TipGuideModel(image: "shower", service: "Car wash", suggestion: "$2 - $5"),
        TipGuideModel(image: "bunkbed", service: "Babysitter", suggestion: "20 percent"),
        TipGuideModel(image: "car", service: "Valet", suggestion: "$5"),
        TipGuideModel(image: "cafe", service: "Barista", suggestion: "$1"),
        TipGuideModel(image: "hotmeal", service: "Room service", suggestion: "15 - 20%"),
        TipGuideModel(image: "truck", service: "Movers", suggestion: "5 - 20%")
    ]
}
