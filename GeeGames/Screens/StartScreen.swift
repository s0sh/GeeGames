//
//  StartScreen.swift
//  GeeGames
//
//  Created by Roman Bigun on 21.11.2023.
//

import SwiftUI

struct StartScreen: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        NavigationView {
            SwiftUI.Color.black.overlay(
                    VStack {
                        
                        VStack {
                            Spacer()
                            Image("logo").resizable().frame(width: 200, height: 200)
                            Spacer()
                            HStack {
                                Text( try! AttributedString(
                                    markdown:"**Read our** *[Privacy Policy](https://example.com)*"))
                            }
                            .foregroundColor(.white)
                            .tint(.blue)
                            .padding(.bottom)
                            .frame(alignment: .leading)
                            .offset(x: -35)
                            Text( try! AttributedString(
                                markdown:"By tapping **Start now** button you agree to our *[Tirms & Policies](http://example.com)*"))
                            .lineLimit(2)
                            .foregroundColor(.white)
                            .tint(.blue)
                            .padding(.bottom)
                            .frame(width: 250)
                            NavigationLink(destination: {
                                ZStack {
                                    HomeContainerView().environmentObject(store)
                                        .navigationBarHidden(true)
                                    MenuView()
                                }
                                    
                            }, label: {
                                Text("Start now")
                                    .font(.system(size: 20, weight: .bold))
                                    .frame(width: 320, height: 60)
                                    .background(SwiftUI.Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(18)
                            })
                        }
                        .offset(y: -50)
                    }).frame(width:.infinity).ignoresSafeArea()
                }
    }
}

#Preview {
    StartScreen()
}
