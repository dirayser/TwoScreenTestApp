//
//  RickAndMortyService.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol RickAndMortyServiceProtocol {
  func fetchCharacters(page: Int, completion: @escaping (Result<CharacterResponse, Error>) -> Void)
}

class RickAndMortyService: RickAndMortyServiceProtocol {
  
  private enum Constants {
    static let baseURL = "https://rickandmortyapi.com/api/character"
  }
  
  private let httpService: HttpServiceProtocol
  
  init(httpService: HttpServiceProtocol = HttpService()) {
    self.httpService = httpService
  }
  
  func fetchCharacters(page: Int = 1, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
    let parameters = ["page": page]
    httpService.get(url: Constants.baseURL, parameters: parameters, completion: completion)
  }
}
