//
//  GameService.swift
//  GeeGames
//
//  Created by Roman Bigun on 20.11.2023.
//

import Foundation
import Combine

class GamesService {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func gamesPublisher() -> AnyPublisher<[Game], Error> {
        
        guard
            let url = URL(string: "https://api.rawg.io/api/games?key=a716c6cb697f47dfa96b5013504dc76c")
            else { preconditionFailure("Can't create url...") }

        return session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Games.self, decoder: decoder)
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
