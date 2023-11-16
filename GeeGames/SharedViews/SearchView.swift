//
//  SearchView.swift
//  GeeGames
//
//  Created by Roman Bigun on 15.11.2023.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            
            // MARK: - offset from left
            Spacer(minLength: 10)
            
            HStack(spacing: 20) {
                
                Spacer(minLength: 5)
                
                Image("search")
                
                TextField("Enter game name", text: $searchText)
                
                Button(action: {
                    searchText = ""
                }, label: {
                    Image("close_square")
                })
                
                Spacer(minLength: 5)
            }
            .frame(height: 40)
            .background(SwiftUI.Color("main"))
            .cornerRadius(15)
            
            // MARK: - offset from right
            Spacer(minLength: 10)
        }
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
