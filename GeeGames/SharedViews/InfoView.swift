//
//  InfoView.swift
//  GeeGames
//
//  Created by Roman Bigun on 17.11.2023.
//

import SwiftUI

extension View {
    func messageView(text: Binding<String>) -> some View {
        self.modifier(MessageViewModifier(text: text))
    }
}

struct MessageViewModifier: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            MessageView(text: $text)
        }
    }
}

struct MessageView: View {
    
    @Binding var text: String
    @State var visibleErrorText: String = ""
    let padding: CGFloat = 5.0
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            //only show the error view if the visibleErrorText String is not empty:
            if visibleErrorText.count > 0 {
                HStack(alignment: .center) {
                    Spacer()
                    Text(visibleErrorText)
                        .foregroundColor(SwiftUI.Color.white)
                        .multilineTextAlignment(.center)
                        .padding(15)
                    Spacer()
                }
                .background(SwiftUI.Color.red)
                .cornerRadius(10)
                .shadow(radius: 24)
                .padding(.vertical, 5)
                .padding(.horizontal, 24)
                //this transition dictates how the box appears and disappears.  The animation is described in .onChange below
                .transition(.asymmetric(insertion: AnyTransition.opacity
                                                .combined(with: AnyTransition.move(edge: .top)),
                                            removal: AnyTransition.opacity
                                                .combined(with: AnyTransition.move(edge: .top))))
            }
            Spacer()
            //check the @Binding text property for changes.  if one comes in, set it on our visibleErrorText property
            //then create a timer to make the errorview disappear in 3 seconds.
        }.onChange(of: text) { newValue in
            withAnimation {
                self.visibleErrorText = newValue
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                    withAnimation {
                        self.visibleErrorText = ""
                        self.text = ""
                    }
                }
            }
        }
    }
}
