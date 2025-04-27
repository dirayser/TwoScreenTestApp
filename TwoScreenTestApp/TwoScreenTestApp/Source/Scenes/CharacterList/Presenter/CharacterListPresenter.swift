//
//  CharacterListPresenter.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol CharacterListPresentationLogic {
  func presentCharacters(response: CharacterList.FetchCharacters.Response)
  func presentError(message: String)
}

class CharacterListPresenter: CharacterListPresentationLogic {
  
  weak var viewController: CharacterListDisplayLogic?
  
  private var networkObserver: NSObjectProtocol?
  
  init() {
    networkObserver = NotificationCenter.default.addObserver(
      forName: .networkStatusChanged,
      object: nil,
      queue: .main
    ) { [weak self] notification in
      guard let self = self else { return }
      // Извлекаем статус из userInfo
      if let isConnected = notification.userInfo?["isConnected"] as? Bool {
        self.viewController?.updateInternetStatus(isConnected: isConnected)
      }
    }
  }
  
  deinit {
    if let observer = networkObserver {
      NotificationCenter.default.removeObserver(observer)
    }
  }
  
  func presentCharacters(response: CharacterList.FetchCharacters.Response) {
    let viewModels = response.characters.map {
      CharacterList.FetchCharacters.ViewModel.Character(
        id: $0.id,
        name: $0.name,
        description: "\($0.status) - \($0.species) from \($0.origin.name)\n\nSome text for additional lines",
        imageURL: $0.image
      )
    }
    viewController?.displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel(
      characters: viewModels,
      isNextPage: response.isNextPage
    ))
  }
  
  func presentError(message: String) {
    viewController?.displayError(message: message)
  }
}

