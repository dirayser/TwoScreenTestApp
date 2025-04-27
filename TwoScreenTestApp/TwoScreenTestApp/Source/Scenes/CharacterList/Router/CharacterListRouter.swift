//
//  CharacterListRouter.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit

protocol CharacterListRoutingLogic {
  func routeToCharacterDetail(character: CharacterList.FetchCharacters.ViewModel.Character)
}

class CharacterListRouter: NSObject, CharacterListRoutingLogic {
  
  weak var viewController: CharacterListViewController?
  
  func routeToCharacterDetail(character: CharacterList.FetchCharacters.ViewModel.Character) {
    let detailVC = CharacterDetailViewController(character: character)
    viewController?.navigationController?.pushViewController(detailVC, animated: true)
  }
}
