//
//  CharacterDetailRouter.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit

protocol CharacterDetailRoutingLogic { }

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic {
    
    weak var viewController: CharacterDetailViewController?
}
