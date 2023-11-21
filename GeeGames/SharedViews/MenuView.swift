//
//  MenuView.swift
//  Taski
//
//  Created by Roman Bigun on 08.11.2023.
//

import SwiftUI

enum MenuItems: Int, CaseIterable{
    case home = 0
    case favorite
    case genres
    case settings
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorites"
        case .genres:
            return "Genres"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .favorite:
            return "heart"
        case .genres:
            return "stack"
        case .settings:
            return "settings"
        }
    }
}

struct MenuView: View {
    
    @State var selectedTab = 0
    let systemImage = Image(systemName: "gear")
    
    var body: some View {
        
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    HomeView(onCommit: nil, isPrev: nil)
                        .tag(0)
                    FavoriteView()
                        .tag(1)
                    GenresView()
                        .tag(2)
                    SettingsView()
                        .tag(3)
                }
               // .tabViewStyle(.page(indexDisplayMode: .never))
                
                ZStack{
                    HStack{
                       
                        ForEach((MenuItems.allCases), id: \.self){ item in
                            Button{
                                selectedTab = item.rawValue
                            } label: {
                                
                                CustomTabItem(imageName: item.iconName,
                                              title: item.title,
                                              isActive: (selectedTab == item.rawValue), isAdd: false)
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(SwiftUI.Color.blue)
                .cornerRadius(35)
                .padding(.horizontal, 26)
                .shadow(radius: 25, x: 3, y: 3)
            }
    }

}

extension MenuView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool, isAdd: Bool = false) -> some View {
         
        HStack(spacing: 10 ){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.none)
                .foregroundColor(isActive ? .white : .gray)
                .frame(width: isAdd ? CGFloat(70) : CGFloat(30),
                       height: isAdd ? CGFloat(70) : CGFloat(30))
            
            Spacer()
        }
        .frame(width: isActive ? 80 : 50, height: 50)
        .background(isActive ? (isAdd ?
                                SwiftUI.Color("selectedDataBackground") :
                                .white) : .clear)
        .cornerRadius(30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
