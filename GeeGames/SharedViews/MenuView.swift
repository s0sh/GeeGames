//
//  MenuView.swift
//  Taski
//
//  Created by Roman Bigun on 08.11.2023.
//

import SwiftUI

enum MenuItems: Int, CaseIterable{
    case home = 0
    case task
    case add
    case settings
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .task:
            return "Task"
        case .add:
            return "Add"
        case .settings:
            return "Settings"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .task:
            return "backword"
        case .add:
            return "forward"
        case .settings:
            return "settings"
        case .profile:
            return "profile"
        }
    }
}

struct MenuView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    HomeView(isPrev: nil)
                        .tag(0)
                    HomeView(isPrev: true)
                        .tag(1)
                    HomeView(isPrev: false)
                        .tag(2)
                    SettingsView()
                        .tag(3)
                    ProfileView()
                        .tag(4)
                }
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
                .background(SwiftUI.Color("main"))
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
