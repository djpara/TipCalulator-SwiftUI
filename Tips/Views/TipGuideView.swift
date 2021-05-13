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
    
    private let amountViewModel: AmountViewModel
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, amountViewModel: AmountViewModel) {
        _isPresented = isPresented
        self.amountViewModel = amountViewModel
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
                                        service: services[$0],
                                        amountViewModel: amountViewModel)
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
    
    let service: TipGuideModel
    let amountViewModel: AmountViewModel
    
    var body: some View {
        VStack {
            if let imageName = service.image {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .padding()
                    .onTapGesture {
                        amountViewModel.tipPercentage = service.min ?? 0
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

#if DEBUG
struct TipGuideView_Previews: PreviewProvider {
    static var previews: some View {
        let amountViewModel = AmountViewModel(originalAmount: "",
                                              currencyFormatter: .makeCurrencyFormatter(using: .current))
        TipGuideView(isPresented: .constant(true), amountViewModel: amountViewModel)
    }
}
#endif
