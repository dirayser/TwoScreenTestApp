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
  
  private var animator = DetailPushAnimator()
  
  func routeToCharacterDetail(character: CharacterList.FetchCharacters.ViewModel.Character) {
    let detailVC = CharacterDetailViewController(character: character)
    viewController?.navigationController?.delegate = self
    viewController?.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}

extension CharacterListRouter: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if operation == .push {
      return animator
    } else {
      return nil
    }
  }
  
}
