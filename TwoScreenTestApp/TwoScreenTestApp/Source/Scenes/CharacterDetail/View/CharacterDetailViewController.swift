//
//  CharacterDetailViewController.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit

class CharacterDetailViewController: UIViewController {
  
  private let character: CharacterList.FetchCharacters.ViewModel.Character
  
  init(character: CharacterList.FetchCharacters.ViewModel.Character) {
    self.character = character
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = character.name
  }
}
