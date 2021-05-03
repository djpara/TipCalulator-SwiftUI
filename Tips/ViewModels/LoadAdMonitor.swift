//
//  LoadAdMonitor.swift
//  Tips
//
//  Created by David Para on 8/17/20.
//  Copyright © 2020 David Para. All rights reserved.
//

import SwiftUI

class LoadAdMonitor: ObservableObject {
    var timer: Timer?
    var bannerView: GoogleAdView
    
    init(bannerView: GoogleAdView) {
        self.bannerView = bannerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func refreshAd() {
        bannerView.loadNewRequest()
    }
    
    @objc private func applicationWillResignActive() {
        stopAdRefreshTimer()
    }
    
    @objc private func applicationWillEnterForeground() {
        startAdRefreshTimer()
    }
    
    func startAdRefreshTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.refreshAd()
        }
    }
    
    func stopAdRefreshTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}
