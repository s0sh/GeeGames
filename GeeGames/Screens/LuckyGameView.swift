//
//  LuckyGameView.swift
//  GeeGames
//
//  Created by Roman Bigun on 21.11.2023.
//

import SwiftUI

//struct Card: View {
//    let characters = Array("123456789")
//    @State private var enable = false
//    @State private var dragValue = CGSize.zero
//    var body: some View {
//
//            HStack(spacing: 0) {
//                ForEach(0..<characters.count) { num in
//                    Text(String(characters[num]))
//                        .padding(6)
//                        .font(.title)
//                        .background(enable ?
//                                    SwiftUI.Color.brown :
//                                        SwiftUI.Color.green)
//                        .offset(dragValue)
//                        .foregroundColor(.white)
//                        .animation(Animation.default
//                            .delay(Double(num) / 10))
//                }
//            }.gesture(DragGesture()
//                .onChanged { dragValue = $0.translation }
//                .onEnded { _ in
//                    dragValue = .zero
//                    enable.toggle()
//                }
//            )
//        }
//}

struct Card: View {
    
    @Binding var genreSelected: Bool
    @Binding var gameFirst: Game?
    @Binding var gameSecond: Game?
    
    var body: some View {
        SwiftUI.Color.black.overlay(
            HStack(spacing: 25) {
                // MARK: -  First game
                ZStack {
                    VStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 150, height: 250)
                            .background(ImageView(urlString: gameFirst?.backgroundImage))
                            .shadow(color: .white, radius: 10, x: 1, y: 1)
                        
                        Text(gameFirst?.name ?? "Comming...").foregroundColor(.white)
                        
                    }
                    if gameFirst == nil && genreSelected == true {
                        CircularProgressView()
                    }
                    
                }
                // MARK: Second game
                ZStack {
                    VStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 150, height: 250)
                            .background(ImageView(urlString: gameSecond?.backgroundImage))
                            .shadow(color: .white, radius: 10, x: 1, y: 1)
                        
                        Text(gameSecond?.name ?? "Comming...").foregroundColor(.white)
                        
                    }
                    if gameSecond == nil && genreSelected == true {
                        CircularProgressView()
                    }
                }
            }
        ).ignoresSafeArea()
    }
}

struct CircularProgressView: View {
    let viewWidth: CGFloat = 100
    let backgroundCircleLineWidth: CGFloat = UIScreen.main.bounds.width * 0.025
    let foregroundCircleLineWidth: CGFloat = UIScreen.main.bounds.width * 0.02
    @State var rotationDegree: Angle = Angle.degrees(0)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 3))
                .fill(SwiftUI.Color.purple)
            
            Circle()
                .trim(from: 0, to: 0.15)
                .stroke(style: StrokeStyle(lineWidth: foregroundCircleLineWidth, lineCap: .round))
                .fill(SwiftUI.Color.red)
                .rotationEffect(self.rotationDegree)
            Text("Randomize...")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
            
        }
        .frame(width: viewWidth, height: viewWidth)
        .onAppear() {
            DispatchQueue.main.async {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    self.rotationDegree = .degrees(720)
                }
            }
        }
    }
    
    
    func animateLoader() {
        self.rotationDegree = .degrees(720)
    }
}

struct LuckyGameView: View {
    @State var genreSelected = false
    @State var gameFirst: Game?
    @State var gameSecond: Game?
    @State private var hasTimeElapsed = false
    
    @EnvironmentObject var viewModel: GamesListViewModel
    
    var body: some View {
        SwiftUI.Color("AccentColor").overlay(
            VStack {
                Card(genreSelected: $genreSelected,
                     gameFirst: $gameFirst,
                     gameSecond: $gameSecond).padding(50)
                Spacer()
                Button(action: {
                    Task {
                        if !hasTimeElapsed {
                            genreSelected = true
                            await delayTask()
                            hasTimeElapsed = false
                        }
                    }
                }, label: {
                    Text("Randomize")
                        .frame(width: 250, height: 60)
                        .foregroundColor(.white)
                        .background(SwiftUI.Color("settings_item_bg"))
                        .cornerRadius(14)
                        .font(.system(size: 18, weight: .bold))
                }).offset(y: -100)
                Spacer()
            }
            
        ).ignoresSafeArea()
    }
    
    private func delayTask() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        hasTimeElapsed = true
        gameFirst = viewModel.gamesInfo[Int(arc4random())%20]
        gameSecond = viewModel.gamesInfo[Int(arc4random())%20]
    }
}

#Preview {
    LuckyGameView()
}
