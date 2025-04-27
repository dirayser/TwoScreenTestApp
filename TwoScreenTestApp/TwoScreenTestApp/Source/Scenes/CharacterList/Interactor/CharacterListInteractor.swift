//
//  CharacterListInteractor.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol CharacterListBusinessLogic {
  func fetchCharacters(request: CharacterList.FetchCharacters.Request, onScroll: Bool)
}

class CharacterListInteractor: CharacterListBusinessLogic {
  
  var presenter: CharacterListPresentationLogic?
  private let service: RickAndMortyServiceProtocol = RickAndMortyService()
  
  private let storageService: StorageServiceProtocol = StorageService()
  
  private var isLoading = false
  private var currentPage = 1
  private var canLoadMore = true
  
  func fetchCharacters(request: CharacterList.FetchCharacters.Request, onScroll: Bool) {
    guard !isLoading else { return }
    
    if ReachabilityService.shared.isConnected {
      isLoading = true
      service.fetchCharacters(page: currentPage) { [weak self] result in
        guard let self else { return }
        self.isLoading = false
        
        switch result {
        case .success(let response):
          self.canLoadMore = response.info.next != nil
          let characters = response.results
          
          self.storageService.saveCharacters(characters)
          self.presenter?.presentCharacters(response: CharacterList.FetchCharacters.Response(
            characters: characters,
            isNextPage: self.canLoadMore
          ))
          self.currentPage += 1
        case .failure(let error):
          self.presenter?.presentError(message: error.localizedDescription)
        }
      }
    } else if !onScroll {
      let characters = storageService.fetchCharacters()
      self.canLoadMore = false
      self.presenter?.presentCharacters(response: CharacterList.FetchCharacters.Response(
        characters: characters,
        isNextPage: false
      ))
    }
  }
  
}
