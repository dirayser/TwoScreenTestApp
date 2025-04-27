//
//  CharacterResponse.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import Foundation

struct CharacterResponse: Decodable {
  let info: CharacterResponseInfo
  let results: [Character]
}

struct CharacterResponseInfo: Decodable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct Character: Decodable {
  struct Origin: Decodable {
    let name: String
  }
  
  struct Location: Decodable {
    let name: String
  }
  
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: String
  let origin: Origin
  let location: Location
  let image: String
}
