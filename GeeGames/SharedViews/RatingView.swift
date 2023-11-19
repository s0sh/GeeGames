//
//  RatingView.swift
//  GeeGames
//
//  Created by Roman Bigun on 15.11.2023.
//

import SwiftUI

struct RatingView: View {
    @State var rating: Int
    var label = ""
    var maximumRating = 5.0
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = SwiftUI.Color.gray
    var onColor = SwiftUI.Color.yellow
    
    var body: some View {
        HStack {
            
            Text("\(rating)")
                .foregroundColor(SwiftUI.Color.blue)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                
            ForEach(1..<Int(maximumRating) + Int(Float(1.0)), id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > Int(rating) ? offColor : onColor)
                    
            }
            
            Text("of 5")
                .foregroundColor(SwiftUI.Color.blue)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating: 4)
}
