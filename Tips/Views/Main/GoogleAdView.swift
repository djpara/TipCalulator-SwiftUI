//
//  GoogleAdView.swift
//  Tips
//
//  Created by David Para on 8/13/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI
import GoogleMobileAds

struct GoogleAdView: UIViewRepresentable {
    private(set) var banner: GADBannerView!
    
    init() {
        self.banner = GADBannerView(adSize: kGADAdSizeBanner)
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        #if DEBUG
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        banner.adUnitID = "ca-app-pub-3355942692533632/4770470286"
        #endif
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        loadNewRequest()
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) { }
    
    func loadNewRequest() {
        banner?.load(GADRequest())
    }
}
