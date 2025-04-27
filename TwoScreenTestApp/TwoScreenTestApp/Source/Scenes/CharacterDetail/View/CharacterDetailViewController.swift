//
//  CharacterDetailViewController.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit
import SDWebImage

protocol CharacterDetailDisplayLogic: AnyObject {
  func displayCharacter(viewModel: CharacterDetail.ShowCharacter.ViewModel)
}

class CharacterDetailViewController: UIViewController {
  
  var interactor: CharacterDetailBusinessLogic?
  var router: (NSObjectProtocol & CharacterDetailRoutingLogic)?
  
  private let character: CharacterList.FetchCharacters.ViewModel.Character
  
  private let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let statusBadge: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontSizeToFitWidth = true
    return view
  }()
  
  private let speciesBadge: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontSizeToFitWidth = true
    return view
  }()
  
  
  private let characterImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let nameLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontSizeToFitWidth = true
    return view
  }()
  
  private let descriptionLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.adjustsFontSizeToFitWidth = false
    view.lineBreakMode = .byWordWrapping
    return view
  }()
  
  init(character: CharacterList.FetchCharacters.ViewModel.Character) {
    self.character = character
    super.init(nibName: nil, bundle: nil)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    interactor?.showCharacter(request: CharacterDetail.ShowCharacter.Request())
  }
  
  private func setup() {
    let viewController = self
    let interactor = CharacterDetailInteractor(character: character)
    let presenter = CharacterDetailPresenter()
    let router = CharacterDetailRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
  }
  
  private func setupUI() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    
    characterImageView.contentMode = .scaleAspectFill
    characterImageView.clipsToBounds = true
    characterImageView.layer.cornerRadius = 10
    
    nameLabel.font = .boldSystemFont(ofSize: 24)
    nameLabel.textAlignment = .center
    
    descriptionLabel.font = .systemFont(ofSize: 16)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textAlignment = .center
    
    statusBadge.font = .systemFont(ofSize: 14, weight: .medium)
    statusBadge.textColor = .white
    statusBadge.textAlignment = .center
    statusBadge.layer.cornerRadius = 12
    statusBadge.clipsToBounds = true
    statusBadge.backgroundColor = .gray
    
    speciesBadge.font = .systemFont(ofSize: 14, weight: .medium)
    speciesBadge.textColor = .white
    speciesBadge.textAlignment = .center
    speciesBadge.layer.cornerRadius = 12
    speciesBadge.clipsToBounds = true
    speciesBadge.backgroundColor = .darkGray
    
    let badgeStack = UIStackView(arrangedSubviews: [statusBadge, speciesBadge])
    badgeStack.axis = .horizontal
    badgeStack.spacing = 12
    badgeStack.alignment = .center
    badgeStack.distribution = .fillEqually
    
    let stack = UIStackView(arrangedSubviews: [characterImageView, nameLabel, badgeStack, descriptionLabel])
    stack.axis = .vertical
    stack.spacing = 16
    
    contentView.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    characterImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      characterImageView.heightAnchor.constraint(equalToConstant: 200),
      statusBadge.heightAnchor.constraint(equalToConstant: 24),
      speciesBadge.heightAnchor.constraint(equalToConstant: 24),
      
      stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}


extension CharacterDetailViewController: CharacterDetailDisplayLogic {
  func displayCharacter(viewModel: CharacterDetail.ShowCharacter.ViewModel) {
    title = viewModel.name
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description
    characterImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(systemName: "photo"))
    
    statusBadge.text = viewModel.status.uppercased()
    speciesBadge.text = viewModel.species.uppercased()
    
    switch viewModel.status.lowercased() {
    case "alive":
      statusBadge.backgroundColor = .systemGreen
    case "dead":
      statusBadge.backgroundColor = .systemRed
    default:
      statusBadge.backgroundColor = .systemGray
    }
  }
}
