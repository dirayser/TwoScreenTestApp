//
//  CharacterList.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

enum CharacterList {
  enum FetchCharacters {
    
    struct Request { }
    
    struct Response {
      let characters: [Character]
      let isNextPage: Bool
    }
    
    struct ViewModel {
      struct Character {
        let id: Int
        let name: String
        let description: String
        let imageURL: String
        var isExpanded: Bool = false
      }
      let characters: [Character]
      let isNextPage: Bool
    }
  }
}
