//
//  CharacterDetailInteractor.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol CharacterDetailBusinessLogic {
  func showCharacter(request: CharacterDetail.ShowCharacter.Request)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
  
  var presenter: CharacterDetailPresentationLogic?
  private let character: CharacterList.FetchCharacters.ViewModel.Character
  
  init(character: CharacterList.FetchCharacters.ViewModel.Character) {
    self.character = character
  }
  
  func showCharacter(request: CharacterDetail.ShowCharacter.Request) {
    let response = CharacterDetail.ShowCharacter.Response(character: character)
    presenter?.presentCharacter(response: response)
  }
}
