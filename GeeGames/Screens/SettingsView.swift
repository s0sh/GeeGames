//
//  SettingsView.swift
//  GeeGames
//
//  Created by Roman Bigun on 21.11.2023.
//

import SwiftUI
import StoreKit

struct MenuItemView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .background(SwiftUI.Color.clear)
                .foregroundColor(.yellow)
                .padding([.leading, .trailing])
            if title.contains("Contact") {
                Text("[Contact Us](mailto:apple@apple.com)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .tint(.white)
            } else if title.contains("Privacy") {
                Text("[Privacy](http://apple.com)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .tint(.white)
            }
            else {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .frame(width: 320, height: 65)
        .background(SwiftUI.Color("settings_item_bg"))
        .cornerRadius(14)
        
            
    }
}

struct SettingsView: View {
   
    var body: some View {
        SwiftUI.Color.black.overlay (
            VStack {
                MenuItemView(title: "Rate the App", imageName: "star")
                    .padding(.bottom)
                    .onTapGesture {
                        SKStoreReviewController.requestReview()
                    }
                MenuItemView(title: "Contact Us", imageName: "mail")
                    .padding(.bottom)
                    .onTapGesture {
                        
                    }
                MenuItemView(title: "Privacy", imageName: "doc")
                    .padding(.bottom)
                MenuItemView(title: "Share the App", imageName: "square.and.arrow.up")
                    .padding(.bottom)
            }
            
        ).ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
