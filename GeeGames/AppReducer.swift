//
//  AppReducer.swift
//  GeeGames
//
//  Created by Roman Bigun on 20.11.2023.
//

import Foundation
import Combine
import SwiftUI

struct World {
    var service = GamesService()
}

typealias Reducer<State, Action, Environment> =
    (inout State, Action, Environment) -> AnyPublisher<Action, Never>?

func appReducer(state: inout AppState, 
                action: AppAction,
                environment: World) -> AnyPublisher<AppAction, Never>? {
    switch action {
    case .setResult(let games):
        state.loadedGames = games
    case .getGameInfo:
        return environment.service
            .gamesPublisher()
            .replaceError(with: [])
            .map { AppAction.setResult(games: $0) }
            .eraseToAnyPublisher()
    }
    return Empty().eraseToAnyPublisher()
}

