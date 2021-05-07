//
//  TipGuideView.swift
//  Tips
//
//  Created by David Para on 5/5/21.
//  Copyright © 2021 David Para. All rights reserved.
//

import SwiftUI

struct TipGuideView: View {
    private var services = Services.list
    private var descriptionTextWidth: CGFloat {
        UIScreen.main.bounds.width/2
    }
    
    @Binding var isPresented: Bool
    @Binding var selectedTipPercentage: Double
    @Binding var customTipPercentage: Double?
    
    init(isPresented: Binding<Bool>, selectedTipPercentage: Binding<Double>, customTipPercentage: Binding<Double?>) {
        _isPresented = isPresented
        _selectedTipPercentage = selectedTipPercentage
        _customTipPercentage = customTipPercentage
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Here's an idea of what you might consider an appropriate tip. When in doubt, just ask!")
                    .frame(width: descriptionTextWidth)
                    .font(.caption)
                    .padding([.top], 16)
                    .multilineTextAlignment(.center)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())],
                              spacing: 32) {
                        ForEach(0..<Services.list.count) {
                            ServiceView(isPresented: $isPresented,
                                        selectedTipPercentage: $selectedTipPercentage,
                                        customTipPercentage: $customTipPercentage,
                                        service: services[$0])
                        }
                    }.padding()
                }
            }.navigationBarTitle("Now sure how much to tip?", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    UIApplication.closeAllKeyboards(.shared)
                    self.isPresented.toggle()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
        }
    }
}

struct ServiceView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTipPercentage: Double
    @Binding var customTipPercentage: Double?
    
    var service: TipGuideModel
    
    var body: some View {
        VStack {
            if let imageName = service.image {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .padding()
                    .onTapGesture {
                        selectedTipPercentage = -1
                        customTipPercentage = service.min
                        isPresented.toggle()
                    }
            }
            Text(service.service).font(.headline)
            Spacer()
            Text(service.suggestion)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct TipGuideView_Previews: PreviewProvider {
    static var previews: some View {
        TipGuideView(isPresented: .constant(true),
                     selectedTipPercentage: .constant(0),
                     customTipPercentage: .constant(0))
    }
}
