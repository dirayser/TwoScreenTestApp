//
//  CharacterListInteractor.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol CharacterListBusinessLogic {
  func fetchCharacters(request: CharacterList.FetchCharacters.Request)
}

class CharacterListInteractor: CharacterListBusinessLogic {
  
  var presenter: CharacterListPresentationLogic?
  private let service: RickAndMortyServiceProtocol = RickAndMortyService()
  
  private var isLoading = false
  private var currentPage = 1
  private var canLoadMore = true
  
  func fetchCharacters(request: CharacterList.FetchCharacters.Request) {
    guard !isLoading else { return }
    isLoading = true
    
    service.fetchCharacters(page: currentPage) { [weak self] result in
      guard let self else { return }
      self.isLoading = false
      
      switch result {
      case .success(let response):
        let hasNextPage = response.info.next != nil
        self.canLoadMore = hasNextPage
        self.presenter?.presentCharacters(response: CharacterList.FetchCharacters.Response(characters: response.results, isNextPage: hasNextPage))
        self.currentPage += 1
      case .failure(let error):
        self.presenter?.presentError(message: error.localizedDescription)
      }
    }
  }
}
