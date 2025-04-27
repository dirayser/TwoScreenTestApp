//
//  CharacterDetailPresenter.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

protocol CharacterDetailPresentationLogic {
  func presentCharacter(response: CharacterDetail.ShowCharacter.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
  
  weak var viewController: CharacterDetailDisplayLogic?
  
  func presentCharacter(response: CharacterDetail.ShowCharacter.Response) {
    let viewModel = CharacterDetail.ShowCharacter.ViewModel(
      name: response.character.name,
      description: response.character.description,
      imageURL: response.character.imageURL,
      status: extractStatus(from: response.character.description),
      species: extractSpecies(from: response.character.description)
    )
    viewController?.displayCharacter(viewModel: viewModel)
  }
  
  private func extractStatus(from description: String) -> String {
    let components = description.components(separatedBy: " - ")
    return components.first ?? "Unknown"
  }
  
  private func extractSpecies(from description: String) -> String {
    let components = description.components(separatedBy: " - ")
    guard components.count > 1 else { return "Unknown" }
    let speciesAndOrigin = components[1]
    let speciesComponents = speciesAndOrigin.components(separatedBy: " from ")
    return speciesComponents.first ?? "Unknown"
  }
  
}
