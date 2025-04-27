//
//  CharacterDetailModels.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

enum CharacterDetail {
  
  enum ShowCharacter {
    struct Request { }
    
    struct Response {
      let character: CharacterList.FetchCharacters.ViewModel.Character
    }
    
    struct ViewModel {
      let name: String
      let description: String
      let imageURL: String
      let status: String
      let species: String
    }
  }
}
